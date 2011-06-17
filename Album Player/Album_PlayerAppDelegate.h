//
//  Album_PlayerAppDelegate.h
//  Album Player
//
//  Created by Sean Dougall on 6/17/11.
//  Copyright 2011 Figure 53. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AlbumList;

@interface Album_PlayerAppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *_window;
    AlbumList *_albumList;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) AlbumList *albumList;

@end
