//
//  JXNoBreaksTypesetter.m
//  InvisibleCharacterDemo
//
//  Created by Jan on 12.01.12.
//  Copyright 2012 geheimwerk.de. All rights reserved.
//

#import "JXNoBreaksTypesetter.h"


@implementation JXNoBreaksTypesetter

- (NSTypesetterControlCharacterAction)actionForControlCharacterAtIndex:(NSUInteger)charIndex
{
	unichar c = [self.attributedString.string characterAtIndex:charIndex];
	switch (c) {
		case 0x000A: // new line, LF, line feed
		case 0x000B: // vertical tab, VT
		case 0x000C: // page break, FF, form feed
		case 0x000D: // carriage return
		case 0x2028: // unicode line separator
		case 0x2029: // unicode paragraph separator
		case 0x0085: // next line, NEL
			return NSTypesetterWhitespaceAction;
			break;
			
		default:
			return [super actionForControlCharacterAtIndex:charIndex];
			break;
	}
}

- (NSRect)boundingBoxForControlGlyphAtIndex:(NSUInteger)glyphIndex
						   forTextContainer:(NSTextContainer *)textContainer
					   proposedLineFragment:(NSRect)proposedRect
							  glyphPosition:(NSPoint)glyphPosition
							 characterIndex:(NSUInteger)charIndex
{
	// We could try to determine the dimensions of the glyph we will place here,
	// but we just reserve a square of space based on the height of the proposedRect. 
	// A bit of a hack, but looks OK and is fast.
	proposedRect.size.width = proposedRect.size.height;
	
	//NSLog(@"\nproposedRect: %@\nglyphPosition: %@", NSStringFromRect(proposedRect), NSStringFromPoint(glyphPosition));
	return proposedRect;
}

@end
