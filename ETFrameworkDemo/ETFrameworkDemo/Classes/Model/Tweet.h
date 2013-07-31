//
//  Tweet.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/25/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity, Source, User;

@interface Tweet : NSManagedObject

@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSNumber * num_stars;
@property (nonatomic, retain) NSNumber * num_replies;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * num_reposts;
@property (nonatomic, retain) NSString * canonical_url;
@property (nonatomic, retain) NSString * html;
@property (nonatomic, retain) NSNumber * machine_only;
@property (nonatomic, retain) NSString * reply_to;
@property (nonatomic, retain) NSString * thread_id;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) Source *source;
@property (nonatomic, retain) Entity *entities;
@property (nonatomic, retain) User *user;

@end
