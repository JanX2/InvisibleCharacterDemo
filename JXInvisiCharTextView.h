//
//  JXInvisiCharTextView.h
//  InvisibleCharacterDemo
//
//  Created by Jan on 02.12.11.
//  Copyright 2011 geheimwerk.de. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class JXInvisiCharLayoutManager;

@interface JXInvisiCharTextView : NSTextView {
	JXInvisiCharLayoutManager *_layoutManager;
}

@property (nonatomic, assign) BOOL lineBreaksDisabled;

@property (nonatomic, readonly) JXInvisiCharLayoutManager *invisiCharLayoutManager;

@end
