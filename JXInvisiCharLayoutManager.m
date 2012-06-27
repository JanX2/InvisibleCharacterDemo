//
//	JXInvisiCharLayoutManager.m
//	
//
//	Created by Jan on 02.12.11.
//	Copyright 2011 geheimwerk.de. All rights reserved.
//

#import "JXInvisiCharLayoutManager.h"

#import "JXNoBreaksTypesetter.h"

typedef struct _JXUnicharMappingStruct {
	unichar invisible;
	unichar replacement;
} JXUnicharMappingStruct;

// Partially based on http://en.wikipedia.org/wiki/Template:Whitespace_(Unicode)
JXUnicharMappingStruct JXInvisiCharToCharMap[] = {
	//	invisible	replacement
	{	  0x0020,		0x002E}, // ordinary space				TO	ordinary full stop; alternatives: one dot leader (0x2024), small full stop (0xFE52)
	{	  0x00A0,		0x237D}, // no-break space				TO	shouldered open box
	{	  0x202F,		0x237D}, // narrow no-break space		TO	shouldered open box
	{	  0x180E,		0x002E}, // mongolian vowel separator	TO	ordinary full stop
	{	  0x2000,		0x002E}, // en quad						TO	ordinary full stop
	{	  0x2001,		0x002E}, // em quad						TO	ordinary full stop
	{	  0x2002,		0x002E}, // en space					TO	ordinary full stop
	{	  0x2003,		0x002E}, // em space					TO	ordinary full stop
	{	  0x2004,		0x002E}, // three-per-em space			TO	ordinary full stop
	{	  0x2005,		0x002E}, // four-per-em space			TO	ordinary full stop
	{	  0x2006,		0x002E}, // six-per-em space			TO	ordinary full stop
	{	  0x2007,		0x002E}, // figure space				TO	ordinary full stop
	{	  0x2008,		0x002E}, // punctuation space			TO	ordinary full stop
	{	  0x2009,		0x002E}, // thin space					TO	ordinary full stop
	{	  0x200A,		0x002E}, // hair space					TO	ordinary full stop
	{	  0x205F,		0x002E}, // medium mathematical space	TO	ordinary full stop
	{	  0x3000,		0x002E}, // ideographic space			TO	ordinary full stop
	
	{	  0x0009,		0x21E5}, // tab, HT, horizontal tab		TO	rightwards arrow to bar; alternatives: rightwards arrow (0x2192), rightwards dashed arrow (0x21E2)
	{	  0x000B,		0x2193}, // vertical tab, VT			TO	downwards arrow

	{	  0x000A,		0x00B6}, // new line, LF, line feed		TO	pilcrow sign
	{	  0x000D,		0x204B}, // carriage return				TO	reversed pilcrow sign
	{	  0x2028,		0x2761}, // unicode line separator		TO	curved stem paragraph sign ornament
	{	  0x2029,		0x21AB}, // unicode paragraph separator	TO	leftwards arrow with loop
	{	  0x0085,		0x00AC}, // next line, NEL				TO	angled dash
	
	{	  0x000C,		0x21DF}, // page break, FF, form feed	TO	downwards arrow with double stroke; alternatives: next page (0x2398)
	
	{	  0xFFFF,		0xFFFD}, // invalid control				TO	replacement character
};


@interface JXInvisiCharLayoutManager (Private)
+ (CFDictionaryRef)unicharMap;
@end


@implementation JXInvisiCharLayoutManager

+ (CFDictionaryRef)unicharMap;
{
	static CFDictionaryRef unicharMap = nil;
	
	if (unicharMap == nil) {
		CFIndex charToInvisiCharMapCount = sizeof(JXInvisiCharToCharMap)/sizeof(JXUnicharMappingStruct);
		
		CFMutableDictionaryRef mutableUnicharMap = CFDictionaryCreateMutable(kCFAllocatorDefault, charToInvisiCharMapCount, NULL, &kCFTypeDictionaryValueCallBacks); // keys: unichar, values: NSString
		
		for (CFIndex i = 0; i < charToInvisiCharMapCount; i++) {
			CFDictionaryAddValue(mutableUnicharMap, 
								 (const void *)(CFIndex)JXInvisiCharToCharMap[i].invisible, 
								 (const void *)[NSString stringWithCharacters:&(JXInvisiCharToCharMap[i].replacement) length:1]);
		}
		
		//CFShow(mutableUnicharMap);
		
		unicharMap = CFDictionaryCreateCopy(kCFAllocatorDefault, mutableUnicharMap); // Create an immutable copy
		CFRelease(mutableUnicharMap);
	}
	
	return unicharMap;
}

- (id)init;
{
	self = [super init];
	
	if (self) {
		_illegalCharacterColor = [[NSColor redColor] retain];
		_useIllegalColor = YES;
		
		_defaultInvisibleCharacterColor = [[NSColor lightGrayColor] retain];
		_invisibleCharacterAlpha = 0.333f;
		_showInvisibleCharacters = YES;
		
		self.lineBreaksDisabled = NO;
	}
	
	return self;
}

