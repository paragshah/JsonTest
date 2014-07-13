//
//  JsonDownloader.h
//  JsonTest
//
//  Created by Parag Shah on 7/11/14.
//  Copyright (c) 2014 Parag Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonDownloader.h"

#define JSON_ITUNES_TOP_25 @"https://itunes.apple.com/us/rss/topsongs/limit=25/genre=20/json"


@class JsonDownloader;


@protocol JSDownloaderDelegate <NSObject>

@optional

- (void)download:(JsonDownloader *)jsonDownloader didFinishWithDictionary:(NSDictionary *)data;
- (void)download:(JsonDownloader *)jsonDownloader didFailWithError:(NSError *)error;

@end


@interface JsonDownloader : NSObject

@property (nonatomic, assign) id <JSDownloaderDelegate> delegate;

- (id)initWithURL:(NSURL *)url;
- (void)start;
- (void)cancel;

@end
