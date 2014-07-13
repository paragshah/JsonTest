//
//  JsonDownloader.m
//  JsonTest
//
//  Created by Parag Shah on 7/11/14.
//  Copyright (c) 2014 Parag Shah. All rights reserved.
//

#import "JsonDownloader.h"

@interface JsonDownloader()

@property (nonatomic) NSURL *URL;

@end


@implementation JsonDownloader

- (id)initWithURL:(NSURL *)URL {
	self = [super init];
	if (self) {
		_URL = URL;
	}

	return self;
}

- (void)start {

  if (self.URL == nil) {
    if ([self.delegate respondsToSelector:@selector(download:didFailWithError:)]) {
      NSError *error = [NSError errorWithDomain:@"paragshah.com" code:403 userInfo:nil];
      [self.delegate download:self didFailWithError:error];
    }
    return;
  }

  NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:self.URL];
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];

  __weak typeof (self) weakSelf = self;
  [NSURLConnection sendAsynchronousRequest:urlRequest
                                     queue:queue
                         completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                           if (connectionError) {
                             if ([weakSelf.delegate respondsToSelector:@selector(download:didFailWithError:)]) {
                               [weakSelf.delegate download:weakSelf didFailWithError:connectionError];
                             }
                           }
                           else {
                             [weakSelf handleDownloadedJson:data];
                           }
                         }];
}

- (void)cancel {

}

- (void)handleDownloadedJson:(NSData*) data {
  NSError *error = nil;
  NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

  if ([self.delegate respondsToSelector:@selector(download:didFinishWithDictionary:)]) {
    [self.delegate download:self didFinishWithDictionary:parsedObject];
  }
}

@end