- (void)dealloc {
	[_illegalCharacterColor release];

	[_defaultInvisibleCharacterColor release];
	
	[super dealloc];
}

#if 0
// Enabling this does indeed display invisible characters (line break type characters are not displayed).
// The downside is, that the result is very ugly and not very easy for the user to visually parse.
- (NSUInteger)layoutOptions
{
	return (NSShowControlGlyphs | NSShowInvisibleGlyphs);
}
#endif

// Based on Peter Borg’s answer to “Invisible characters in NSTextView”
// http://www.cocoabuilder.com/archive/cocoa/124811-invisible-characters-in-nstextview.html

- (void)drawGlyphsForGlyphRange:(NSRange)glyphRange atPoint:(NSPoint)containerOrigin
{
	if (_showInvisibleCharacters) {
		NSTextStorage *textStorage = [self textStorage];
		NSString *completeString = [[self textStorage] string];
		NSUInteger lengthToRedraw = NSMaxRange(glyphRange);
		NSUInteger prevCharacterIndex = NSUIntegerMax;
		
		NSMutableDictionary *currentAttributes = nil;
		NSRange attributesEffectiveRange = NSMakeRange(NSUIntegerMax, 0);
		
		CFDictionaryRef unicharMap = [JXInvisiCharLayoutManager unicharMap];
		
		NSColor *currentCharacterColor;
		NSColor *invisibleCharacterColor;
		
		for (NSUInteger index = glyphRange.location; index < lengthToRedraw; index++) {
			// For characters consisting of several glyphs, the following will return the same index for consecutive iterations.
			NSUInteger characterIndex = [self characterIndexForGlyphAtIndex:index];
			
			// Check if we have processed this character already
			if (characterIndex != prevCharacterIndex) {
				BOOL isIllegal;
				unichar characterToCheck = [completeString characterAtIndex:characterIndex];
				
				// Map the character to its visible replacement
				NSString *stringToDraw = (NSString *)CFDictionaryGetValue(unicharMap, (const void *)(CFIndex)characterToCheck);

				if ((stringToDraw == nil)
					&& (characterToCheck < 0x0020 
						|| (characterToCheck >= 0x007F && characterToCheck <= 0x009F))) {
					// control character
					stringToDraw = (NSString *)CFDictionaryGetValue(unicharMap, (const void *)0xFFFF);
					isIllegal = YES;
				}
				else {
					isIllegal = NO;
				}

				// stringToDraw will be nil for glyphs we don’t want to change the appearance of (i.e. visible characters)
				if (stringToDraw != nil) {
					NSPoint pointToDrawAt = [self locationForGlyphAtIndex:index];
					NSRect lineRect = [self lineFragmentRectForGlyphAtIndex:index effectiveRange:NULL];
					pointToDrawAt.x += lineRect.origin.x;
					pointToDrawAt.y = NSMinY(lineRect);

					// Check if we need to generate attributes for this location
					if ((currentAttributes == nil) 
						|| !(NSLocationInRange(characterIndex, attributesEffectiveRange))) {
						
						[currentAttributes release];
						currentAttributes = [[textStorage attributesAtIndex:characterIndex effectiveRange:&attributesEffectiveRange] mutableCopy];
						
						if (isIllegal && _useIllegalColor) {
							invisibleCharacterColor = _illegalCharacterColor;
						}
						else {
							currentCharacterColor = [currentAttributes objectForKey:NSForegroundColorAttributeName];
							if (currentCharacterColor == nil) {
								invisibleCharacterColor = _defaultInvisibleCharacterColor;
							}
							else {
								invisibleCharacterColor = [currentCharacterColor colorWithAlphaComponent:([currentCharacterColor alphaComponent] * _invisibleCharacterAlpha)];
							}
						}
						
						[currentAttributes setObject:invisibleCharacterColor forKey:NSForegroundColorAttributeName];
						
						[currentAttributes removeObjectForKey:NSUnderlineStyleAttributeName];
						[currentAttributes removeObjectForKey:NSSuperscriptAttributeName];
						[currentAttributes removeObjectForKey:NSBaselineOffsetAttributeName];
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


- (BOOL)lineBreaksDisabled {
    return _lineBreaksDisabled;
}

- (void)setLineBreaksDisabled:(BOOL)value {
    if (_lineBreaksDisabled != value) {
        _lineBreaksDisabled = value;
		
		NSATSTypesetter *typeSetter;
		if (_lineBreaksDisabled) {
			typeSetter = [[JXNoBreaksTypesetter alloc] init];
		}
		else {
			typeSetter = [[NSATSTypesetter alloc] init];
		}
		
		[self setTypesetter:typeSetter];
		[typeSetter release];
    }
}

@end
