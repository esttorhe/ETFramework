//
//  ETArray.m
//  Esteban Torres - NSArray/NSMutableArray categories
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "ETArray.h"

@implementation NSArray (ETArray)

+ (NSArray*) sortDescriptor:(NSString *)column
{
    return [NSArray sortDescriptor:column ascending:YES];
}

+ (NSArray*) sortDescriptor:(NSString *)column ascending:(BOOL)ascending
{
    if (isNilOrNull(column)) {
#ifdef ETFRAMEWORK_RAISE_ASSERTS
        ETAssert(!columnIsEmpty, @"Column parameter cannot be nil.");
#else
        return nil;
#endif
    }
    
    NSSortDescriptor* sd = [[NSSortDescriptor alloc] initWithKey:column ascending:ascending];
    return [NSArray arrayWithObject:sd];    
}

@end


@implementation NSSet (ETSorting)

- (NSArray*) sortByField:(NSString *)field
{
    return [self sortByField:field ascending:YES];
}

- (NSArray*) sortByField:(NSString *)field ascending:(BOOL)ascending
{
    if (isNilOrNull(field)) {
#ifdef ETFRAMEWORK_RAISE_ASSERTS
        ETAssert(!fieldIsEmpty, @"Field parameter cannot be nil.");
#else
        return nil;
#endif
    }
    
    return [self sortedArrayUsingDescriptors:[NSArray sortDescriptor:field ascending:ascending]]; 
}

@end