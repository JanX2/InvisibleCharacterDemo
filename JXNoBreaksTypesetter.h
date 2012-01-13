//
//  JXNoBreaksTypesetter.h
//  InvisibleCharacterDemo
//
//  Created by Jan on 12.01.12.
//  Copyright 2012 geheimwerk.de. All rights reserved.
//

/*
 This Typesetter prevents lines from breaking on paragraph and line break marks (i.e. '\n', etc.).
 It’s a bit crude in the way it does this. For example it currently just reserves *some* space 
 that the paragraph marks introduced by JXInvisiCharLayoutManager will fit in. Furthermore 
 it doesn’t handle editing very well. There are visual issues when editing results in 
 added or removed breaks.
 The *raison d’être* for JXNoBreaksTypesetter is displaying as much text 
 (with control characters made visible) as can reasonably fit into a single line.
*/ 

#import <Cocoa/Cocoa.h>


@interface JXNoBreaksTypesetter : NSATSTypesetter {

}

@end
