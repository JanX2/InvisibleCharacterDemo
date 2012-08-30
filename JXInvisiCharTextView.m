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

@synthesize invisiCharLayoutManager = _layoutManager;

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
    
    if (self) {
		_layoutManager = [[JXInvisiCharLayoutManager alloc] init];
		[[self textContainer] replaceLayoutManager:_layoutManager];
	}
    
	return self;
}

- (void)awakeFromNib
{
	NSTextContainer *textContainer = [self textContainer];
	if (![[textContainer layoutManager] isKindOfClass:[JXInvisiCharLayoutManager class]]) {
		[_layoutManager release];
		_layoutManager = [[JXInvisiCharLayoutManager alloc] init];
		[textContainer replaceLayoutManager:_layoutManager];
		self.showsInvisibleCharacters = YES;
	}
}

- (void)dealloc {
	[_layoutManager release];
	
	[super dealloc];
}


- (BOOL)showsInvisibleCharacters
{
    return [_layoutManager showsInvisibleCharacters];
}

- (void)setShowsInvisibleCharacters:(BOOL)value
{
    BOOL showsInvisibleCharacters = [_layoutManager showsInvisibleCharacters];
	if (showsInvisibleCharacters != value) {
		[_layoutManager setShowsInvisibleCharacters:value];
		[self setNeedsDisplayInRect:[self visibleRect]];
	}
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
