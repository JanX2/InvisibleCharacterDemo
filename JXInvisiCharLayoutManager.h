//
//  JXInvisiCharLayoutManager.h
//  
//
//  Created by Jan on 02.12.11.
//  Copyright (c) 2012-2017 Jan Weiß. All rights reserved.
//

#import <Cocoa/Cocoa.h>


#define CASE_IS_LINE_BREAK \
		case 0x0009: /* tab, HT, horizontal tab */ \
		case 0x000A: /* new line, LF, line feed */ \
		case 0x000B: /* vertical tab, VT */ \
		case 0x000C: /* page break, FF, form feed */ \
		case 0x000D: /* carriage return */ \
		case 0x2028: /* unicode line separator */ \
		case 0x2029: /* unicode paragraph separator */ \
		case 0x0085  /* next line, NEL */ \

extern CGFloat const kLineBreakCharacterOffsetPercent;

@class JXNoBreaksTypesetter;

@interface JXInvisiCharLayoutManager : NSLayoutManager {
	NSColor *_illegalCharacterColor;
	BOOL _useIllegalColor;
	
	NSColor *_defaultInvisibleCharacterColor;
	CGFloat _invisibleCharacterAlpha;
	BOOL _showsInvisibleCharacters;
	
	BOOL _lineBreaksDisabled;
	NSTypesetter *_defaultTypeSetter;
	JXNoBreaksTypesetter *_noBreaksTypeSetter;
}

+ (CFDictionaryRef)invisibleUnicharToVisibleUnicharMap;
+ (CFDictionaryRef)invisibleUnicharToVisibleStringMap;

@property (nonatomic, readwrite, retain) NSColor *illegalCharacterColor;
@property (nonatomic, readwrite) BOOL useIllegalColor;

@property (nonatomic, readwrite, retain) NSColor *defaultInvisibleCharacterColor;
@property (nonatomic, readwrite) CGFloat invisibleCharacterAlpha;
@property (atomic, readwrite) BOOL showsInvisibleCharacters;

@property (nonatomic, assign) BOOL lineBreaksDisabled;

@end
