//
//  ETLocalDatabase.m
//  Esteban Torres
//
//  Created by Esteban Torres on 04/09/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "ETLocalDatabase.h"
#import "ETFrameworkModelFramework.h"
#import "ETCoreFramework.h"

static ETLocalDatabase* theLocalDatabase = nil;

@interface ETLocalDatabase ()

@end

@implementation ETLocalDatabase

+ (ETLocalDatabase*) sharedDatabase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theLocalDatabase = [[ETLocalDatabase alloc] init];
    });
    
    return theLocalDatabase;
}

+ (NSString *) localDatabasePath
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"ETFrameworkDemoDB.sqlite"];
}

- (id) init
{
    self = [super initWithDataFile:[ETLocalDatabase localDatabasePath]];
    
    if (self != nil)
    {
    }
    
    return self;
}

#pragma mark - Public Methods

- (id)addObject:(id)jsonDictionary jsonKey:(NSString *)jsonKey withClassType:(Class)classType classKey:(NSString *)classKey
{
    if (IS_JSON_NIL_OR_NULL(jsonDictionary)) {
        return nil;
    }
    
    NSDictionary *objDict = jsonDictionary[jsonKey];
    if (!objDict) {
        objDict = jsonDictionary;
    }
    
    id objFromJSON = [self updateObjectFromJson:objDict entityName:[classType entityName] identifierKey:classKey dateFormatter:[NSDateFormatter ETDefaultJSONDateFormatter]];
    ETDebugLog(@"%@=%@", NSStringFromClass(classType), objFromJSON);
    [self submitChanges];
    
    return objFromJSON;
}

- (Tweet *)addTweet:(id)jsonDictionary
{
    Tweet *tweet = [self addObject:jsonDictionary jsonKey:nil withClassType:[Tweet class] classKey:@"id"];
    NSDictionary *sourceDict = jsonDictionary[@"source"];
    if (sourceDict) {
        Source *source = [self addSource:sourceDict];
        if(source){ tweet.source = source; }
    }
    
    NSDictionary *entitiesDict = jsonDictionary[@"entities"];
    if (entitiesDict) {
        Entity *entity = [self addEntity:entitiesDict];
        if(entity){ tweet.entities = entity; }
    }
    
    NSDictionary *userDict = jsonDictionary[@"user"];
    if (userDict) {
        User *user = [self addUser:userDict];
        if(user){ tweet.user = user; }
    }
    
    return tweet;
}

- (Link *)addLink:(id)jsonDictionary
{
    return [self addObject:jsonDictionary jsonKey:nil withClassType:[Link class] classKey:@"url"];
}

- (Hashtag *)addHashtag:(id)jsonDictionary
{
    return [self addObject:jsonDictionary jsonKey:nil withClassType:[Hashtag class] classKey:@"name"];
}

- (Mention *)addMention:(id)jsonDictionary
{
    return [self addObject:jsonDictionary jsonKey:nil withClassType:[Mention class] classKey:@"id"];
}

- (Image *)addImage:(id)jsonDictionary
{
    return [self addObject:jsonDictionary jsonKey:nil withClassType:[Image class] classKey:@"url"];
}

- (Description *)addDescription:(id)jsonDictionary
{
    Description *desc = [self addObject:jsonDictionary jsonKey:nil withClassType:[Description class] classKey:@"text"];
    NSDictionary *entitiesDict = jsonDictionary[@"entities"];
    if(entitiesDict){
        Entity *entity = [self addEntity:entitiesDict];
        if(entity){ desc.entities = entity; }
    }
    
    
    return desc;
}

- (Source *)addSource:(id)jsonDictionary
{
    return [self addObject:jsonDictionary jsonKey:nil withClassType:[Source class] classKey:@"link"];
}

- (Count *)addCount:(id)jsonDictionary
{
    return [self addObject:jsonDictionary jsonKey:nil withClassType:[Count class] classKey:@"user"];
}

