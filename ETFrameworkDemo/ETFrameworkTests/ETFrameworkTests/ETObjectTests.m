//
//  ETObjectTests.m
//  ETFrameworkTests
//
//  Created by Esteban Torres on 8/19/13.
//
//

#import "ETObjectTests.h"
#import "ETCoreFramework.h"
#import <objc/runtime.h>

static char *const UserInfoKey = "UserInfoKey";

@interface TestClass : NSObject

@property (nonatomic, strong) NSString *testProperty;
@property (nonatomic, strong) NSDate *testDate;
@property (nonatomic, strong) NSNumber *testNumber;

@end

@implementation TestClass{
    NSString *_testProperty;
}

@synthesize testProperty = _testProperty;

@end

@implementation ETObjectTests

- (void)testNSObject
{
    STAssertNotNil(is_null(nil, @"ETFramework"), @"is_null returned a nil object.");
    STAssertNotNil(is_null(@"ETFramework", nil), @"is_null returned a nil object.");
    
    NSObject *obj = [[NSObject alloc] init];
    [obj attachUserInfo:@"ETFramework"];
    STAssertEqualObjects([obj userInfo], @"ETFramework", @"attachUserInfo: & userInfo not working properly.");
    
    [obj attachUserInfo:@"ETFramework" forKey:UserInfoKey];
    STAssertEqualObjects([obj userInfoForKey:UserInfoKey], @"ETFramework", @"attachUserInfo:forKey: & userInfoForKey: not working properly.");
    STAssertNil([obj userInfoForKey:nil], @"userInfoForKey: for nil key should return nil.");
    
    NSDictionary *initDict = @{ @"testDate" : @"1985-10-15" };
    STAssertNotNil([[TestClass alloc] initFromDictionary:initDict], @"Unable to initialize object from dictionary.");
    initDict = @{ @"testProperty" : [NSNull null] };
    TestClass *testObj = [[TestClass alloc] initFromDictionary:initDict];
    STAssertNotNil(testObj, @"Unable to initialize object from dictionary.");
    STAssertNil([testObj testProperty], @"initFromDictionary: not setting nil values when NSNull present on the dictionary.");
    
    testObj = [testObj updateDataWithDictionary:@{ @"_testProperty" : @"ETFramework", @"testNumber" : @125 }];
    STAssertEqualObjects([testObj testProperty], @"ETFramework", @"updateDateWithDictionary: not working correctly.");
    
    testObj = [testObj updateDataWithDictionary:@{ @"testNumber" : @"125", @"testDate" : @"1985-10-15T06:00:00Z" } dateFormatter:[NSDateFormatter ETDefaultJSONDateFormatter]];
    STAssertNotNil([testObj testDate], @"%@. Something went wrong.", [testObj testDate]);
    
    STAssertNotNil([testObj.testDate convertToLocalTime], @"Unable to convert date to local time. %@", [testObj.testDate convertToLocalTime]);
}

- (void)testNSTimer
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __weak NSDate *date = [NSDate date];
    [NSTimer delay:0.0002f andExecuteBlock:^{
        NSTimeInterval newInterval = [[NSDate date] timeIntervalSinceDate:date];
        STAssertTrue(fabsf(newInterval - 0.00020) <= 0.01, @"Timer not firing with the correct delay %.2f", fabsf(newInterval - 0.00020));
        // Signal that block has completed
        dispatch_semaphore_signal(semaphore);
    }];
    
    // Run loop
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
//    dispatch_release(semaphore);
}

@end
