//
//  Count.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Count : NSManagedObject

@property (nonatomic, retain) NSNumber * following;
@property (nonatomic, retain) NSNumber * posts;
@property (nonatomic, retain) NSNumber * followers;
@property (nonatomic, retain) NSNumber * stars;
@property (nonatomic, retain) NSManagedObject *user;

@end