- (Entity *)addEntity:(id)jsonDictionary
{
    Entity *entity = [NSEntityDescription insertNewObjectForEntityForName:[Entity entityName] inManagedObjectContext:self.managedObjectContext];
    // Mentions
    NSArray *mentionsArray = jsonDictionary[@"mentions"];
    if (mentionsArray
        && mentionsArray.count > 0) {
        NSSet *mentions = [self addMultipleMention:mentionsArray];
        if(mentions){ entity.mentions = mentions; }
    }
    // Hashtags
    NSArray *hashtagsArray = jsonDictionary[@"hashtags"];
    if (hashtagsArray
        && hashtagsArray.count > 0) {
        NSSet *hashtags = [self addMultipleHashtag:hashtagsArray];
        if(hashtags){ entity.hashtags = hashtags; }
    }
    // Links
    NSArray *linksArray = jsonDictionary[@"links"];
    if (linksArray
        && linksArray.count > 0) {
        NSSet *links = [self addMultipleLink:linksArray];
        if(links){ entity.links = links; }
    }
    
    return entity;
}

- (User *)addUser:(id)jsonDictionary
{
    User *user = [self addObject:jsonDictionary jsonKey:nil withClassType:[User class] classKey:@"id"];
    NSDictionary *avatarDict = jsonDictionary[@"avatar_image"];
    if (avatarDict) {
        Image *avatar = [self addImage:avatarDict];
        if(avatar){ user.avatar_image = avatar; }
    }
    
    NSDictionary *descDict = jsonDictionary[@"description"];
    if (descDict) {
        Description *desc = [self addDescription:descDict];
        if(desc){ user.c_description = desc; }
    }
    
    NSDictionary *coverDict = jsonDictionary[@"cover_image"];
    if (coverDict) {
        Image *cover = [self addImage:coverDict];
        if(cover){ user.cover_image = cover; }
    }
    
    NSDictionary *countsDict = jsonDictionary[@"counts"];
    if (countsDict) {
        Count *count = [self addCount:countsDict];
        if(count){ user.counts = count; }
    }
    
    return user;
}

#pragma mark - Add Multiple Objects

- (NSSet*) addObjectsFromJsonArray:(id)jsonArray addSingleSelector:(SEL)addSingleSelector
{
    NSMutableSet* results = nil;
    
    if (jsonArray != nil && addSingleSelector != nil && [self respondsToSelector:addSingleSelector])
    {
        results = [NSMutableSet set];
        
        for (id node in jsonArray)
        {
            id obj = nil;
            SuppressPerformSelectorLeakWarning(obj = [self performSelector:addSingleSelector withObject:node];);
            [results addObject:obj];
        }
        
        [self submitChanges];
    }
    
    return [NSSet setWithSet:results];
}

- (NSSet*) addMultipleEventCategories:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addEventCategory:)];
}

- (NSSet *) addMultipleUser:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addUser:)];
}

- (NSSet *) addMultipleTweet:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addTweet:)];
}

- (NSSet *) addMultipleHashtag:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addHashtag:)];
}

- (NSSet *) addMultipleLink:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addLink:)];
}

- (NSSet *) addMultipleMention:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addMention:)];
}

- (NSSet *) addMultipleMultipleDescription:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addDescription:)];
}

- (NSSet *) addMultipleImage:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addImage:)];
}

- (NSSet *) addMultipleSource:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addSource:)];
}

- (NSSet *) addMultipleCount:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addCount:)];
}

- (NSSet *) addMultipleEntity:(id)jsonArray
{
    return [self addObjectsFromJsonArray:jsonArray addSingleSelector:@selector(addEntity:)];
}

#pragma mark - Find Methods

//- (PLCategory *) findEventCategoryById:(NSNumber *)identifier
//{
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id == %@", identifier];
//    PLCategory* obj = [self.managedObjectContext fetchSingleObject:[PLCategory entityName] Predicate:predicate];
//    return obj;
//}

@end
