//
//  InvisibleCharacterDemoAppDelegate.m
//  InvisibleCharacterDemo
//
//  Created by Jan on 02.12.11.
//  Copyright (c) 2012-2017 Jan Weiß. All rights reserved.
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

@end
