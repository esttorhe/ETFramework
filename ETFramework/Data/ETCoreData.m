//
//  ETCoreData.h
//  Esteban Torres - Core Data categories
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "ETCoreFramework.h"
#import "ETCoreData.h"
#import "ETDebugLog.h"
#import <objc/runtime.h>

static NSString * const ET_CORE_DATA_STORE_IMPORT_FILES_KEY = @"ETCoreDataStoreImportFiles";
static NSString * const ET_DEFAULT_CORE_DATA_IDENTIFIER_KEYPATH = @"id";

#pragma mark - NSError (ETCoreData)
@implementation NSError (ETCoreData)

- (void) logDetailedErrors
{
    ETDebugLog(@"## ERROR: %@", [self localizedDescription]);
    NSArray* detailedErrors = [[self userInfo] objectForKey:NSDetailedErrorsKey];
    if (detailedErrors != nil && [detailedErrors count] > 0){
        for (NSError* de in detailedErrors){
            ETDebugLog(@"\t### DetailedError: %@", [de userInfo]);
        }
    }
    else{
        ETDebugLog(@"\t### %@", [self userInfo]);
    }
}

@end

#pragma mark - NSManagedObjectContext (ETCoreData)
@implementation NSManagedObjectContext (ETCoreData)

- (BOOL) submitChanges
{
    NSError* error = nil;
    if ([self hasChanges]){
        BOOL result = [self save:&error];
        
        if (!result){
            [error logDetailedErrors];
            [self reset];
            
            return NO;
        }
    }
    
    return YES;
}

- (NSArray*) fetchObjectsOfType:(NSString *)entityName
                      withPredicate:(NSPredicate*)predicate
                andSortDescriptors:(NSArray*)sortDescriptors
{
    return [self fetchObjectsOfType:entityName withPredicate:predicate andSortDescriptors:sortDescriptors queryLimit:nil shouldForceFaults:nil];
}

- (NSArray*) fetchObjectsOfType:(NSString *)entityName
                      withPredicate:(NSPredicate*)predicate
                andSortDescriptors:(NSArray*)sortDescriptors
                          queryLimit:(NSNumber*)limit
                    shouldForceFaults:(NSNumber*)shouldforceFaults
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self];
    fetchRequest.sortDescriptors = sortDescriptors;
    fetchRequest.predicate = predicate;
    
    if (limit){
        [fetchRequest setFetchLimit:[limit unsignedIntegerValue]];
    }
    
    if (shouldforceFaults){
        [fetchRequest setReturnsObjectsAsFaults:![shouldforceFaults boolValue]];
    }
    
    NSError* error = nil;
    NSArray* fetchResults = [self executeFetchRequest:fetchRequest error:&error];
    
    if (fetchResults == nil){
        [error logDetailedErrors];
        [self reset];
        
        return nil;
    }
    
    return fetchResults;
}

- (void) deleteObjects:(NSArray*)objects
{
    if (objects){
        for (NSManagedObject* obj in objects) {
            [self deleteObject:obj];
        }
        
        [self submitChanges];
    }
}

- (void) deleteObjectsOfType:(NSString *)entityName
               withPredicate:(NSPredicate*)predicate
{
    NSArray* objects = [self fetchObjectsOfType:entityName withPredicate:predicate andSortDescriptors:nil];
    [self deleteObjects:objects];
}

- (int) countObjectsOfType:(NSString *)entityName
             withPredicate:(NSPredicate*)predicate
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self];
    fetchRequest.predicate = predicate;
    fetchRequest.includesSubentities = NO;
    
    NSError* error = nil;
    int count = [self countForFetchRequest:fetchRequest error:&error];
    
    if (count == NSNotFound){
        ETDebugLog(@"### Failed to get count for entity %@", entityName);
        [error logDetailedErrors];
        [self reset];
        return 0;
    }
    
    return count;
}

- (NSArray*) allObjectsOfType:(NSString *)entityName
{
    return [self fetchObjectsOfType:entityName withPredicate:nil andSortDescriptors:nil];
}

