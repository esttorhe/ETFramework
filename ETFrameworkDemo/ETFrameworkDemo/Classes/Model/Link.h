//
//  Link.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity;

@interface Link : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * pos;
@property (nonatomic, retain) NSNumber * len;
@property (nonatomic, retain) NSSet *entities;
@end

@interface Link (CoreDataGeneratedAccessors)

- (void)addEntitiesObject:(Entity *)value;
- (void)removeEntitiesObject:(Entity *)value;
- (void)addEntities:(NSSet *)values;
- (void)removeEntities:(NSSet *)values;

@end
