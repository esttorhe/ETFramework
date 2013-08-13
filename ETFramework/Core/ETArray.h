//
//  ETArray.h
//  Esteban Torres - NSArray/NSMutableArray categories
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `NSArray (ETArray)` is a helper category for easy manipulation of `NSArray`.
 */

@interface NSArray (ETArray)

/// ------------------------------------------------------------------------------------------------------------------
/// @name Sort Descriptors
/// ------------------------------------------------------------------------------------------------------------------

/** Creates a sort descriptor for the column provided in ascending order.
 
 This method calls internally `-sortDescriptor:ascending:` with `YES` as the `ascending` parameter.
 
 @param column **[Required]** The column name that will be used as the sort descriptor.
 @return An array containing the newly created sort descriptor with the column provided and ascending order.
 @see -sortDescriptor:ascending:
 @warning **`column`** parameter is required; if not provided will return `nil` unless `ETFRAMEWORK_RAISE_ASSERTS` is defined in which case will raise an exception.
 */
+ (NSArray*) sortDescriptor:(NSString *)column;

/**
 Creates a sort descriptor for the column provided with the provided order.
 
 @param column **[Required]** The column name that will be used as the sort descriptor.
 @param ascending Flag indicating wether or not the sort description should be created ascending or descending.
 @return An array containing the newly created sort descriptor with the column provided and provided ascending order.
 @warning **`column`** parameter is required; if not provided will return `nil` unless `ETFRAMEWORK_RAISE_ASSERTS` is defined in which case will raise an exception.
 */
+ (NSArray*) sortDescriptor:(NSString *)column ascending:(BOOL)ascending;


@end

/**
 `NSSet (ETSorting)` is a helper category for sorting `NSSet` objects.
 */

@interface NSSet (ETSorting)
/**------------------------------------------------------------------------------------------------------------------
 * @name Sorting methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Sorts the NSSet and returns it sorted ascending.
 
 This methods calls internally `-sortByField:ascending:` with `YES` as the `ascending` parameter.
 
 @param field **[Required]** The field used as the key to sort the NSSet.
 @return An array build from the NSSet objects sorted by the field in ascending order.
 @see -sortByField:ascending:
 @warning **`field`** parameter is required; if not provided will return `nil` unless `ETFRAMEWORK_RAISE_ASSERTS` is defined in which case will raise an exception.
 */
- (NSArray*) sortByField:(NSString *)field;

/**
 Sorts the NSSet and returns it sorted in the direction provided.
 
 @param field **[Required]** The field used as the key to sort the NSSet.
 @param ascending Flag indicating wether or not the sorting should be done ascending or descending.
 @return An array build from the NSSet objects sorted by the field in the provided ascending order.
 @warning **`field`** parameter is required; if not provided will return `nil` unless `ETFRAMEWORK_RAISE_ASSERTS` is defined in which case will raise an exception.
 */
- (NSArray*) sortByField:(NSString *)field ascending:(BOOL)ascending;

@end