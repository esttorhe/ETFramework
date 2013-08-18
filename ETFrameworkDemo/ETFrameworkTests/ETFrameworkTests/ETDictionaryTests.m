//
//  ETDictionaryTests.m
//  ETFrameworkTests
//
//  Created by Esteban Torres on 8/18/13.
//
//

#import "ETDictionaryTests.h"
#import "ETDictionary.h"
#import "ETObject.h"

static NSString * const DictNullKey = @"nullKey";
static NSString * const DictStringKey = @"stringKey";
static NSString * const DictDateKey = @"dateKey";
static NSString * const DictDictionaryKey = @"dictionaryKey";

@implementation ETDictionaryTests

- (void)testNSDictionary
{
    NSDictionary *dict = @{ DictNullKey : [NSNull null], DictStringKey : DictStringKey, DictDateKey : @"1985-10-15T21:00:00Z", DictDictionaryKey : @{ DictStringKey : DictStringKey } };
    id object = [dict nonNullObjectForKey:DictNullKey];
    STAssertFalse([object isKindOfClass:[NSNull class]], @"Unable to retrieve non null object.");
    STAssertTrue(object == nil, @"nonNullObjectForKey: returned a non-nil value.");
    object = [dict nonNullObjectForKey:DictStringKey];
    STAssertTrue([object isKindOfClass:[NSString class]], @"Unable to retrieve correct object.");
    STAssertFalse(object == nil, @"nonNullObjectForKey: returned a nil value instead of NSString.");
    object = [dict dateForKey:DictDateKey withFormatter:[NSDateFormatter ETDefaultJSONDateFormatter]];
    STAssertTrue([object isKindOfClass:[NSDate class]], @"Unable to retrieve date from dictionary.");
    STAssertFalse(object == nil, @"dateForKey: returned a nil object instead of NSDate.");
    object = [dict dictionaryForKey:DictDictionaryKey];
    STAssertTrue([object isKindOfClass:[NSDictionary class]], @"Unable to retrieve dictionary from dictionary.");
    STAssertFalse(object == nil, @"dictionaryForKey: returned a nil object instead of NSDictionary.");
}

- (void)testNSMutableDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{ DictNullKey : [NSNull null], DictDateKey : @"1985-10-15T21:00:00Z", DictDictionaryKey : @{ DictStringKey : DictStringKey } }];
    NSUInteger numberOfKeys = dict.allKeys.count;
    [dict setObjectIfNotNil:nil forKey:DictStringKey];
    STAssertEquals(numberOfKeys, dict.allKeys.count, @"setObjectIfNotNil: allowed to insert a nil object to NSMutableDictionary.");
    [dict setObjectIfNotNil:DictStringKey forKey:DictStringKey];
    STAssertFalse(numberOfKeys == dict.allKeys.count, @"setObjectIfNotNil: did not allow to insert a non-nil object to NSMutableDictionary.");
}

@end
