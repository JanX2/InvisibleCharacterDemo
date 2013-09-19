//
//  JXNoBreaksTypesetter.m
//  InvisibleCharacterDemo
//
//  Created by Jan on 12.01.12.
//  Copyright 2012 geheimwerk.de. All rights reserved.
//

#import "JXNoBreaksTypesetter.h"

#import "JXInvisiCharLayoutManager.h"

@implementation JXNoBreaksTypesetter

- (NSTypesetterControlCharacterAction)actionForControlCharacterAtIndex:(NSUInteger)charIndex
{
	unichar c = [self.attributedString.string characterAtIndex:charIndex];
	switch (c) {
		CASE_IS_LINE_BREAK:
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
	NSAttributedString *text = self.attributedString;
	unichar c = [text.string characterAtIndex:charIndex];
	switch (c) {
		CASE_IS_LINE_BREAK:
		{
			// We could try to determine the dimensions of the glyph we will place here,
			// but we just reserve a square of space based on the height of the proposedRect.
			// A bit of a hack, but looks OK and is fast.
			proposedRect.size.width = proposedRect.size.height;
		}
			break;
			
		default:
			break;
	}

	//NSLog(@"\nproposedRect: %@\nglyphPosition: %@", NSStringFromRect(proposedRect), NSStringFromPoint(glyphPosition));
	return proposedRect;
}

@end
