//
//  ETString.m
//  Esteban Torres
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "ETString.h"

#pragma mark - NSString+ETStringTampering
@implementation NSString (ETStringTampering)

- (BOOL) containsNumbersOnly
{
    if (!self.length) // allow backspace
    {
        return YES;
    }
    
    // remove invalid characters from input, if keyboard is numberpad
    if ([self rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
    {
        // BasicAlert(@"", @"This field accepts only numeric entries.");
        
        return NO;
    }
    
    return YES;
}

- (NSData *) toHexData
{
	int length = self.length;
	
	// Must be divisible by two
	if ((length % 2) != 0)
		return nil;
	
	NSMutableData* data = [[NSMutableData alloc] init];
	
	for (int i = 0; i < length; i += 2)
	{
		NSScanner* sc = [NSScanner scannerWithString:(NSString *)[self substringWithRange:NSMakeRange(i, 2)]];
		unsigned int hex = 0;
		if ([sc scanHexInt:&hex])
		{
            UInt8 tmp = (UInt8)hex;
            [data appendBytes:&tmp length:sizeof(tmp)];
		}
		else
		{
			return nil;
		}
	}
	
	return data;
}

+ (NSString *) generateRandomStringWithLength:(NSInteger)length
{
    char data[length];
    for (int x=0;x<length;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

+ (NSString *) formatCurrencyAmount:(NSDecimalNumber *)value withLocale:(NSLocale *)locale
{
    NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterCurrencyStyle;
    nf.locale = locale;
    return [nf stringForObjectValue:value];
}

- (NSString *) parseQueryStringArg:(NSString *)argName
{
    NSString * wholeArgName = [NSString stringWithFormat:@"%@=", argName];
    if ([self rangeOfString:wholeArgName].location != NSNotFound)
    {
        NSString * authError = [[self componentsSeparatedByString:@"="] lastObject];
        return authError;
    }
    
    return nil;
}

- (NSString *) trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL) containsString:(NSString *)subString
{
    BOOL isStringThere = YES;
    NSRange rangeOfSubString  = [self rangeOfString:subString];

    if (rangeOfSubString.location == NSNotFound)
    {
        isStringThere = NO;
    }
    
    return isStringThere;
}

@end

#pragma mark - NSData+ETStringTampering
@implementation NSData (ETStringTampering)

- (NSString *) toHexString
{
	NSMutableString* sb = [[NSMutableString alloc] init];
    
    const char* rawData = [self bytes];
    int count = self.length;
    for (int i = 0; i < count; i++)
    {
        [sb appendFormat:@"%02X", (UInt8)rawData[i]];
    }
    
	return sb;
}

@end

#pragma mark - NSNumber+ETStringTampering
@implementation NSNumber (ETStringTampering)

- (NSString *) formatAsCurrency
{
    return [self formatAsCurrency:[NSLocale currentLocale]];
}

- (NSString *) formatAsCurrency:(NSLocale *)locale
{
    NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterCurrencyStyle;
    nf.locale = locale;
    return [nf stringForObjectValue:self];
}

@end

#pragma mark - NSDate+ETStringTampering
@implementation NSDate (ETStringTampering)

- (NSString *) formatMonthDayYear
{
	int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	NSDateComponents* dc = [[NSCalendar currentCalendar] components:flags fromDate:self];
	return [NSString stringWithFormat:@"%02d-%02d-%04d", dc.month, dc.day, dc.year];
}

- (NSString *) formatMMDDYY
{
    return [self formatMMDDYY:@"/"];
}

- (NSString *) formatMMDDYY:(NSString *)separator
{
	int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	NSDateComponents* dc = [[NSCalendar currentCalendar] components:flags fromDate:self];
	return [NSString stringWithFormat:@"%02d%@%02d%@%02d", dc.month, separator, dc.day, separator, dc.year];
}

static NSDateFormatter* kMediumDateFormatter = nil;
+ (NSDateFormatter*) cachedMediumDateFormatter
{
    if (kMediumDateFormatter == nil)
    {
        kMediumDateFormatter = [[NSDateFormatter alloc] init];
        [kMediumDateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [kMediumDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    
    return kMediumDateFormatter;
}

static NSDateFormatter* kMediumDateTimeFormatter = nil;
+ (NSDateFormatter *) cachedMediumDateTimeFormatter
{
    if (kMediumDateTimeFormatter == nil) {
        kMediumDateTimeFormatter = [[NSDateFormatter alloc] init];
        [kMediumDateTimeFormatter setDateStyle:NSDateFormatterMediumStyle];
        [kMediumDateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    
    return kMediumDateTimeFormatter;
}

- (NSString *) formatMediumDate
{
    return [[NSDate cachedMediumDateFormatter] stringFromDate:self];
}

- (NSString *) formatMediumDateTime
{
    return [[NSDate cachedMediumDateTimeFormatter] stringFromDate:self];
}

// yyyy-MM-dd HH:mm:ss
- (NSString *) formatYYYYMMdd_HHmmss
{
    int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* dc = [[NSCalendar currentCalendar] components:flags fromDate:self];
    return [NSString stringWithFormat:@"%04d-%02d-%02d %02d:%02d:%02d", dc.year, dc.month, dc.day, dc.hour, dc.minute, dc.second];
}

- (NSString *) formatUtcTimestamp
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:self];

    return dateString;
}

- (NSString *) formatUtcDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:self];
    
    return dateString;
}

- (NSString *) formatAsDeltaFromNow
{
    return [self formatAsDeltaFromNowWithTimeZoneAdjustment:YES];
}

- (NSString *) formatAsDeltaFromNowWithTimeZoneAdjustment:(BOOL)adjustTimeZone
{
	NSTimeInterval timeZoneDiff = 0;
    if (adjustTimeZone)
    {
        timeZoneDiff = [[NSTimeZone systemTimeZone] secondsFromGMT];
    }
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self] - timeZoneDiff;
    
    double days = (interval / (60.0 * 60.0 * 24.0));                             
    NSString *ageStr;
    BOOL inFuture = days < 0;
    
    // Set the ageStr based on the range it falls into
    if (days < 1.0)
    {
        double hours = days * 24.0;
        
        if (hours < 1.0) 
        {
            double minutes = hours * 60;
            
            if (minutes < 1.0) 
            {
                double seconds = minutes * 60;
                
                if (seconds >= 1.0 && seconds < 2.0) 
                {
                    ageStr = [NSString stringWithFormat:inFuture ? @"in %d second" : @"%d second ago", [[NSNumber numberWithDouble:seconds] intValue]];
                }
                else if (seconds <= 0)
                {
                    ageStr = @"Just now";
                }
                else
                {
                    ageStr = [NSString stringWithFormat:inFuture ? @"in %d seconds" : @"%d seconds ago", [[NSNumber numberWithDouble:seconds] intValue]];
                }                
            } 
            else if (minutes >= 1.0 && minutes < 2.0) 
            {
                ageStr = [NSString stringWithFormat:inFuture ? @"in %d minute" : @"%d minute ago", [[NSNumber numberWithDouble:minutes] intValue]];
            }
            else 
            {
                ageStr = [NSString stringWithFormat:inFuture ? @"in %d minutes" : @"%d minutes ago", [[NSNumber numberWithDouble:minutes] intValue]];
            }            
        } 
        else if (hours >= 1.0 && hours < 2.0) 
        {
            ageStr = [NSString stringWithFormat:inFuture ? @"in %d hour" : @"%d hour ago", [[NSNumber numberWithDouble:hours] intValue]];
        }
        else 
        {
            ageStr = [NSString stringWithFormat:inFuture ? @"in %d hours" : @"%d hours ago", [[NSNumber numberWithDouble:hours] intValue]];
        }        
    } 
    else if (days >= 1.0 && days < 2.0) 
    {
        ageStr = [NSString stringWithFormat:inFuture ? @"in %d day" : @"%d day ago", [[NSNumber numberWithDouble:days] intValue]];
    }
    else 
    {
        ageStr = (!inFuture) ?
        [NSString stringWithFormat:@"%d days ago", [[NSNumber numberWithDouble:days] intValue]]
        : [self formatMediumDateTime];
    }
    
    return ageStr;
}

+ (NSString *) dayOfMonthSuffix:(int)dayOfMonth
{
    switch (dayOfMonth)
    {
        case 1:
        case 21:
        case 31:
            return @"st";
        case 2:
        case 22:
            return @"nd";
        case 3:
        case 23:
            return @"rd";
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
        case 16:
        case 17:
        case 18:
        case 19:
        case 20:
        case 24:
        case 25:
        case 26:
        case 27:
        case 28:
        case 29:
        case 30:
            return @"th";
        default:
            return @"";
    }
}

static NSDateFormatter* kDayOfWeekFormatter = nil;
+ (NSDateFormatter*) cachedDayOfWeekFormatter
{
    if (kDayOfWeekFormatter == nil)
    {
        kDayOfWeekFormatter = [[NSDateFormatter alloc] init];
        [kDayOfWeekFormatter setDateFormat:@"EEEE"];
    }
    
    return kDayOfWeekFormatter;
}

- (NSString *) dayOfWeek
{
    return [[NSDate cachedDayOfWeekFormatter] stringFromDate:self];
}

static NSDateFormatter* kMonthOfYearFormatter = nil;
+ (NSDateFormatter*) cachedMonthOfYearFormatter
{
    if (kMonthOfYearFormatter == nil)
    {
        kMonthOfYearFormatter = [[NSDateFormatter alloc] init];
        [kMonthOfYearFormatter setDateFormat:@"LLLL"];
    }
    
    return kMonthOfYearFormatter;
}

- (NSString *) monthOfYear
{
    return [[NSDate cachedMonthOfYearFormatter] stringFromDate:self];
}

static NSDateFormatter* kDayOfMonthFormatter = nil;
+ (NSDateFormatter*) cachedDayOfMonthFormatter
{
    if (kDayOfMonthFormatter == nil)
    {
        kDayOfMonthFormatter = [[NSDateFormatter alloc] init];
        [kDayOfMonthFormatter setDateFormat:@"d"];
    }
    
    return kDayOfMonthFormatter;
}

- (NSString *) dayOfMonth
{
    NSString * str = [[NSDate cachedDayOfMonthFormatter] stringFromDate:self];
    int dayValue = [str intValue];
    return [str stringByAppendingString:[NSDate dayOfMonthSuffix:dayValue]];
}

- (int) numberOfYearsUntilNow{
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:self
                                       toDate:now
                                       options:0];
    NSInteger numberOfYears = [ageComponents year];
    
    return numberOfYears;
}

static NSDateFormatter* kTimeOfDayFormatter = nil;
+ (NSDateFormatter*) cachedTimeOfDayFormatter
{
    if (kTimeOfDayFormatter == nil)
    {
        kTimeOfDayFormatter = [[NSDateFormatter alloc] init];
        [kTimeOfDayFormatter setDateFormat:@"h:mm a"];
    }
    
    return kTimeOfDayFormatter;
}

- (NSString *) timeOfDay
{
    return [[NSDate cachedTimeOfDayFormatter] stringFromDate:self];
}

- (NSString *) verboseTimeOfDay
{
    return [NSString stringWithFormat:@"%@, %@ %@ %@", [self dayOfWeek], [self monthOfYear], [self dayOfMonth], [self timeOfDay]];
}

@end

#pragma mark - NSBundle+ETStringTampering
@implementation NSBundle (ETStringTampering)

+ (NSString *) versionLabel
{
    return [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey];
}

+ (NSString *) bundleIdentifier
{
    return [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleIdentifierKey];
}

@end

