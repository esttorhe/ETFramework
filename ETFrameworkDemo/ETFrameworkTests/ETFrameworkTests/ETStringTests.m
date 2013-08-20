//
//  ETStringTests.m
//  ETFrameworkTests
//
//  Created by Esteban Torres on 8/18/13.
//
//

#import "ETStringTests.h"
#import "ETCoreFramework.h"
#import <OCMock/OCMock.h>
#import "NSBundle+ETFrameworkTests.h"

@implementation ETStringTests

- (void)testNSString
{
    NSString *string = @"";
    STAssertTrue([string containsNumbersOnly], @"containsNumbersOnly should have returned YES.");
    string = @"0123456789";
    STAssertTrue([string containsNumbersOnly], @"containsNumbersOnly should have returned YES.");
    string = @"0123456789.";
    STAssertFalse([string containsNumbersOnly], @"containsNumbersOnly should have returned NO.");
    STAssertTrue([string containsString:@"01234"], @"containsString: should have returned YES.");
    STAssertFalse([string containsString:@"Test"], @"containsString: should have returned NO.");
    
    string = @"``";
    NSData *hex = [string toHexData];
    STAssertNil(hex, @"toHexData should not have been able to generate a NSData object.");
    string = @"1";
    hex = [string toHexData];
    STAssertNil(hex, @"toHexData should not have been able to generate a NSData object.");
    string = @"12";
    hex = [string toHexData];
    STAssertNotNil(hex, @"toHexData should have been able to generate a NSData object.");
    
    NSDecimalNumber *intermediateNumber = [[NSDecimalNumber alloc] initWithFloat:50.0f];
    string = nil;
    string = [NSString formatCurrencyAmount:intermediateNumber withLocale:[NSLocale currentLocale]];
    STAssertNotNil(string, @"formatCurrencyAmount:withLocale: was not able to format NSDecimalNumber provided.");
    
    string = nil, string = [NSString generateRandomStringWithLength:3];
    STAssertEquals((NSUInteger)3, [string length], @"Unable to generate random string with lenght 3.");
    
    string = @"http://thisisatest.com?param1=test?param2=test2";
    STAssertEqualObjects([string parseQueryStringArg:@"param2"], @"test2", @"parseQueryStringArg: did not return the correct value.");
    STAssertNil([string parseQueryStringArg:@"nilParam"], @"parseQueryStringArg: should return nil when a param that's not present is requested.");
    
    string = @"     ";
    NSUInteger stringLenght = string.length;
    STAssertFalse([string trimWhitespace].length == stringLenght, @"Trimmed string should be smaller than the non trimmed one.");
}

- (void)testNSData
{
    NSString *string = @"12";
    NSData *data = [string toHexData];
    STAssertEqualObjects(string, [data toHexString], @"toHexString did not returned a valid NSString equal to the one that generated the NSData.");
    string = @"34";
    STAssertFalse([string isEqualToString:[data toHexString]], @"toHexString generated an invalid NSString.");
}

- (void)testNSNumber
{
    NSNumber *number = @50.5;
    NSString *string = [number formatAsCurrency];
    STAssertNotNil(string, @"Unable to formatAsCurrency.");
    number = nil;
    string = [number formatAsCurrency];
    STAssertNil(string, @"formatAsCurrency should return nil when nil seed provided.");
}

