//
//  ETCoreData.h
//  Esteban Torres - Core Data categories
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSInteger, kPredefinedExpression) {
    // An NSNumber object
    kPredefinedExpressionFloor              =           123,
    // An NSString object
    kPredefinedExpressionUppercase          =           124,
    // An NSString object
    kPredefinedExpressionLowercase          =           125,
    // An NSNumber object (the number is treated as an NSInteger)
    kPredefinedExpressionBitwiseAndWith     =           126,
    // An NSNumber object (the number is treated as an NSInteger)
    kPredefinedExpressionBitwiseOrWith      =           127,
    // An NSNumber object (the number is treated as an NSInteger)
    kPredefinedExpressionBitwiseXOrWith     =           128,
    // An NSNumber object (the number is treated as an NSInteger)
    kPredefinedExpressionLeftShiftBy        =           129,
    // An NSNumber object (the number is treated as an NSInteger)
    kPredefinedExpressionRightShiftBy       =           130,
    // An NSNumber object (the number is treated as an NSInteger)
    kPredefinedExpressionOnesComplement     =           131,
    // The result of evaluating the parameter as though the noindex: function expression didn't exist.
    kPredefinedExpressionNoIndex            =           132,
};

#define IS_JSON_NIL_OR_NULL(jsonDictionary) jsonDictionary == nil || [jsonDictionary isKindOfClass:[NSNull class]]

@interface NSError (ETCoreData)

- (void) logDetailedErrors;

@end

@interface NSManagedObjectContext (ETCoreData)

- (BOOL) submitChanges;
- (NSArray*) fetchObjectsOfType:(NSString *)entityName
                      withPredicate:(NSPredicate*)predicate
                andSortDescriptors:(NSArray*)sortDescriptors;
- (void) deleteObjects:(NSArray*)objects;
- (void) deleteObjectsOfType:(NSString *)entityName withPredicate:(NSPredicate*)predicate;
- (int) countObjectsOfType:(NSString *)entityName withPredicate:(NSPredicate*)predicate;
- (NSArray*) allObjectsOfType:(NSString *)entityName;
- (int) scalarExpressionValueForColumn:(NSString *)column expression:(kPredefinedExpression)predefinedExpression entity:(NSString *)entity withPredicate:(NSPredicate*)predicate;
- (BOOL) hasEntityWithId:(NSString *)entityName idColumn:(NSString *)idColumn identifier:(NSString *)identifier;
- (id) fetchSingleObject:(NSString *)entity withPredicate:(NSPredicate*)predicate;

@end

@interface NSManagedObject (ETCoreData)

- (BOOL) isNew;
+ (NSString *) entityName;
- (void) fillFromDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter;

@end

@interface NSSet (ETCoreData)

- (NSArray*) ETSortedArray:(NSString *)field;
- (NSArray*) ETSortedArray:(NSString *)field ascending:(BOOL)ascending;

@end


@class ETImage;

@interface ETCoreDataStore : NSObject
{
    
}

@property (nonatomic, retain) NSString * dataFilePath;
@property (nonatomic, retain) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator* persistentStoreCoordinator;

- (id)initWithDataFile:(NSString *)dataFilePath;

- (void) clearDatabase;
- (void) cancelChanges;
- (void) submitChanges;

- (NSDateFormatter*) jsonDateFormatter;

- (BOOL) hasFileBeenProcessed:(NSString *)fileName;
- (void) markFileAsProcessed:(NSString *)fileName;

- (id) insertObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName;
- (id) insertObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName dateFormatter:(NSDateFormatter*)dateFormatter;

- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName;
- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName identifierKey:(NSString *)identifierKey dateFormatter:(NSDateFormatter*)dateFormatter;
- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName predicate:(NSPredicate*)predicate dateFormatter:(NSDateFormatter*)dateFormatter;

- (NSSet*) addObjectsFromJsonArray:(id)jsonArray addSingleSelector:(SEL)addSingleSelector;

- (NSPredicate*) identifierPredicate:(id)identifier;

@end


