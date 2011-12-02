//
//	JXInvisiCharLayoutManager.m
//	
//
//	Created by Jan on 02.12.11.
//	Copyright 2011 geheimwerk.de. All rights reserved.
//

#import "JXInvisiCharLayoutManager.h"

typedef struct _JXUnicharMappingStruct {
	unichar invisible;
	unichar replacement;
} JXUnicharMappingStruct;

JXUnicharMappingStruct JXInvisiCharToCharMap[] = {
	//	invisible	replacement
	{	 ' ',		0x002E}, // ordinary space	TO	ordinary full stop; alternatives: one dot leader (0x2024), small full stop (0xFE52)
	{	'\t',		0x21E5}, // tab				TO	rightwards arrow to bar; alternatives: rightwards arrow (0x2192), rightwards dashed arrow (0x21E2)
	{	'\n',		0x00B6}, // new line		TO	pilcrow sign
	{	'\r',		0x204B}, // carriage return	TO	reversed pilcrow sign
};

@implementation JXInvisiCharLayoutManager

- (id)init;
{
	self = [super init];
	
	if (self) {
		_invisibleCharacterColor = [[NSColor lightGrayColor] retain];
		
		_showInvisibleCharacters = YES;
		
		// Prepare _unicharMap
		CFIndex charToInvisiCharMapCount = sizeof(JXInvisiCharToCharMap)/sizeof(JXUnicharMappingStruct);
		
		CFMutableDictionaryRef unicharMap = CFDictionaryCreateMutable(kCFAllocatorDefault, charToInvisiCharMapCount, NULL, &kCFTypeDictionaryValueCallBacks); // keys: unichar, values: NSString

		for (CFIndex i = 0; i < charToInvisiCharMapCount; i++) {
			CFDictionaryAddValue(unicharMap, 
								 (const void *)(CFIndex)JXInvisiCharToCharMap[i].invisible, 
								 (const void *)[NSString stringWithCharacters:&(JXInvisiCharToCharMap[i].replacement) length:1]);
		}
		
		//CFShow(unicharMap);
		
		_unicharMap = CFDictionaryCreateCopy(kCFAllocatorDefault, unicharMap); // Create an immutable copy
		CFRelease(unicharMap);
	}
	
	return self;
}

- (void)dealloc {
	[_invisibleCharacterColor release];
	
	CFRelease(_unicharMap);
	
	[super dealloc];
}


// Based on Peter Borg’s answer to “Invisible characters in NSTextView”
// http://www.cocoabuilder.com/archive/cocoa/124811-invisible-characters-in-nstextview.html

- (void)drawGlyphsForGlyphRange:(NSRange)glyphRange atPoint:(NSPoint)containerOrigin
{
	if (_showInvisibleCharacters) {
		NSTextStorage *textStorage = [self textStorage];
		NSPoint pointToDrawAt = NSZeroPoint;
		NSRect glyphRect = NSZeroRect;
		NSString *completeString = [[self textStorage] string];
		NSUInteger lengthToRedraw = NSMaxRange(glyphRange);
		NSUInteger characterIndex, prevCharacterIndex = NSUIntegerMax;
		unichar characterToCheck;
		NSString *stringToDraw;
		NSMutableDictionary *currentAttributes = nil;
		NSRange attributesEffectiveRange = NSMakeRange(NSUIntegerMax, 0);
		
		for (NSUInteger index = glyphRange.location; index < lengthToRedraw; index++) {
			// For characters consisting of several glyphs, the following will return the same index for consecutive iterations.
			characterIndex = [self characterIndexForGlyphAtIndex:index]; 
			characterToCheck = [completeString characterAtIndex:characterIndex];
			
			// Check if we have processed this character this already
			if (characterIndex != prevCharacterIndex) {
				
				// Map the character to its visible replacement
				stringToDraw = (NSString *)CFDictionaryGetValue(_unicharMap, (const void *)(CFIndex)characterToCheck);
				
				if (stringToDraw != nil) {
					pointToDrawAt = [self locationForGlyphAtIndex:index];
					glyphRect = [self lineFragmentRectForGlyphAtIndex:index effectiveRange:NULL];
					pointToDrawAt.x += glyphRect.origin.x;
					pointToDrawAt.y = glyphRect.origin.y;
					
					// Check if we need to generate attributes for this location
					if ((currentAttributes == nil) 
						|| !(NSLocationInRange(characterIndex, attributesEffectiveRange))) {
						[currentAttributes release];
						currentAttributes = [[textStorage attributesAtIndex:characterIndex effectiveRange:&attributesEffectiveRange] mutableCopy];
						[currentAttributes setObject:_invisibleCharacterColor forKey:NSForegroundColorAttributeName];
					}
					
					[stringToDraw drawAtPoint:pointToDrawAt withAttributes:currentAttributes];
				}
			}
			
			prevCharacterIndex = characterIndex;
		}
		
		[currentAttributes release];
	} 
	
	[super drawGlyphsForGlyphRange:glyphRange atPoint:containerOrigin];
}

@end
