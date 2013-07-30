//
//  PLServer.h
//  Esteban Torres
//
//  Created by Esteban Torres on 4/9/13.
//  Copyright (c) 2013 Log(n). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETFrameworkModelFramework.h"

@interface ETServer : NSObject

// Class Methods
+ (ETServer *) sharedInstance;

- (void) getGlobalStreamWithCompletionPath:(void(^)(NSError *error, NSArray *results))completionBlock;

@end