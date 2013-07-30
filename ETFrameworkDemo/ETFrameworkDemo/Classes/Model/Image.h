//
//  Image.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Image : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * is_default;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSManagedObject *user;

@end