- (void)testNSDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 15, components.month = 10, components.year = 1985;
    components.hour = 21, components.minute = 0, components.second = 0;
    NSDate *date = [calendar dateFromComponents:components];
    STAssertNotNil(date, @"Unable to parse string");
    STAssertNotNil([date formatMMDDYY], @"formatMMDDYY [%@] returned an invalid object.", [date formatMMDDYY]);
    STAssertNotNil([date formatMonthDayYear], @"formatMonthDayYear [%@] returned an invalid object.", [date formatMonthDayYear]);
    STAssertNotNil([date formatMediumDate], @"formatMediumDate [%@] returned an invalid object.", [date formatMediumDate]);
    STAssertNotNil([date formatMediumDateTime], @"formatMediumDateTime [%@] returned an invalid object.", [date formatMediumDateTime]);
    STAssertNotNil([date formatYYYYMMdd_HHmmss], @"formatYYYYMMdd_HHmmss [%@] returned an invalid object.", [date formatYYYYMMdd_HHmmss]);
    STAssertNotNil([date formatUtcTimestamp], @"formatUtcTimestamp [%@] returned an invalid object.", [date formatUtcTimestamp]);
    STAssertNotNil([date formatUtcDate], @"formatUtcDate [%@] returned an invalid object.", [date formatUtcDate]);
    STAssertNotNil([date formatAsDeltaFromNow], @"formatAsDeltaFromNow[%@] returned a non-nil value.", [date formatAsDeltaFromNow]);
    date = [NSDate dateWithTimeIntervalSinceNow:20];
    STAssertNotNil([date formatAsDeltaFromNowWithTimeZoneAdjustment:NO], @"formatAsDeltaFromNowWithTimeZoneAdjustment:[%@] returned a non-nil value.", [date formatAsDeltaFromNowWithTimeZoneAdjustment:NO]);
    components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
    components.day+=1;
    date = [[NSCalendar currentCalendar] dateFromComponents:components];
    STAssertNotNil([date formatAsDeltaFromNowWithTimeZoneAdjustment:NO], @"formatAsDeltaFromNowWithTimeZoneAdjustment:[%@] returned a non-nil value.", [date formatAsDeltaFromNowWithTimeZoneAdjustment:NO]);
    
    STAssertEqualObjects([NSDate dayOfMonthSuffix:1], @"st", @"dayOfMonthSuffis: returned a wrong suffix: %@", [NSDate dayOfMonthSuffix:1]);
    STAssertEqualObjects([NSDate dayOfMonthSuffix:2], @"nd", @"dayOfMonthSuffis: returned a wrong suffix: %@", [NSDate dayOfMonthSuffix:2]);
    STAssertEqualObjects([NSDate dayOfMonthSuffix:3], @"rd", @"dayOfMonthSuffis: returned a wrong suffix: %@", [NSDate dayOfMonthSuffix:3]);
    STAssertEqualObjects([NSDate dayOfMonthSuffix:6], @"th", @"dayOfMonthSuffis: returned a wrong suffix: %@", [NSDate dayOfMonthSuffix:6]);
    STAssertEqualObjects([NSDate dayOfMonthSuffix:50], @"", @"dayOfMonthSuffis: returned a wrong suffix: %@", [NSDate dayOfMonthSuffix:50]);
    
    components.day = 15, components.month = 10, components.year = 1985, components.hour = 6;
    date = [calendar dateFromComponents:components];
    STAssertEqualObjects([date dayOfWeek], @"Tuesday", @"dayOfWeek returned wrong day for 1985-10-15 (Tuesday). %@", [components.date dayOfWeek]);
    STAssertEqualObjects([date monthOfYear], @"October", @"monthOfYear returned a wrong year. %@", [date monthOfYear]);
    STAssertEqualObjects([date dayOfMonth], @"15th", @"dayOfMonth returned a wrong day (15th). %@", [date dayOfMonth]);
    STAssertTrue([date numberOfYearsUntilNow] > 0, @"numbeOfYearsUntilNow returned a wrong number. %d", [date numberOfYearsUntilNow]);
    
    components.hour = 6, components.minute = 0, components.second = 0;
    STAssertEqualObjects([[calendar dateFromComponents:components] timeOfDay], @"12:00 AM", @"timeOfDay returned a wrong time. %@", [[calendar dateFromComponents:components] timeOfDay]);
    STAssertEqualObjects([[calendar dateFromComponents:components] verboseTimeOfDay], @"Tuesday, October 15th 12:00 AM", @"verboseTimeOfDay returned a wrong time. %@", [[calendar dateFromComponents:components] verboseTimeOfDay]);

    STAssertNotNil([NSBundle versionLabel], @"Version returned an empty value.");
    STAssertNotNil([NSBundle bundleIdentifier], @"Bundle Identifier returned an empty value.");
}

@end
