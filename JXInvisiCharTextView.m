//
//  JXInvisiCharTextView.m
//  InvisibleCharacterDemo
//
//  Created by Jan on 02.12.11.
//  Copyright 2011 geheimwerk.de. All rights reserved.
//

#import "JXInvisiCharTextView.h"

#import "JXInvisiCharLayoutManager.h"


@implementation JXInvisiCharTextView

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
    
    if (self) {
		_layoutManager = [[JXInvisiCharLayoutManager allocWithZone:[self zone]] init];
		[[self textContainer] replaceLayoutManager:_layoutManager];
	}
    
	return self;
}

- (void)awakeFromNib
{
	NSTextContainer *textContainer = [self textContainer];
	if (![[textContainer layoutManager] isKindOfClass:[JXInvisiCharLayoutManager class]]) {
		[_layoutManager release];
		_layoutManager = [[JXInvisiCharLayoutManager allocWithZone:[self zone]] init];
		[textContainer replaceLayoutManager:_layoutManager];
	}
}

- (void)dealloc {
	[_layoutManager release];
	
	[super dealloc];
}


- (BOOL)lineBreaksDisabled
{
    return [_layoutManager lineBreaksDisabled];
}

- (void)setLineBreaksDisabled:(BOOL)value
{
	[_layoutManager setLineBreaksDisabled:value];
}

@end
