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
    return [self sortedArrayUsingDescriptors:[NSArray sortDescriptor:field ascending:ascending]]; 
}

@end