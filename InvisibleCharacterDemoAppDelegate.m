//
//  InvisibleCharacterDemoAppDelegate.m
//  InvisibleCharacterDemo
//
//  Created by Jan Weiß on 02.12.11.
//  Copyright 2012-2017 Jan Weiß, geheimwerk.de.
//  Some rights reserved: <http://opensource.org/licenses/mit-license.php>
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
