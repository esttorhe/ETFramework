//
//  ETTwitterClient.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ETTwitterClient : AFHTTPClient

+ (ETTwitterClient *) sharedClient;

@end
