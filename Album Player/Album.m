//
//  Album.m
//  Album Player
//
//  Created by Sean Dougall on 6/17/11.
//  Copyright 2011 Figure 53. All rights reserved.
//

#import "Album.h"
#import <QuickLook/QuickLook.h>
#import "NSImage+QuickLook.h"


@implementation Album

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        _info = [info retain];
        
        [self willChangeValueForKey:@"artwork"];
        
        for (NSDictionary *track in [_info objectForKey:@"tracks"])
        {
            NSString *path = [[track objectForKey:@"Location"] stringByReplacingOccurrencesOfString:@"file://localhost" withString:@""];
            path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _albumArtwork = [[NSImage imageWithPreviewOfFileAtPath:path ofSize:NSMakeSize(512, 512) asIcon:NO] retain];
            if (_albumArtwork) break;
        }
        
        if (_albumArtwork == nil)
        {
            [self release];
            return nil;
        }
        
        [self didChangeValueForKey:@"artwork"];
    }
    return self;
}

+ (Album *)albumWithInfo:(NSDictionary *)info
{
    return [[[Album alloc] initWithInfo:info] autorelease];
}


- (id)init
{
    return [self initWithInfo:[NSDictionary dictionary]];
}

- (void)dealloc
{
    [_info release];
    [_albumArtwork release];
    [super dealloc];
}

@synthesize artwork = _albumArtwork;

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (by %@) - %d %@",
            [_info objectForKey:@"title"],
            [_info objectForKey:@"artist"],
            [[_info objectForKey:@"tracks"] count],
            [[_info objectForKey:@"tracks"] count] == 1 ? @"track" : @"tracks"];
}

@end
