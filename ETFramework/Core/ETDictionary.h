//
//  ETDictionary.h
//  Esteban Torres - NSDictionary/NSMutableDictionary categories
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `NSMutableDictionary (ETFramework)` its a helper category that provides better handling methods for `NSMutableDictionary` objects.
 */
@interface NSMutableDictionary (ETFramework)
/**------------------------------------------------------------------------------------------------------------------
 * @name Validation Helpers
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Verifies that neither the object nor the key are nill and if so adds the object with the specified key to the `NSMutableDictionary`.
 
 @param obj The object to be added to the `NSMutableDictionary`.
 
 @param key The key that will be "linked" to the provided object.
 */
- (void)setObjectIfNotNil:(id)obj forKey:(id)key;

@end

extern NSString * const kDefaultETDateFormatter;
extern NSString * const kETRFC3339DateFormatter;
extern NSString * const kETDefuaultJSONDateFormatter;

/**
 `NSDictionary (ETFramework)` its a helper category that provides better handling methods for `NSDictionary` objects.
*/
@interface NSDictionary (ETFramework)
/**------------------------------------------------------------------------------------------------------------------
 * @name Validation methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Retrieves an object associated to the provided key if said objects is not `nil` nor `NSNull`.
 
 @param key The object key that will be used to fetch the desired object.
 
 @return The non `nil` non `NSNull` object associated to the provided key.
 */
- (id) nonNullObjectForKey:(NSString *)key;

/**------------------------------------------------------------------------------------------------------------------
 * @name Type specific retrieval methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Retrieves a `NSDate` object associated to the specified key with the provided `NSDateFormatter` if any.
 
 @param key The object key that will be used to fetch the desired `NSDate` object.
 
 @param dateFormatter The `NSDateFormatter` that will be used to format the retrieved object. 
 Can be `nil`.
 
 @return The `NSDate` object associated to the provided key (formatted if any `NSDateFormatter` was provided).
 */
- (NSDate *) dateForKey:(NSString *)key withFormatter:(NSDateFormatter *)dateFormatter;

/**
 Retrieves a `NSDictionary` object associated to the specified key.
 
 @param key The object key that will be used to fetch the desired `NSDictionary` object.
 
 @return The `NSDictionary` object associated to the provided key.
 */
- (NSDictionary *) dictionaryForKey:(NSString *)key;
   
@end