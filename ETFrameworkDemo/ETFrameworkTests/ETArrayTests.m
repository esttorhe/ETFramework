//
//  ETArrayTests.m
//  ETFrameworkTests
//
//  Created by Esteban Torres on 8/12/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import "ETArrayTests.h"
#import "ETCoreFramework.h"

@implementation ETFrameworkTests

- (void)testNSArraySortDescriptors
{
    STAssertNotNil([NSArray sortDescriptor:@"ETField"], @"Cannot generated sort descriptor.");
    STAssertNil([NSArray sortDescriptor:nil], @"Sort descriptor creation should fail when passed nil.");
}

- (void)testNSSetFilteredArray
{
    NSSet *set = [NSSet setWithArray:@[@{@"ETField" : @"field1", @"ETValue":@"value1"}, @{@"ETField" : @"field2", @"ETValue":@"value2"}, @{@"ETField" : @"field3", @"ETValue":@"value3"}]];
    STAssertNotNil([set sortByField:@"ETField"], @"Cannot generate sorted NSSet.");
    STAssertNil([set sortByField:nil], @"Shouldn't sort set with nil field.");
}

@end
