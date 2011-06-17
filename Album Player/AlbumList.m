//
//  AlbumList.m
//  Album Player
//
//  Created by Sean Dougall on 6/17/11.
//  Copyright 2011 Figure 53. All rights reserved.
//

#import "AlbumList.h"
#import "Album.h"


@interface AlbumList (Private)

- (void)loadFromITunesLibraryAtPath:(NSString *)path;

@end


@implementation AlbumList (Private)

- (void)loadFromITunesLibraryAtPath:(NSString *)path
{
    NSDictionary *dict = [NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path] options:NSDataReadingUncached error:nil] options:NSPropertyListImmutable format:nil error:nil];
    
    NSMutableArray *allAlbums = [NSMutableArray array];
    NSMutableDictionary *tracksByAlbum = [NSMutableDictionary dictionary];
    NSMutableDictionary *trackTotalByAlbum = [NSMutableDictionary dictionary];
    
    for (NSDictionary *track in [[dict objectForKey:@"Tracks"] allValues])
    {
        NSString *albumName = [track objectForKey:@"Album"];
        
        if (albumName == nil)
            continue;
        
        if ([[track objectForKey:@"Artwork Count"] integerValue] < 1)
            continue;
        
        NSString *albumArtist = [track objectForKey:@"Album Artist"];
        if (albumArtist == nil)
            albumArtist = [track objectForKey:@"Artist"];
        
        NSString *albumKey = [NSString stringWithFormat:@"%@ _ %@", albumArtist, albumName];
        
        if ([tracksByAlbum objectForKey:albumKey] == nil)
        {
            [tracksByAlbum setObject:[NSMutableArray array] forKey:albumKey];
        }
        
        [[tracksByAlbum objectForKey:albumKey] addObject:track];
        
        if ([trackTotalByAlbum objectForKey:albumKey] == nil && [track objectForKey:@"Track Count"] != nil)
        {
            [trackTotalByAlbum setObject:[track objectForKey:@"Track Count"] forKey:albumKey];
        }
    }
    
    NSArray *trackSort = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"Track Number" ascending:YES] autorelease]];
    
    for (NSString *albumKey in [trackTotalByAlbum allKeys])
    {
        if ([[trackTotalByAlbum objectForKey:albumKey] integerValue] == [[tracksByAlbum objectForKey:albumKey] count])
        {
            NSDictionary *firstTrack = [[tracksByAlbum objectForKey:albumKey] objectAtIndex:0];
            NSString *albumArtist = [firstTrack objectForKey:@"Album Artist"];
            if (albumArtist == nil)
                albumArtist = [firstTrack objectForKey:@"Artist"];
            
            Album *album = [Album albumWithInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [firstTrack objectForKey:@"Album"], @"title",
                                                 albumArtist, @"artist",
                                                 [[tracksByAlbum objectForKey:albumKey] sortedArrayUsingDescriptors:trackSort], @"tracks",
                                                 nil]];
            if (album)
                [allAlbums addObject:album];
        }
    }
    
    self.albums = [[allAlbums copy] autorelease];
}

@end


@implementation AlbumList

@synthesize albums = _albums;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self loadFromITunesLibraryAtPath:[@"~/Music/iTunes/iTunes Music Library.xml" stringByExpandingTildeInPath]];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
