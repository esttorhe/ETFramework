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

/**
 `NSError (ETCoreData)` is a small category that provides logging capabilities for `NSError` objects.
 */
@interface NSError (ETCoreData)
/**------------------------------------------------------------------------------------------------------------------
 * @name Logging methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Logs the `localizedDescription` plus all the `NSError` objects on the `NSDetailedErrorsKey` from the `userInfo` `NSDictionary` and prints them to the console.
 */
- (void) logDetailedErrors;

@end

/**
 `NSManagedObjectContext (ETCoreData)` is a helper category that provides easier and better helper methods to manage `NSManagedObjectContext` objects.
 */
@interface NSManagedObjectContext (ETCoreData)
/**------------------------------------------------------------------------------------------------------------------
 * @name Other methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Checks if the current `NSManagedObjectContext` contains changes; if so tries to save them. If an error is found it calls `-logDetailErrors` with the `NSError` obtained from the `save:` operation.
 
 @see -[NSError logDetailErrors];
 */
- (BOOL) submitChanges;

/**------------------------------------------------------------------------------------------------------------------
 * @name Deletion
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Iterates throught the list of `NSManagedObject` provided and calls `deleteObject:` for each one. Then calls `-submitChanges;`
 
 @param objects A `NSArray` of `NSManageObject` that will be iterated to call `-deleteObject:` on it.
 
 @see -submitChanges;
 */
- (void) deleteObjects:(NSArray*)objects;

/**
 Calls `-fetchObjectsOfType:withPredicate:andSortDescriptors:` with the provided entity name and `NSPredicate`; then calls `-deleteObjects:` with the resulting `NSArray`.
 
 @param entityName The entity name of the `NSManagedObject` entity
 
 @param predicate The `NSPredicate` that will be used to filter the query.
 */
- (void) deleteObjectsOfType:(NSString *)entityName withPredicate:(NSPredicate*)predicate;

/**
 Executes the query with the provided `NSPredicate` for the `NSManagedObject` whose entity name matches the `NSString` entity name provided.
 
 Internally calls `-fetchObjectsOfType:withPredicate:andSortDescriptors:` in order to fulfill the initial query.
 
 @param entityName The entity name of the `NSManagedObject` entities to be queried.
 
 @param predicate The `NSPredicate` that will be used to filter the query.
 
 @return The count of `NSManagedObject` whose entity name matches `entityName` and fulfills the provided `predicate`.
 */
- (int) countObjectsOfType:(NSString *)entityName withPredicate:(NSPredicate*)predicate;

/**------------------------------------------------------------------------------------------------------------------
 * @name Arithmetic methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Executes the `NSExpression` associated to the provided `kPredefinedExpression` enum value to the column provided on the `NSManagedObject` whose entity name matches the one provided that also fulfills the `NSPredicate` provided.
 
 This method internally calls `-fetchObjectsOfType:withPredicate:andSortDescriptors:` to fulfill the provided filtering details.
 
 @param column The name of the column to be used as the field to execute the `NSExpression`.
 
 @param predefinedExpression The `kPredefiendExpression` enum value to be used when building the `NExpression`,
 
 @param entity The name of the `NSManagedObject` entities to be queried.
 
 @param predicate The `NSPredicate` that will be used to filter the query.
 
 @return The `int` resulting of executing the `NSExpression` to the to the column provided on the `NSManagedObject` with the provided entity name that satisfies the provided `NSPredicate`.
 */
- (int) scalarExpressionValueForColumn:(NSString *)column expression:(kPredefinedExpression)predefinedExpression entity:(NSString *)entity withPredicate:(NSPredicate*)predicate;

/**------------------------------------------------------------------------------------------------------------------
 * @name Querying
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns all the `NSManagedObject` objects whose entity name matches the one provided.
 
 @param entityName The name of the `NSManagedObject` entities to be queried.
 
 @return A `NSArray` containing all the `NSManagedObject` on the local database.
 */
- (NSArray*) allObjectsOfType:(NSString *)entityName;

