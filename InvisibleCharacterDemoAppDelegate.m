//
//  InvisibleCharacterDemoAppDelegate.m
//  InvisibleCharacterDemo
//
//  Created by Jan on 02.12.11.
//  Copyright 2011 geheimwerk.de. All rights reserved.
//

#import "InvisibleCharacterDemoAppDelegate.h"

#import "JXInvisiCharTextView.h"

@implementation InvisibleCharacterDemoAppDelegate

@synthesize window = _window;
@synthesize textView = _textView;

- (void)dealloc
{
	self.textView = nil;

	[super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}


- (BOOL)lineBreaksDisabled
{
    return [_textView lineBreaksDisabled];
}

- (void)setLineBreaksDisabled:(BOOL)value
{
	[_textView setLineBreaksDisabled:value];
}

@end
