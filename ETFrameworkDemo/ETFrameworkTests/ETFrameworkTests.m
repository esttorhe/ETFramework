//
//  ETFrameworkTests.m
//  ETFrameworkTests
//
//  Created by Esteban Torres on 8/12/13.
//  Copyright (c) 2013 estebantorres. All rights reserved.
//

#import "ETFrameworkTests.h"
#import "ETDataFramework.h"
#import "ETCoreFramework.h"

@implementation ETFrameworkTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testSortDescriptors
{
    STAssertNotNil([NSArray sortDescriptor:@"ETField"], @"Cannot generated sort descriptor.");
    STAssertNil([NSArray sortDescriptor:nil], @"Sort descriptor creation should fail when passed nil.");
}

@end
