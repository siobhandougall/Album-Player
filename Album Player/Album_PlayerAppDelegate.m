//
//  Album_PlayerAppDelegate.m
//  Album Player
//
//  Created by Sean Dougall on 6/17/11.
//  Copyright 2011 Figure 53. All rights reserved.
//

#import "Album_PlayerAppDelegate.h"
#import "AlbumList.h"

@implementation Album_PlayerAppDelegate

@synthesize window = _window;

@synthesize albumList = _albumList;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.albumList = [[[AlbumList alloc] init] autorelease];
}

@end