/**
 Checks if there's a `NSManagedObject` in the database whose `idColumn` matches the provided `NSString` identifier.
 
 @param entityName The name of the `NSManagedObject` entities to be queried.
 
 @param idColumn The name of the column to be used to query looking for the provided identifier.
 
 @param identifier The `NSString` object that will be used as the key for searching an `NSManagedObject`.
 
 @return `YES` if there's a `NSManagedObject` that contains the provided `identifier` on the selected `idColumn`, `NO` otherwise.
 */
- (BOOL) hasEntityWithId:(NSString *)entityName
                idColumn:(NSString *)idColumn
              identifier:(NSString *)identifier;

/**
 Fetches a single object for the `NSManagedObject` whose entity name matches the one provided and fulfills the provided `NSPredicate`.
 
 @param entity The name of the `NSManagedObject` entities to be queried.
 
 @param predicate The `NSPredicate` that will be used to filter the query.
 
 @return The first `NSManagedObject` that matches the provided `predicate` on a `NSManagedObject` whose entity name matches the one provided.
 */
- (id) fetchSingleObject:(NSString *)entity
           withPredicate:(NSPredicate*)predicate;

/**
 Executes the provided `NSPredicate` on the `NSManagedObject` whose entity name matches the one provided sorted by the provided `NSArray` of `NSSortDescriptor`.
 
 @param entityName The name of the `NSManagedObject` entities to be queried.
 
 @param predicate The `NSPredicate` that will be used to filter the query.
 
 @param sortDescriptors A `NSArray` containing `NSSortDescriptor` objects that will be used to query the database.
 
 @return A `NSArray` of `NSManagedObject` that matches the provided `predicate`.
*/
- (NSArray*) fetchObjectsOfType:(NSString *)entityName
                  withPredicate:(NSPredicate*)predicate
             andSortDescriptors:(NSArray*)sortDescriptors;

@end

/**
 `NSManagedObject (ETCoreData)` is a helper category that provides better `NSManagedObject` handling.
 */
@interface NSManagedObject (ETCoreData)
/**------------------------------------------------------------------------------------------------------------------
 * @name Helper methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Checks if the instance of the `NSManagedObject` is new or not.
 
 @return `YES` if the `NSManagedObject` instance has never been saved, `NO` otherwise.
 */
- (BOOL) isNew;

/**
 Returns a `NSString` describing the entity name of the `NSManagedObject` instance.
 
 @return A `NSString` describing the entity name of the `NSManagedObject` instance.
 */
+ (NSString *) entityName;

/**
 Fills the `NSManagedObject` instance with the provided `NSDictionary` using KVO and the provided `NSDateFormatter`.
 
 @param keyedValues The `NSDictionary` containing the values to be used to fill the `NSManagedObject` instance.
 
 @param dateFormatter The `NSDateFormatter` that will be used to format all the `NSDate` objects contained in the `keyedValues` dictionaries.
 */
- (void) fillFromDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter;

@end

@class ETImage;

/**
 Wrapper that manages the `NSManagedObjectModel`, `NSManagedObjectContext` & `NSPersistentStoreCoordinator` for a local database
 */
@interface ETCoreDataStore : NSObject

/**------------------------------------------------------------------------------------------------------------------
 * @name Definition properties
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 The local path for the `NSManagedObjectModel` object.
 */
@property (nonatomic, retain) NSString * dataFilePath;

/**
 The `NSManagedObjectModel` created with the `-dataFilePath`.
 */
@property (nonatomic, retain) NSManagedObjectModel* managedObjectModel;

/**
 The `NSManagedObjectContext` linked to `-persistentStoreCoordinator`.
 */
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;

/**
 The `NSPersistentStoreCoordinator` that handles the `-managedObjectModel`.
 */
@property (nonatomic, retain) NSPersistentStoreCoordinator* persistentStoreCoordinator;

/**------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Initializes the `-dataFilePath` and then creates all the related objects (`-managedObjectModel`, `-managedObjectContext` & `-persistentStoreCoordinator`) based on that.
 
 @param dataFilePath The file path pointing to the `NSManagedObjectModel`.
 
 @return A fully initialized `ETCoreDataStore` object.
 */
