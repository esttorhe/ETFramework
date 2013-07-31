//
//  PLServer.m
//  Esteban Torres
//
//  Created by Esteban Torres on 4/9/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "ETServer.h"
#import "ETTwitterClient.h"
#import "ETDataFramework.h"
#import "ETLocalDatabase.h"

//******** API paths *********//
static NSString * const STREAM_GET_GLOBAL = @"stream/0/posts/stream/global";

static ETServer* theServerApi = nil;
@implementation ETServer

#pragma mark - Public Static methods

+ (ETServer*) sharedInstance
{
    if (theServerApi == nil)
    {
        theServerApi = [ETServer new];
    }
    
    return theServerApi;
}

- (void) getGlobalStreamWithCompletionPath:(void(^)(NSError *error, NSArray *results))completionBlock{
    [[ETTwitterClient sharedClient] getPath:STREAM_GET_GLOBAL parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
        NSArray *tweets = [[[[ETLocalDatabase sharedDatabase] addMultipleTweet:postsFromResponse] allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[(Tweet *)obj1 created_at] compare:[(Tweet *)obj2 created_at]];
        }];
        
        if (completionBlock) {
            completionBlock(nil, tweets);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            completionBlock(error, nil);
        }
    }];
}

@end
