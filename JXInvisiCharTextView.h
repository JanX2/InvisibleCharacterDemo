//
//  JXInvisiCharTextView.h
//  InvisibleCharacterDemo
//
//  Created by Jan Weiß on 02.12.11.
//  Copyright 2012-2017 Jan Weiß, geheimwerk.de.
//  Some rights reserved: <http://opensource.org/licenses/mit-license.php>
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
