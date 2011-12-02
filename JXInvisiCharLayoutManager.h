//
//  JXInvisiCharLayoutManager.h
//  
//
//  Created by Jan on 02.12.11.
//  Copyright 2011 geheimwerk.de. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface JXInvisiCharLayoutManager : NSLayoutManager {
	NSColor *_invisibleCharacterColor;
	
	NSString *_spaceCharacter;
	NSString *_tabCharacter;
	NSString *_newLineCharacter;
	NSString *_carriageReturnCharacter;
	
	BOOL _showInvisibleCharacters;
}

@end
