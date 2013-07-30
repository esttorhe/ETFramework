//
//  Source.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Source : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * client_id;
@property (nonatomic, retain) NSManagedObject *tweet;

@end
