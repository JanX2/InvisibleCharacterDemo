//
//  InvisibleCharacterDemoAppDelegate.h
//  InvisibleCharacterDemo
//
//  Created by Jan on 02.12.11.
//  Copyright 2011 geheimwerk.de. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class JXInvisiCharTextView;

@interface InvisibleCharacterDemoAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate> {
    NSWindow *_window;
    JXInvisiCharTextView *_textView;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet JXInvisiCharTextView *textView;

@property (nonatomic, assign) BOOL lineBreaksDisabled;

@end
