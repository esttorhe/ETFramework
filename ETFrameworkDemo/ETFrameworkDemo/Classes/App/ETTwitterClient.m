//
//  ETTwitterClient.m
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import "ETTwitterClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kETTweetAPIBaseURLString = @"https://alpha-api.app.net/";
@implementation ETTwitterClient

+ (ETTwitterClient *)sharedClient {
    static ETTwitterClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ETTwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kETTweetAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    // By default, the example ships with SSL pinning enabled for the app.net API pinned against the public key of adn.cer file included with the example. In order to make it easier for developers who are new to AFNetworking, SSL pinning is automatically disabled if the base URL has been changed. This will allow developers to hack around with the example, without getting tripped up by SSL pinning.
    if ([[url scheme] isEqualToString:@"https"] && [[url host] isEqualToString:@"alpha-api.app.net"]) {
        self.defaultSSLPinningMode = AFSSLPinningModePublicKey;
    } else {
        self.defaultSSLPinningMode = AFSSLPinningModeNone;
    }
    
    return self;
}

@end
