//
//  ETArray.h
//  Esteban Torres - NSArray/NSMutableArray categories
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ETArray)

// Sort Descriptors
+ (NSArray*) sortDescriptor:(NSString*)column; // Ascending=YES
+ (NSArray*) sortDescriptor:(NSString*)column Ascending:(BOOL)ascending;


@end

@interface NSSet (ETSorting)

- (NSArray*) sortByField:(NSString*)field; // Ascending=YES
- (NSArray*) sortByField:(NSString*)field ascending:(BOOL)ascending;

@end