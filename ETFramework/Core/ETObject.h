//
//  ETObject.h
//  Esteban Torres - NSObject categories
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `NSObject (ETFramework)` is a helper class that provides extra methods for better and easiest handling of `NSObject`.
 
 ### Attaching extra data
 * Provides helper methods to attach and retrieve objects to specific `NSObject`.
 
 ### NSDictionary initialization and manipulation
 * Provides some extra methods to manipulate `NSDictionary` objects.
 
 ### Helper methods
 * Also provides some extra methods available as `C` functions.
 */
@interface NSObject (ETFramework)
/**------------------------------------------------------------------------------------------------------------------
 * @name Runtime data linking.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Dynamically attach an object to a `NSObject` instance using the `runtime` framework with a predefined key.
 
 This method calls internally `-attachUserInfo:forKey:` with a predefined internal key.
 
 @param userInfo The object that will be 'linked' to the `NSObject` instance.
 
 @see -attachUserInfo:forKey:
 */
- (void) attachUserInfo:(id)userInfo;

/**
 Retrieves the object attached to the `NSObject` instance 'linked' with the predefined key.
 
 This method calls internally `-userInfoForKey:` with a predefined internal key.
 
 @return The object attached to the `NSObject` instance 'linked' with the predefined key.
 
 @see -userInfoForKey:
 */
- (id) userInfo;

/**
 Dynamically attach an object to a `NSObject` instance using the `runtime` framework and links it using the provided key.
 
 @param userInfo The object that will be 'linked' to the `NSObject` instance.
 
 @param key The custom key that will be used to attach the object to the `NSObject` instance.
 */
- (void) attachUserInfo:(id)userInfo forKey:(char const *)key;

/**
 Retrieves the object attached to the `NSObject` instance using the provided key.
 
 @param key The custom key that will be used to try and retrieve a 'linked' object with this `NSObject` instance.
 
 @return The object attached to the `NSObject` instance 'linked' with the provided key.
 */
- (id) userInfoForKey:(char const *)key;

/**------------------------------------------------------------------------------------------------------------------
 * @name KVO manipulation methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Initializes an `NSObject` using the provided `NSDictionary` object and KVC.
 
 This method internally calls `-initFromDictionary:dateFormatter:` with `[NSDateFormatter ETDefaultDateFormatter]` as the `NSDateFormatter` parameter.
 
 @param dictionary The `NSDictionary` object that will be used to 'feed' the `NSObject` properties.
 
 @return An initialized `NSObject` instance with the properties set to the matching keys/fields provided by the defined `NSDictionary`.
 
 @see -initFromDictionary:dateFormatter:
 */
- (id) initFromDictionary:(NSDictionary*)dictionary;

/**
 Initializes an `NSObject` using the provided `NSDictionary` object and KVC with the provided `NSDateFormatter`.
 
 @param dictionary The `NSDictionary` object that will be used to 'feed' the `NSObject` properties.
 
 @param dateFormatter The `NSDateFormatter` that will be used to format all the `NSDate` objects found on the provided `NSDictionary`.
 
 @return An initialized `NSObject` instance with the properties set to the matching keys/fields provided by the defined `NSDictionary`.
 */
- (id) initFromDictionary:(NSDictionary*)dictionary dateFormatter:(NSDateFormatter*)dateFormatter;

/**
 Updates an `NSObject` using the provided `NSDictionary` object and KVC.
 
 This methods internally calls `-updateDataWithDictionary:dateFormatter:` with `[NSDateFormatter ETDefaultDateFormatter]` as the `NSDateFormatter` parameter.
 
 @param dictionary The `NSDictionary` object that will be used to 'feed' the `NSObject` properties.
 
 @return The `NSObject` instance with its properties set to the matching keys/fields provided by the defined `NSDictionary`.
 
 @see -updateDataWithDictionary:dateFormatter:
 */
- (id) updateDataWithDictionary:(NSDictionary*)dictionary;

/**
 Updates an `NSObject` using the provided `NSDictionary` object and KVC with the provided `NSDateFormatter`.
 
 @param dictionary The `NSDictionary` object that will be used to 'feed' the `NSObject` properties.
 
 @param dateFormatter The `NSDateFormatter` that will be used to format all the `NSDate` objects found on the provided `NSDictionary`.
 
 @return The `NSObject` instance with its properties set to the matching keys/fields provided by the defined `NSDictionary`.
 */
- (id) updateDataWithDictionary:(NSDictionary*)dictionary dateFormatter:(NSDateFormatter*)dateFormatter;

/** Compares if the first value is null then return the second value.
 */
id is_null(id A, id B);

/** Compares the `object` param agains `nil` and against `[NSNull null]` and returns the BOOLEAN comparison.
 */
bool isNilOrNull(id object);

@end

/**
 `NSTimer (ETTimerBlocks)` is a helper category that will provide some `blocks` functionalities to `NSTimer` objects.
 */
@interface NSTimer (ETTimerBlocks)
/**------------------------------------------------------------------------------------------------------------------
 * @name Blocks handling.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Creates a new `NSTimer` object that will execute the provided `block` after the specified interval.
 
 @param timeInterval The `NSTimeInterval` after which the generated `NSTimer` will fire the provided `block`.
 
 @param block The code `block` that will be executed when the time interval provided passes.
 
 @return A newly initialized `NSTimer` object configured to fire the code `block` after the provided interval.
 */
+ (NSTimer*) delay:(NSTimeInterval)timeInterval andExecuteBlock:(void (^)(void))block;

@end

/**
 `NSDate (ETTimeZoneConversion)` is a category that provides some helper functions to easily convert between timezones.
 */
@interface NSDate (ETTimeZoneConversion)
/**------------------------------------------------------------------------------------------------------------------
 * @name Localization methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Converts the `NSDate` object to device's current local time.
 
 @return The current `NSDate` object converted to the device's current local time.
 */
- (NSDate *) convertToLocalTime;

@end

/**
 `NSDateFormatter (ETFramework)` is a category that easily provides pre-defined `NSDateFormatter` objects using caching to avoid overhead when generating new formatters.
 */
@interface NSDateFormatter (ETFramework)
/**------------------------------------------------------------------------------------------------------------------
 * @name Static re-usable formatters.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns a cached `NSDateFormatter` (if not cached then creates a new one) with the following format `@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"`.
 
 @return `NSDateFormatter` with the following pre-defined format: `@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"`.
 */
+ (NSDateFormatter*) ETDefaultDateFormatter;

/**
 Returns a cached `NSDateFormatter` (if not cached then creates a new one) with the following format `@"yyyy-MM-dd'T'HH:mm:ss'Z'"`.
 
 @return `NSDateFormatter` with the following pre-defined format: `@"yyyy-MM-dd'T'HH:mm:ss'Z'"`.
 */
+ (NSDateFormatter*) ETDefaultJSONDateFormatter;

@end

/**
 `NSNumberFormatter (ETFramework)` is a category that easily provides pre-defined `NSNumberFormatter` objects using caching to avoid overhead when generating new formatters.
 */
@interface NSNumberFormatter (ETFramework)
/**------------------------------------------------------------------------------------------------------------------
 * @name Static re-usable formatters.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns a cached `NSNumberFormatter` (if not cached then creates a new one) with the following number style: `NSNumberFormatterDecimalStyle`.
 
 @return `NSDateFormatter` with the following pre-defined number style: `NSNumberFormatterDecimalStyle`.
 */
+ (NSNumberFormatter *)sharedInstance;

@end