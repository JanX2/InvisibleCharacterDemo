//
//  JXInvisiCharTextView.h
//  InvisibleCharacterDemo
//
//  Created by Jan on 02.12.11.
//  Copyright (c) 2012-2013 Jan Weiß. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class JXInvisiCharLayoutManager;

@interface JXInvisiCharTextView : NSTextView {
	JXInvisiCharLayoutManager *_layoutManager;
}

@property (nonatomic, assign) BOOL showsInvisibleCharacters;

@property (nonatomic, assign) BOOL lineBreaksDisabled;

@property (nonatomic, readonly) JXInvisiCharLayoutManager *invisiCharLayoutManager;

@end
