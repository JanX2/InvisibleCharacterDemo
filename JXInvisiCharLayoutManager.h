//
//  JXInvisiCharLayoutManager.h
//  
//
//  Created by Jan on 02.12.11.
//  Copyright 2011 geheimwerk.de. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface JXInvisiCharLayoutManager : NSLayoutManager {
	NSColor *_illegalCharacterColor;
	BOOL _useIllegalColor;
	
	NSColor *_defaultInvisibleCharacterColor;
	CGFloat _invisibleCharacterAlpha;
	BOOL _showInvisibleCharacters;
	
	BOOL _lineBreaksDisabled;
}

@property (nonatomic, readwrite, retain) NSColor *illegalCharacterColor;
@property (nonatomic, readwrite) BOOL useIllegalColor;

@property (nonatomic, readwrite, retain) NSColor *defaultInvisibleCharacterColor;
@property (nonatomic, readwrite) CGFloat invisibleCharacterAlpha;
@property (nonatomic, readwrite) BOOL showInvisibleCharacters;

@property (nonatomic, assign) BOOL lineBreaksDisabled;

@end
