//
//  ETLocalDatabase.h
//  Esteban Torres
//
//  Created by Esteban Torres on 04/09/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "ETDataFramework.h"
#import "ETFrameworkModelFramework.h"

@interface ETLocalDatabase : ETCoreDataStore
{
    
}

+ (ETLocalDatabase*) sharedDatabase;

- (id)addObject:(id)jsonDictionary jsonKey:(NSString *)jsonKey withClassType:(Class)classType classKey:(NSString *)classKey;
- (User *) addUser:(id)jsonDictionary;
- (Tweet *) addTweet:(id)jsonDictionary;
- (Hashtag *) addHashtag:(id)jsonDictionary;
- (Link *) addLink:(id)jsonDictionary;
- (Mention *) addMention:(id)jsonDictionary;
- (Description *) addDescription:(id)jsonDictionary;
- (Image *) addImage:(id)jsonDictionary;
- (Source *) addSource:(id)jsonDictionary;
- (Count *) addCount:(id)jsonDictionary;
- (Entity *) addEntity:(id)jsonDictionary;
//
- (NSSet*) addMultipleEventCategories:(id)jsonArray;
- (NSSet *) addMultipleUser:(id)jsonArray;
- (NSSet *) addMultipleTweet:(id)jsonArray;
- (NSSet *) addMultipleHashtag:(id)jsonArray;
- (NSSet *) addMultipleLink:(id)jsonArray;
- (NSSet *) addMultipleMention:(id)jsonArray;
- (NSSet *) addMultipleMultipleDescription:(id)jsonArray;
- (NSSet *) addMultipleImage:(id)jsonArray;
- (NSSet *) addMultipleSource:(id)jsonArray;
- (NSSet *) addMultipleCount:(id)jsonArray;
- (NSSet *) addMultipleEntity:(id)jsonArray;
//
//- (PLUser*) findUserById:(NSNumber*)identifier;
@end
