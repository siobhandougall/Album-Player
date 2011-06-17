//
//  AlbumList.h
//  Album Player
//
//  Created by Sean Dougall on 6/17/11.
//  Copyright 2011 Figure 53. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlbumList : NSObject
{
    NSArray *_albums;
}

@property (retain) NSArray *albums;

@end
