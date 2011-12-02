//
//	JXInvisiCharLayoutManager.m
//	
//
//	Created by Jan on 02.12.11.
//	Copyright 2011 geheimwerk.de. All rights reserved.
//

#import "JXInvisiCharLayoutManager.h"


@implementation JXInvisiCharLayoutManager

- (id)init;
{
	self = [super init];
	
	if (self) {
		_invisibleCharacterColor = [[NSColor lightGrayColor] retain];
		
		unichar spaceUnichar = 0x002E; // ordinary full stop; alternatives: one dot leader (0x2024), small full stop (0xFE52)
		_spaceCharacter = [[NSString alloc] initWithCharacters:&spaceUnichar length:1];
		unichar tabUnichar = 0x21E5;
		_tabCharacter = [[NSString alloc] initWithCharacters:&tabUnichar length:1];
		unichar newLineUnichar = 0x00B6;
		_newLineCharacter = [[NSString alloc] initWithCharacters:&newLineUnichar length:1];
		unichar carriageReturnUnichar = 0x204B;
		_carriageReturnCharacter = [[NSString alloc] initWithCharacters:&carriageReturnUnichar length:1];
		
		_showInvisibleCharacters = YES;
	}
	
	return self;
}

- (void)dealloc {
	[_invisibleCharacterColor release];
	
	[_tabCharacter release];
	[_newLineCharacter release];
	
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
				switch (characterToCheck) {
					case ' ':
						stringToDraw = _spaceCharacter;
						break;
					case '\t':
						stringToDraw = _tabCharacter;
						break;
					case '\n':
						stringToDraw = _newLineCharacter;
						break;
					case '\r':
						stringToDraw = _carriageReturnCharacter;
						break;
					default:
						stringToDraw = nil;
						break;
				}
				
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
