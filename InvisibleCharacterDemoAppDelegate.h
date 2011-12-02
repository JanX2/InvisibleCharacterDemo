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
    JXInvisiCharTextView *_fieldEditor;
}

@property (assign) IBOutlet NSWindow *window;

@end
