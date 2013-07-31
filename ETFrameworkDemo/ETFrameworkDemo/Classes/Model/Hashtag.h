//
//  Hashtag.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity;

@interface Hashtag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * len;
@property (nonatomic, retain) NSNumber * pos;
@property (nonatomic, retain) NSSet *entities;
@end

@interface Hashtag (CoreDataGeneratedAccessors)

- (void)addEntitiesObject:(Entity *)value;
- (void)removeEntitiesObject:(Entity *)value;
- (void)addEntities:(NSSet *)values;
- (void)removeEntities:(NSSet *)values;

@end