- (int) scalarExpressionValueForColumn:(NSString *)column
                            expression:(kPredefinedExpression)predefinedExpression
                                entity:(NSString *)entity
                         withPredicate:(NSPredicate*)predicate
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:entity inManagedObjectContext:self];
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.predicate = predicate;
    
    NSExpression* keyPathExpression = [NSExpression expressionForKeyPath:column];
    NSExpression* minExpression = [NSExpression expressionForFunction:[self expressionNameFromPredefinedExpression:predefinedExpression] arguments:[NSArray arrayWithObject:keyPathExpression]];
    
    NSString * name = [NSString stringWithFormat:@"%@%@", [self expressionNameFromPredefinedExpression:predefinedExpression], column];
    NSExpressionDescription* expressionDescription = [[NSExpressionDescription alloc] init];
    expressionDescription.name = name;
    expressionDescription.expression = minExpression;
    expressionDescription.expressionResultType = NSInteger32AttributeType;
    
    fetchRequest.propertiesToFetch = [NSArray arrayWithObject:expressionDescription];
    
    NSError* error = nil;
    NSArray* fetchResults = [self executeFetchRequest:fetchRequest error:&error];
    
    int result = 0;
    if (!fetchResults){
        [error logDetailedErrors];
        [self reset];
        
        result = 0;
    }
    else if (fetchResults.count > 0){
        result = [[[fetchResults objectAtIndex:0] valueForKey:name] intValue];
    }
    
    return result;
}

- (BOOL) hasEntityWithId:(NSString *)entityName idColumn:(NSString *)idColumn identifier:(NSString *)identifier
{
    NSString * formatter = [NSString stringWithFormat:@"%@ = %@", idColumn, @"%@"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:formatter, identifier];
    return ([self countObjectsOfType:entityName withPredicate:predicate] > 0);
}

- (id) fetchSingleObject:(NSString *)entity withPredicate:(NSPredicate*)predicate
{
    NSArray* results = [self fetchObjectsOfType:entity withPredicate:predicate andSortDescriptors:nil queryLimit:[NSNumber numberWithUnsignedInteger:1] shouldForceFaults:nil];
    if (results != nil && results.count > 0)
    {
        return [results objectAtIndex:0];
    }
    
    return nil;
}

#pragma mark - Internal Helpers

- (NSString *) expressionNameFromPredefinedExpression:(kPredefinedExpression)predefinedExpression
{
    switch (predefinedExpression) {
        case kPredefinedExpressionFloor:
            return @"floor:";
            break;
        case kPredefinedExpressionBitwiseAndWith:
            return @"bitwiseAnd:with:";
            break;
        case kPredefinedExpressionBitwiseOrWith:
            return @"bitwiseOr:with:";
            break;
        case kPredefinedExpressionBitwiseXOrWith:
            return @"bitwiseXor:with:";
            break;
        case kPredefinedExpressionLeftShiftBy:
            return @"leftshift:by:";
            break;
        case kPredefinedExpressionRightShiftBy:
            return @"rightshift:by:";
            break;
        case kPredefinedExpressionOnesComplement:
            return @"onesComplement:";
            break;
        case kPredefinedExpressionLowercase:
            return @"lowercase:";
            break;
        case kPredefinedExpressionUppercase:
            return @"uppercase:";
            break;
        case kPredefinedExpressionNoIndex:
            return @"noindex:";
            break;
        default:
            ETDebugLog(@"Something went terribly wrong here…");
            break;
    }
    
    return @"";
}

@end

#pragma mark - NSManagedObject (ETCoreData)
@implementation NSManagedObject (ETCoreData)

+ (NSString *) entityName
{
    return NSStringFromClass([self class]);
}

- (BOOL) isNew
{
    NSDictionary* vals = [self committedValuesForKeys:nil];
    return (vals.count == 0);
}

- (void) fillFromDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter
{
    [self updateDataWithDictionary:keyedValues dateFormatter:dateFormatter];
}

@end

#pragma mark - ETCoreDataStore (PrivateInterface)
@interface ETCoreDataStore (PrivateInterface)

- (void) initCoreData;

@end

#pragma mark - ETCoreDataStore
@implementation ETCoreDataStore

@synthesize dataFilePath = _dataFilePath;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (id)initWithDataFile:(NSString *)dataFilePath
{
    self = [super init];
    if (self) 
    {
        self.dataFilePath = dataFilePath;
        [self initCoreData];
    }
    
    return self;
}

- (void) initCoreData
{
    NSURL* storeUrl = [NSURL fileURLWithPath:self.dataFilePath];
    
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSError* error;
    
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, 
                             nil];
    
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error])
    {
        ETDebugLog(@"Cannot Setup Core Data!");
        ETDebugLog(@"Error: %@", [error description]);
        exit(-1); 
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] init];
    [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    // Docs say this helps performance if you are not using the Core Data undo functionality.
    [self.managedObjectContext setUndoManager:nil];
}

