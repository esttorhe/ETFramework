//
//  ETString.h
//  Esteban Torres
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSString+ETStringTampering
@interface NSString (ETStringTampering)

- (BOOL) containsNumbersOnly;
- (NSData*) toHexData;
+ (NSString *) generateRandomStringWithLength:(NSInteger )length;
+ (NSString*) formatCurrency:(NSDecimalNumber*)value WithLocale:(NSLocale*)locale;

// Extracts the part after the '=' in a typical HTTP query string.
//
// NSString* url = http://www.threejacks.com?someArg=foobar&anotherArg=blarfo
// NSString* arg = [url parseQueryStringArg:@"someArg"];
// arg is 'foobar'
- (NSString*) parseQueryStringArg:(NSString*)argName;

- (NSString*) trimWhitespace;
- (BOOL) containsString:(NSString*)subString;

@end

#pragma mark - NSData+ETStringTampering
@interface NSData (ETStringTampering)

- (NSString*) toHexString;

@end

#pragma mark - NSNumber+ETStringTampering
@interface NSNumber (ETStringTampering)

- (NSString*) formatAsCurrency;
- (NSString*) formatAsCurrency:(NSLocale*)locale;

@end

#pragma mark - NSDate+ETStringTampering
@interface NSDate (ETStringTampering)

// MM-DD-YYYY
- (NSString*) formatMonthDayYear;

// @"yyyy-MM-dd HH:mm:ss"
- (NSString*) formatYYYYMMdd_HHmmss;
- (NSString*) formatUtcTimestamp;

// @"yyyy-MM-dd"
- (NSString *) formatUtcDate;

// "22 minutes ago" or "1 day ago"
- (NSString*) formatAsDeltaFromNow;

- (NSString*) formatAsDeltaFromNow:(BOOL)adjustTimeZone;

// Apr 16, 1978
- (NSString*) formatMediumDate;

// Apr 16, 1978 03:30pm
- (NSString*) formatMediumDateTime;

// 04/26/78
- (NSString*) formatMMDDYY;

// 04 [separator] 26 [separator] 78
- (NSString*) formatMMDDYY:(NSString*)separator;

+ (NSString*) dayOfMonthSuffix:(int)dayOfMonth;

// Returns a string day of week, 'Monday' thru 'Sunday'
- (NSString*) dayOfWeek;

// Returns a string month of year
- (NSString*) monthOfYear;

// Returns day of month plus suffix, ie 26th
- (NSString*) dayOfMonth;

// Returns time of day with am/pm, "9:52 am"
- (NSString*) timeOfDay;

// Returns the amount of years from the date until now
- (int) numberOfYearsUntilNow;

- (NSString*) verboseTimeOfDay;

@end

#pragma mark - NSBundle+ETStringTampering
@interface NSBundle (ETStringTampering)

+ (NSString*) versionLabel;
+ (NSString*) copyrightLabel;
+ (NSString*) bundleIdentifier;

@end



