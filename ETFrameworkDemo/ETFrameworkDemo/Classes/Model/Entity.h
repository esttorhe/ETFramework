//
//  Entity.h
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 7/27/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Description, Hashtag, Link, Mention, Tweet;

@interface Entity : NSManagedObject

@property (nonatomic, retain) NSSet *descriptions;
@property (nonatomic, retain) NSSet *hashtags;
@property (nonatomic, retain) NSSet *links;
@property (nonatomic, retain) NSSet *mentions;
@property (nonatomic, retain) Tweet *tweet;
@end

@interface Entity (CoreDataGeneratedAccessors)

- (void)addDescriptionsObject:(Description *)value;
- (void)removeDescriptionsObject:(Description *)value;
- (void)addDescriptions:(NSSet *)values;
- (void)removeDescriptions:(NSSet *)values;

- (void)addHashtagsObject:(Hashtag *)value;
- (void)removeHashtagsObject:(Hashtag *)value;
- (void)addHashtags:(NSSet *)values;
- (void)removeHashtags:(NSSet *)values;

- (void)addLinksObject:(Link *)value;
- (void)removeLinksObject:(Link *)value;
- (void)addLinks:(NSSet *)values;
- (void)removeLinks:(NSSet *)values;

- (void)addMentionsObject:(Mention *)value;
- (void)removeMentionsObject:(Mention *)value;
- (void)addMentions:(NSSet *)values;
- (void)removeMentions:(NSSet *)values;

@end