- (id)initWithDataFile:(NSString *)dataFilePath;

/**------------------------------------------------------------------------------------------------------------------
 * @name Manipulation methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Iterates through the list of `NSManagedObject` on the local database and calls `deleteObjectsOfType:withPredicate` on `-managedObjectContext`.
 
 // @see `NSManagedObjectContext deleteObjectsOfType:withPredicate`
 // The @see statement was removed because appledoc can't find the crossreference
 */
- (void) clearDatabase;

/**
 Calls the `reset` method of the `-managedObjectContext`.
 */
- (void) cancelChanges;

/**
 Calls the `submitChanges` method on `managedObjectContext`.
 
 // @see `NSManagedObjectContext+(ETCoreData) deletedObjectsOfType:withPredicate`
 // The @see statement was removed because appledoc can't find the crossreference
 */
- (void) submitChanges;

/**------------------------------------------------------------------------------------------------------------------
 * @name Formatters
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns a caching `NSDateFormatter` with UTC `NSTimeZone` and the following format: `@"en_US_POSIX"`
 
 @return A `NSDateFormatter` with UTC `NSTimeZone` and `@"en_US_POSIX"` format.
 */
- (NSDateFormatter*) jsonDateFormatter;

/**------------------------------------------------------------------------------------------------------------------
 * @name Handling
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Checks whether or not the file at provided has been processed.
 
 @param fileName The name of the file to be checked.
 
 @return `YES` if the file with name `fileName` has been processed, `NO` otherwise.
 
 @see -markFileAsProcessed:
 */
- (BOOL) hasFileBeenProcessed:(NSString *)fileName;

/**
 Marks the file with name `fileName` as processed.
 
 @param fileName The name of the file to be marked as checked.
 
 @see -hasFileBeenProcessed:
 */
- (void) markFileAsProcessed:(NSString *)fileName;

/**------------------------------------------------------------------------------------------------------------------
 * @name Store manipulation
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Creates a new `NSManagedObject` whose name matches the provided entity name; filled with provided `JSON` dictionary. The provided `NSDateFormatter` is used to format the `NSDate` objects found on the `jsonDictionary`.
 
 @param jsonDictionary The `JSON` dictionary that will be used to populate the newly created `NSManagedObject` entity.
 
 @param entityName The `NSString` describing the entity name of the `NSManagedObject` instance.
 
 @param dateFormatter The `NSDateFormatter` that will be used to format the `NSDate` objects found on the `JSON` dictionary provided.
 
 @return A newly created `NSManagedObject` pre-populated with the provided `JSON` dictionary.
 */
- (id) insertObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName dateFormatter:(NSDateFormatter*)dateFormatter;

/**
 Creates a new `NSManagedObject` whose name matches the provided entity name; filled with provided `JSON` dictionary.
 
 This method internally calls `-insertObjectFromJson:entityName:dateFormatter:` with `-jsonDateFormatter` as the `NSDateFormatter`.
 
 @param jsonDictionary The `JSON` dictionary that will be used to populate the newly created `NSManagedObject` entity.
 
 @param entityName The `NSString` describing the entity name of the `NSManagedObject` instance.
 
 @return A newly created `NSManagedObject` pre-populated with the provided `JSON` dictionary.
 
 @see -insertObjectFromJson:entityName:dateFormatter:
 */
- (id) insertObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName;

/**
 Updates a `NSManageObject` instance whose entity name matches the one provided. The properties are set with the provided `JSON` dictionary and `KVO`.
 
 This method calls internally `-updateObjectFromJson:entityName:identifierKey:dateFormatter:` with `-jsonDateFormatter` as the `NSDateFormatter`.
 
 @param jsonDictionary The `JSON` dictionary that will be used to update the `NSManagedObject` entity retrieved from the database.
 
 @param entityName The `NSString` describing the entity name of the `NSManagedObject` instance.
 
 @return A `NSManagedObject` instance fetched from the database whose properties are updated with the provided `JSON` dictionary.
 
 @see -updateObjectFromJson:entityName:identifierKey:dateFormatter:.
 */
- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName;

/**
 Updates a `NSManageObject` instance whose entity name matches the one provided. The properties are set with the provided `JSON` dictionary and `KVO`.
 The provided `NSDateFormatter` is used to format the `NSDate` objects found on the `jsonDictionary`.
 
 This method internally calls `-updateObjectFromJson:entityName:predicate:dateFormatter:` in order to fetch the correct entity from the database.
 
 @param jsonDictionary The `JSON` dictionary that will be used to update the `NSManagedObject` entity retrieved from the database.
 
 @param entityName The `NSString` describing the entity name of the `NSManagedObject` instance.
 
 @param identifierKey The name of the unique identifier column/property that will be used to fetch an `NSManagedObject` instance from the database.
 
 @param dateFormatter The `NSDateFormatter` that will be used to format the `NSDate` objects found on the `JSON` dictionary provided.
 
 @return A `NSManagedObject` instance fetched from the database whose properties are updated with the provided `JSON` dictionary.
 
 @see -updateObjectFromJson:entityName:predicate:dateFormatter:.
 */
- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName identifierKey:(NSString *)identifierKey dateFormatter:(NSDateFormatter*)dateFormatter;

/**
 Updates a `NSManagedObject` instance whose entity name matches the one provided as well as the predicate provided. The properties are set with the provided `JSON` dictionary and `KVO`.
 The provided `NSDateFormatter` is used to format the `NSDate` objects found on the `jsonDictionary`.
 
 @param jsonDictionary The `JSON` dictionary that will be used to update the `NSManagedObject` entity retrieved from the database.
 
 @param entityName The `NSString` describing the entity name of the `NSManagedObject` instance.
 
 @param predicate The `NSPredicate` that will be used to fetch and filter the correct `NSManagedObject` instance to be formatted.
 
 @param dateFormatter The `NSDateFormatter` that will be used to format the `NSDate` objects found on the `JSON` dictionary provided.
 
 @return A `NSManagedObject` instance fetched from the database whose properties are updated with the provided `JSON` dictionary.
 */
- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName predicate:(NSPredicate*)predicate dateFormatter:(NSDateFormatter*)dateFormatter;

/** Adds all the `JSON` objects from the provided `jsonArray` via executing `addSingleSelector` on each one of them.
 This method calls internally `-addObjectsAsArrayFromJsonArray:addSingleSelector:` as the seed for a new `NSSet`
 
 @param jsonArray The `JSON` array containing the `JSON` objects that will be added to the database.
 @param addSingleSelector The specific `selector` that will be called with each object as a paramter to be added to the database.
 @return A `NSSet` containing all the `NSManagedObject` added to the database.
 @see -addObjectsAsArrayFromJsonArray:addSingleSelector:
 */
- (NSSet *)addObjectsFromJsonArray:(id)jsonArray addSingleSelector:(SEL)addSingleSelector;

/** Adds all the `JSON` objects from the provided `jsonArray` via executing `addSingleSelector` on each one of them.
 
 @param jsonArray The `JSON` array containing the `JSON` objects that will be added to the database.
 @param addSingleSelector The specific `selector` that will be called with each object as a paramter to be added to the database.
 @return A `NSArray` containing all the `NSManagedObject` added to the database.
 */
- (NSArray *)addObjectsAsArrayFromJsonArray:(id)jsonArray addSingleSelector:(SEL)addSingleSelector;

/**------------------------------------------------------------------------------------------------------------------
 * @name Other methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Generates an `NSPredicate` with the provided identifier.
 
 @param identifier The identifier to be passed on the newly created `NSPredicate` object.
 
 @return A `NSPredicate` generated by calling `[NSPredicate predicateWithFormat:@"identifier = %@", identifier]`.
 */
- (NSPredicate*) identifierPredicate:(id)identifier;

@end


