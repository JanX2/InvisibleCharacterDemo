//
//  InvisibleCharacterDemoAppDelegate.h
//  InvisibleCharacterDemo
//
//  Created by Jan Weiß on 02.12.11.
//  Copyright 2012-2017 Jan Weiß, geheimwerk.de.
//  Some rights reserved: <http://opensource.org/licenses/mit-license.php>
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
