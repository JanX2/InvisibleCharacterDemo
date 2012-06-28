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
		case 0x000A:
		case 0x000D:
		case 0x2028:
		case 0x2029:
		case 0x0085:
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
	proposedRect.size.width = proposedRect.size.height;

	//NSLog(@"\nproposedRect: %@\nglyphPosition: %@", NSStringFromRect(proposedRect), NSStringFromPoint(glyphPosition));
	return proposedRect;
}

@end
