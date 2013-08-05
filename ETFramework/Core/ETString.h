//
//  ETString.h
//  Esteban Torres
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSString+ETStringTampering
/**
 `NSString (ETStringTampering)` is a category that expands `NSString` objects to provide formatting and validation specific methods.
*/
@interface NSString (ETStringTampering)
/**------------------------------------------------------------------------------------------------------------------
 * @name Type specific helpers.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Checks that every character on the `NSString` instance is a number type character.
 
 @return `YES` if all the characters contained on the `NSString` instance ara numbers `NO` otherwise.
 */
- (BOOL) containsNumbersOnly;

/**
 Checks if the `NSString` instance contains the provided substring within itself.
 
 @param subString The `NSString` substring that needs to be contained in the `NSString` instance.
 
 @return `YES` if the provided subString is contained within the `NSString` instance `NO` otherwise.
 */
- (BOOL) containsString:(NSString *)subString;
/**------------------------------------------------------------------------------------------------------------------
 * @name Formatting methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Converts the `NSString` object to a `NSData` object formatted in hexadecimal type.
 
 @return A `NSData` object with the `NSString` formatted as a hexadecimal bytes array.
 */
- (NSData *) toHexData;

/**
 Formats a `NSDecimalNumber` object to a currency formatted `NSString` with the provided `NSLocale`.
 
 @param value The `NSDecimalNumber` that will be currency formatted.
 
 @param locale The `NSLocale` that will be used to format the provided amount as a currency `NSString`.
 
 @return The provided `NSDecimalNumber` formatted as a currency `NSString` using the provided `NSLocale`.
 */
+ (NSString *) formatCurrencyAmount:(NSDecimalNumber *)value withLocale:(NSLocale *)locale;

/**------------------------------------------------------------------------------------------------------------------
 * @name String generation methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Generate a `NSString` object with random characters with the length provided.
 
 @param length The lenght of the randomly generated `NSString`.
 
 @return A `NSString` object composed of random characters with a length equal to the provided parameter.
 */
+ (NSString *) generateRandomStringWithLength:(NSInteger )length;

/**------------------------------------------------------------------------------------------------------------------
 * @name Manipulation methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/** 
 Extracts the part after the '=' in a typical HTTP query string.
 
 `NSString * url = http://www.someURL.dot?someArgument=foobar&anotherArgument=blarfo`
 
 `NSString * arg = [url parseQueryStringArg:@"someArgument"];`
 
 **arg is 'foobar'**
 
 @param argName The name of the argument to look within the `URL` provided.
 
 @return The `NSString` object associated to the arument provided (if any, `nil` if none).
 */
- (NSString *) parseQueryStringArg:(NSString *)argName;

/**
 Returns a `NSString` object after removing the whitespaces from left and right side of the `NSString` instance.
 
 @return The `NSString` object after removing the whitespaces from left and right.
 */
- (NSString *) trimWhitespace;

@end

#pragma mark - NSData+ETStringTampering
/**
 `NSData (ETStringTampering)` is a helper category that provides `NSString` capabilities to `NSData` objects.
 */
@interface NSData (ETStringTampering)
/**------------------------------------------------------------------------------------------------------------------
 * @name NSString formatting.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Formats the `NSData` instance as a hex `NSString`.
 
 @return A `NSString` hex version of the `NSData` instance.
 */
- (NSString *) toHexString;

@end

#pragma mark - NSNumber+ETStringTampering
/**
 `NSNumber (ETStringTampering)` is a helper category class that provides
 */
@interface NSNumber (ETStringTampering)
/**------------------------------------------------------------------------------------------------------------------
 * @name Currency formatting methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Formats the `NSNumber` instance as a currency `NSString` using the current `NSLocale`.
 
 @return A `NSString` object containing the `NSNumber` instance formatted using the current `NSLocale`.
 */
- (NSString *) formatAsCurrency;

/**
 Formats the `NSNumber` instance as a currency `NSString` using the provided `NSLocale`.
 
 @param locale The `NSLocale` that will be used to format the `NSNumber` instance as a `NSString`.
 
 @return A `NSString` object containing the `NSNumber` instance formatted using the provided `NSLocale`.
 */
- (NSString *) formatAsCurrency:(NSLocale *)locale;

@end

#pragma mark - NSDate+ETStringTampering
/**
 `NSDate (ETStringTampering)` is a helper category that provides a bunch of `NSString` formatting methods.
 
 ### Formatting
 Provided a set of pre-defined formatting methods for the most common `NSDate` formatting needs.
 
 ### Components extraction
 Provides a set of `NSDate` components extraction in an easy and straigh forward way.
 */
@interface NSDate (ETStringTampering)
/**------------------------------------------------------------------------------------------------------------------
 * @name Formatting methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/** 
 Formats the `NSDate` instance as a `NSString` using the following format: `MM-DD-YYYY`.
 
 @return A `NSString` object containing the `NSDate` instance formatted with the following formatter: `MM-DD-YYYY`.
 */
- (NSString *) formatMonthDayYear;

/**
 Formats the `NSDate` instance as a `NSString` using the following format: @"yyyy-MM-dd HH:mm:ss".
 
 @return A `NSString` object containing the `NSDate` instance formatted with the following formatter: @"yyyy-MM-dd HH:mm:ss".
 */
- (NSString *) formatYYYYMMdd_HHmmss;

/**
 Formats the `NSDate` instance as a `NSString` using the following format: @"yyyy-MM-dd HH:mm:ss" and UTC `NSTimeZone`.
 
 @return A `NSString` object containing the `NSDate` instance formatted with the following formatter: @"yyyy-MM-dd HH:mm:ss" and `NSTimeZone`.
 */
