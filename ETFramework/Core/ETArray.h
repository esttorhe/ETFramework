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

/**------------------------------------------------------------------------------------------------------------------
 * @name Sort Descriptors
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Creates a sort descriptor for the column provided in ascending order.
 
 @param column The column name that will be used as the sort descriptor.
 
 @return An array containing the newly created sort descriptor with the column provided and ascending order.
 */
+ (NSArray*) sortDescriptor:(NSString *)column;

/**
 Creates a sort descriptor for the column provided with the provided order.
 
 @param column The column name that will be used as the sort descriptor.
 
 @param ascending Flag indicating wether or not the sort description should be created ascending or descending.
 
 @return An array containing the newly created sort descriptor with the column provided and provided ascending order.
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
 
 @param field The field used as the key to sort the NSSet.
 
 @return An array build from the NSSet objects sorted by the field in ascending order.
 */
- (NSArray*) sortByField:(NSString *)field;

/**
 Sorts the NSSet and returns it sorted in the direction provided.
 
 @param field The field used as the key to sort the NSSet.
 
 @param ascending Flag indicating wether or not the sorting should be done ascending or descending.
 
 @return An array build from the NSSet objects sorted by the field in the provided ascending order.
 */
- (NSArray*) sortByField:(NSString *)field ascending:(BOOL)ascending;

@end