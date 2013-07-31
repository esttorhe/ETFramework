//
//  Mention.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/27/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity;

@interface Mention : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSNumber * is_leading;
@property (nonatomic, retain) NSNumber * len;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * pos;
@property (nonatomic, retain) NSSet *entities;
@end

@interface Mention (CoreDataGeneratedAccessors)

- (void)addEntitiesObject:(Entity *)value;
- (void)removeEntitiesObject:(Entity *)value;
- (void)addEntities:(NSSet *)values;
- (void)removeEntities:(NSSet *)values;

@end