- (NSString *) formatUtcTimestamp;

/**
 Formats the `NSDate` instance as a `NSString` using the following format: @"yyyy-MM-dd" and UTC `NSTimeZone`.
 
 @return A `NSString` object containing the `NSDate` instance formatted with the following formatter: @"yyyy-MM-dd" and UTC `NSTimeZone`.
 */
- (NSString *) formatUtcDate;

/**
 Formats the `NSDate` instance as a `NSString` in a "human comprehensive" delta.
 
 e.g: **"22 minutes ago" or "1 day ago"**
 
 @return A `NSString` delta containing the time lapse between "now"(`[NSDate date]`) and the `NSDate` instance.
 */
- (NSString *) formatAsDeltaFromNow;

/**
 Formats the `NSDate` instance as a `NSString` in a "human comprehensive" delta with `NSTimeZone` adjustment if desired.
 
 e.g: **"22 minutes ago" or "1 day ago"**
 
 @param adjustTimeZone A boolean flag indicating wether or not to to `NSTimeZone` adjustment to the time lapse calculation.
 
 @return A `NSString` delta containing the time lapse between "now"(`[NSDate date]`) and the `NSDate` instance with `NSTimeZone` adjustment if desired.
 */
- (NSString *) formatAsDeltaFromNowWithTimeZoneAdjustment:(BOOL)adjustTimeZone;

/**
 Formats the `NSDate` instance as a `NSString` with the following time style: `NSDateFormatterNoStyle` and the following date style: `NSDateFormatterShortStyle`.
 
 e.g.: **Oct 15, 1985**
 
 @return A `NSString` object containing the `NSDate` instance formatted with `NSDateFormatterNoStyle` time style and `NSDateFormatterShortStyle` date style.
 */
- (NSString *) formatMediumDate;

/**
 Formats the `NSDate` instance as a `NSString` with the following time style: `NSDateFormatterMediumStyle` and the following date style: `NSDateFormatterShortStyle`.
 
 e.g.: **Oct 15, 1985 09:00pm**
 
 @return A `NSString` object containing the `NSDate` instance formatted with `NSDateFormatterMediumStyle` time style and `NSDateFormatterShortStyle` date style.
 */
- (NSString *) formatMediumDateTime;

/**
 Formats the `NSDate` instance as a `NSString` with the following format: `@"MM/DD/YY"`.
 
 e.g.: **10/15/85**
 
 @return A `NSString` object containing the `NSDate` instance with the following format: `@"MM/DD/YY"`.
 */
- (NSString *) formatMMDDYY;

/**
 Formats the `NSDate` instance as a `NSString` with the following format: `@"MM[separator]DD[separator]YY"` with the [separator] provided.
 
 @param separator The `NSString` separator character that will be used to separate the `NSDate` components.
 
 e.g.: **10 [separator] 15 [separator] 85**
 
 @return A `NSString` object containing the `NSDate` instance with the following format: `@"MM[separator]DD[separator]YY"` with the [separator] provided.
 */
- (NSString *) formatMMDDYY:(NSString *)separator;

/**------------------------------------------------------------------------------------------------------------------
 * @name Components extraction.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns the day of the month suffix in english.
 
 e.g.: `[NSString dayOfMonthSuffix:1];` returns **st**
 
 @param dayOfMonth The day of the month to be used as the suffix retrieving "key".
 
 @return A `NSString` object containing the pertaining suffix in English for the provided day number.
 */
+ (NSString *) dayOfMonthSuffix:(int)dayOfMonth;

/**
 Returns a `NSString` day of week in English for the `NSDate` instance.
 
 e.g.: **'Monday'** thru **'Sunday'**
 */
- (NSString *) dayOfWeek;

/**
 Returns a `NSString` month of year for the `NSDate` instance.
 
 @return A `NSString` with the month of the year for the `NSDate` instance.
 */
- (NSString *) monthOfYear;

/**
 Returns the day of month plus suffix for the `NSDate` instance.
 
 e.g: **15th**
 
 @return A `NSString` containing the day of the month plus the suffix of the `NSDate` instance.
 */
- (NSString *) dayOfMonth;

/**
 Returns a `NSString` with the time of day with am/pm for the `NSDate`.
 
 e.g.: **"9:52 am"**
 
 @return A `NSString` containing the time of the day with am/pm for the `NSDate` instance.
 */
- (NSString *) timeOfDay;

/**
 Returns the amount of years from the `NSDate` instance until now(`[NSDate date]`).
 
 @return The amount of years from the `NSDate` instance until now(`[NSDate date]`).
 */
- (int) numberOfYearsUntilNow;

/**
 Returns a fully formatted `NSString` object containing the detailed `NSDate` instance in English.
 
 e.g.: **Monday, October 1st 09:35am**
 
 @return A fully formatted `NSString` object containing the detailed `NSDate` instance in English.
 */
- (NSString *) verboseTimeOfDay;

@end

#pragma mark - NSBundle+ETStringTampering
/**
 `NSBundle (ETStringTampering)` is a helper category that provides methods to easily access some `NSBundle` properties.
 */
@interface NSBundle (ETStringTampering)
/**------------------------------------------------------------------------------------------------------------------
 * @name Detailed data accesors.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns a `NSString` object containing the value for the `CFBundleShortVersionString` `NSBundle` key.
 */
+ (NSString *) versionLabel;

/**
 Returns a `NSString` object containing the value for the `NSHumanReadableCopyright` `NSBundle` key.
 */
+ (NSString *) copyrightLabel;

/**
 Returns a `NSString` object containing the value for the `CFBundleIdentifier` `NSBundle` key.
 */
+ (NSString *) bundleIdentifier;

@end



