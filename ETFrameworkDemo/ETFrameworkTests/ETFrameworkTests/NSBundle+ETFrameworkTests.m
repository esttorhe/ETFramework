//
//  NSBundle+ETFrameworkTests.m
//  ETFrameworkTests
//
//  Created by Esteban Torres on 8/19/13.
//
//

#import "NSBundle+ETFrameworkTests.h"
#import <OCMock/OCMock.h>

static NSBundle *theBundle = nil;

@implementation NSBundle (ETFrameworkTests)

// Since the mainBundle of a Unit Test is something obscurely "hiddend" we override it
// so that it returns the bundle of our tests target in order to successfully test our NSBundle methods.
+ (id)mainBundle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theBundle = [NSBundle bundleWithIdentifier:@"es.estebantorr.ETFrameworkTests"];
    });
    return theBundle;
}

@end