- (void) clearDatabase
{
    for (NSEntityDescription* entity in self.managedObjectModel.entities)
    {
        ETDebugLog(@"Deleting table %@", entity.name);
        [self.managedObjectContext deleteObjectsOfType:entity.name withPredicate:nil];
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ET_CORE_DATA_STORE_IMPORT_FILES_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) cancelChanges
{
    [self.managedObjectContext reset];
}

- (void) submitChanges
{
    [self.managedObjectContext submitChanges];
}

- (NSDateFormatter*) jsonDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:kETDefuaultJSONDateFormatter];
    
    return dateFormatter;
}

- (BOOL) hasFileBeenProcessed:(NSString *)fileName
{
    NSDictionary* d = [[NSUserDefaults standardUserDefaults] dictionaryForKey:ET_CORE_DATA_STORE_IMPORT_FILES_KEY];
    return ([d objectForKey:[fileName lastPathComponent]] != nil);
}

- (void) markFileAsProcessed:(NSString *)fileName
{
    NSMutableDictionary* md = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:ET_CORE_DATA_STORE_IMPORT_FILES_KEY]];
    [md setObject:@"true" forKey:[fileName lastPathComponent]];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:md] forKey:ET_CORE_DATA_STORE_IMPORT_FILES_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName
{
    return [self updateObjectFromJson:jsonDictionary entityName:entityName identifierKey:ET_DEFAULT_CORE_DATA_IDENTIFIER_KEYPATH dateFormatter:[self jsonDateFormatter]];
}

- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName identifierKey:(NSString *)identifierKey dateFormatter:(NSDateFormatter*)dateFormatter
{
    if (jsonDictionary != nil && [jsonDictionary isKindOfClass:[NSDictionary class]])
    {
        id identifier = [jsonDictionary objectForKey:identifierKey];
        
        NSString * predicateString = [NSString stringWithFormat:@"%@ = %@", identifierKey, @"%@"];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateString, identifier];
        return [self updateObjectFromJson:jsonDictionary entityName:entityName predicate:predicate dateFormatter:dateFormatter];
    }
    
    return nil;
}

- (id) updateObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName predicate:(NSPredicate*)predicate dateFormatter:(NSDateFormatter*)dateFormatter
{
    if (jsonDictionary != nil && [jsonDictionary isKindOfClass:[NSDictionary class]])
    {
        id obj = nil;
        
        if (predicate != nil)
        {
            obj = [self.managedObjectContext fetchSingleObject:entityName withPredicate:predicate];
        }
        
        if (obj == nil)
        {
            obj = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
        }
        
        [obj fillFromDictionary:jsonDictionary dateFormatter:dateFormatter];
        return obj;
    }
    
    return nil;
}

- (id) insertObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName
{
    return [self insertObjectFromJson:jsonDictionary entityName:entityName dateFormatter:[self jsonDateFormatter]];
}

- (id) insertObjectFromJson:(id)jsonDictionary entityName:(NSString *)entityName dateFormatter:(NSDateFormatter*)dateFormatter
{
    id obj = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [obj fillFromDictionary:jsonDictionary dateFormatter:dateFormatter];
    return obj;
}

- (NSSet *) addObjectsFromJsonArray:(id)jsonArray addSingleSelector:(SEL)addSingleSelector
{
    return [NSSet setWithArray:[self addObjectsAsArrayFromJsonArray:jsonArray addSingleSelector:addSingleSelector]];
}

- (NSArray *)addObjectsAsArrayFromJsonArray:(id)jsonArray addSingleSelector:(SEL)addSingleSelector
{
    NSMutableArray* results = nil;
    
    if (jsonArray != nil && addSingleSelector != nil && [self respondsToSelector:addSingleSelector])
    {
        results = [NSMutableArray array];
        
        for (id node in jsonArray)
        {
            id obj = nil;
            /// *********************************************************** ///
            /// * Adding some pragmas to suppress the memory leak warning * ///
            SuppressPerformSelectorLeakWarning(obj = [self performSelector:addSingleSelector withObject:node]);
            /// *********************************************************** ///
            if (obj != nil)
            {
                [results addObject:obj];
            }
        }
    }
    
    return [NSArray arrayWithArray:results];
}

- (NSPredicate*) identifierPredicate:(id)identifier
{
    return [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
}

@end
