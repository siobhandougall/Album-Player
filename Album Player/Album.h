//
//  Album.h
//  Album Player
//
//  Created by Sean Dougall on 6/17/11.
//  Copyright 2011 Figure 53. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Album : NSObject
{
    NSDictionary *_info;
    NSImage *_albumArtwork;
}

- (id)initWithInfo:(NSDictionary *)info;
+ (Album *)albumWithInfo:(NSDictionary *)info;

@property (readonly) NSImage *artwork;

@end
