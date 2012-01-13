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

@property (nonatomic, assign) BOOL lineBreaksDisabled;

@end
