//
//  Description.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/27/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity, User;

@interface Description : NSManagedObject

@property (nonatomic, retain) NSString * html;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Entity *entities;
@property (nonatomic, retain) User *user;

@end
