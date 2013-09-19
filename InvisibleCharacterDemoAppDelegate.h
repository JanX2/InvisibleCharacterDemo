//
//  InvisibleCharacterDemoAppDelegate.h
//  InvisibleCharacterDemo
//
//  Created by Jan on 02.12.11.
//  Copyright (c) 2012-2013 Jan Weiß. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class JXInvisiCharTextView;

@interface InvisibleCharacterDemoAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate> {
    NSWindow *_window;
    JXInvisiCharTextView *_textView;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet JXInvisiCharTextView *textView;

@end
