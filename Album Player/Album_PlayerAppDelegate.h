//
//  Album_PlayerAppDelegate.h
//  Album Player
//
//  Created by Sean Dougall on 6/17/11.
//  Copyright 2011 Figure 53. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Album_PlayerAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
