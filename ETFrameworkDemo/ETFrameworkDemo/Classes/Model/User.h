//
//  User.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Count, Description, Image;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * username;
@property (nonatomic, retain) NSString * locale;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * canonical_url;
@property (nonatomic, retain) NSString * verified_domain;
@property (nonatomic, retain) NSString * timezone;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Image *avatar_image;
@property (nonatomic, retain) Description *c_description;
@property (nonatomic, retain) Image *cover_image;
@property (nonatomic, retain) Count *counts;
@property (nonatomic, retain) NSSet *tweets;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addTweetsObject:(NSManagedObject *)value;
- (void)removeTweetsObject:(NSManagedObject *)value;
- (void)addTweets:(NSSet *)values;
- (void)removeTweets:(NSSet *)values;

@end
