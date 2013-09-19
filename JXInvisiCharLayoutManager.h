//
//  JXInvisiCharLayoutManager.h
//  
//
//  Created by Jan on 02.12.11.
//  Copyright (c) 2012-2013 Jan Weiß. All rights reserved.
//

#import <Cocoa/Cocoa.h>

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

+ (CFDictionaryRef)invisibleUnicharToVisibleStringMap;

@property (nonatomic, readwrite, retain) NSColor *illegalCharacterColor;
@property (nonatomic, readwrite) BOOL useIllegalColor;

@property (nonatomic, readwrite, retain) NSColor *defaultInvisibleCharacterColor;
@property (nonatomic, readwrite) CGFloat invisibleCharacterAlpha;
@property (nonatomic, readwrite) BOOL showsInvisibleCharacters;

@property (nonatomic, assign) BOOL lineBreaksDisabled;

@end
