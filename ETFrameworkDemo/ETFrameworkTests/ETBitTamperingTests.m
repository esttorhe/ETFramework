//
//  ETBitTamperingTests.m
//  ETFrameworkDemo
//
//  Created by Esteban Torres on 8/13/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import "ETBitTamperingTests.h"
#import "ETCoreFramework.h"

@implementation ETBitTamperingTests

- (void)testNSData
{
    NSData *data = [@"1234567890" dataUsingEncoding:NSUTF8StringEncoding];
    
    // UInt# tests
    UInt8 correct8Value = '3';
    STAssertEquals([data uint8AtIndex:2], correct8Value, @"Unable to find uintAt8");
    STAssertFalse([data uint8AtIndex:1] == correct8Value, @"uint8AtIndex:1 shouldn't be 3");
    
    UInt16 correct16Value = 13363;
    STAssertEquals([data uint16AtIndex:2], correct16Value, @"Unable to find uintAt16");
    STAssertFalse([data uint16AtIndex:1] == correct16Value, @"uint16AtIndex:1 shouldn't be 3");
    
    UInt32 correct32Value = 909456435;
    STAssertEquals([data uint32AtIndex:2], correct32Value, @"Unable to find uintAt32");
    STAssertFalse([data uint32AtIndex:1] == correct32Value, @"uint32AtIndex:1 shouldn't be 3");
    
    UInt64 correct64Value = 3474870397276861491;
    STAssertEquals([data uint64AtIndex:2], correct64Value, @"Unable to find uintAt64");
    STAssertFalse([data uint64AtIndex:1] == correct64Value, @"uint64AtIndex:1 shouldn't be 3");
    
    // SInt# tests
    SInt8 correctS8Value = '3';
    STAssertEquals([data sint8AtIndex:2], correctS8Value, @"Unable to find sintAt8");
    STAssertFalse([data sint8AtIndex:1] == correctS8Value, @"sint8AtIndex:1 shouldn't be 3");
    
    SInt16 correctS16Value = 13363;
    STAssertEquals([data sint16AtIndex:2], correctS16Value, @"Unable to find sintAt16");
    STAssertFalse([data sint16AtIndex:1] == correctS16Value, @"sint16AtIndex:1 shouldn't be 3");
    
    SInt32 correctS32Value = 909456435;
    STAssertEquals([data sint32AtIndex:2], correctS32Value, @"Unable to find sintAt32");
    STAssertFalse([data sint32AtIndex:1] == correctS32Value, @"sint32AtIndex:1 shouldn't be 3");
    
    SInt64 correctS64Value = 3474870397276861491;
    STAssertEquals([data sint64AtIndex:2], correctS64Value, @"Unable to find sintAt64");
    STAssertFalse([data sint64AtIndex:1] == correctS64Value, @"sint64AtIndex:1 shouldn't be 3");
    
    // float tests
    float correctFloatValue = 0.000003;
    STAssertTrue(([data floatAtIndex:2] - correctFloatValue) < 0, @"Unable to find correct floatAtIndex: %10f", [data floatAtIndex:2]);
    STAssertFalse(([data floatAtIndex:5] - correctFloatValue) < 0, @"floatAtIndex:5 shouldn't be equal to %6f", correctFloatValue);
    
    // double tests
    double correctDoubleValue = 0.000001;
    STAssertTrue(([data doubleAtIndex:1] - correctDoubleValue) < 0, @"Unable to find correct doubleAtIndex: %10f", [data doubleAtIndex:1]);
    
    // string tests
    NSMutableData *mData = [NSMutableData dataWithData:data];
    [mData appendString:@"ETFramework" withEncoding:NSUTF8StringEncoding];
    data = mData;
    NSString *string = [data stringAtIndex:[data length]-15 withEncoding:NSUTF8StringEncoding];
    STAssertNotNil(string, @"Unable to retrieve string from data.");
}

- (void)testNSMutableData
{
    NSMutableData *data = [NSMutableData dataWithData:[@"1234567890" dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger lenght = [data length];
    
    // UInt# append tests
    [data appendUInt8:0];
    STAssertEquals(abs(lenght - [data length]), 1, @"Lenght of NSMutableData should change by 1 after appending sint8.");
    
    lenght = [data length];
    [data appendUInt16:0];
    STAssertEquals(abs(lenght - [data length]), 2, @"Lenght of NSMutableData should change by 2 after appending sint16.");
    
    lenght = [data length];
    [data appendUInt32:0];
    STAssertEquals(abs(lenght - [data length]), 4, @"Lenght of NSMutableData should change by 4 after appending sint32.");
    
    lenght = [data length];
    [data appendUInt64:0];
    STAssertEquals(abs(lenght - [data length]), 8, @"Lenght of NSMutableData should change by 8 after appending sint64.");
    
    // SInt# append tests
    [data appendSInt8:[data sint8AtIndex:0]];
    STAssertEquals(abs(lenght - [data length]), 9, @"Lenght of NSMutableData should change by 9 after appending sint8.");
    
    lenght = [data length];
    [data appendSInt16:[data sint16AtIndex:0]];
    STAssertEquals(abs(lenght - [data length]), 2, @"Lenght of NSMutableData should change by 2 after appending sint16.");
    
    lenght = [data length];
    [data appendSInt32:[data sint32AtIndex:0]];
    STAssertEquals(abs(lenght - [data length]), 4, @"Lenght of NSMutableData should change by 4 after appending sint32.");
    
    lenght = [data length];
    [data appendSInt64:[data sint64AtIndex:0]];
    STAssertEquals(abs(lenght - [data length]), 8, @"Lenght of NSMutableData should change by 8 after appending sint64.");
    
    // float append tests
    lenght = [data length];
    [data appendFloat:[data floatAtIndex:0]];
    STAssertEquals(abs(lenght - [data length]), 4, @"Lenght of NSMutableData should change by 4 after appending float.");
    
    // double append tests
    lenght = [data length];
    [data appendDouble:[data doubleAtIndex:0]];
    STAssertEquals(abs(lenght - [data length]), 8, @"Lenght of NSMutableData should change by 8 after appending double.");
    
    // string append tests
    lenght = [data length];
    [data appendString:@"ETFramework" withEncoding:NSUTF8StringEncoding];
    STAssertEquals(abs(lenght - [data length]), 15, @"Lenght of NSMutableData should change by 15 after appending string.");
}

@end
