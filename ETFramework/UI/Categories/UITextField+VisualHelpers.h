//
//  UITextField+VisualHelpers.h
//  Esteban Torres
//
//  Created by Esteban Torres on 6/25/13.
//  Copyright (c) 2013 Log(n). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (VisualHelpers)

@property (nonatomic, retain) NSString *errorMessage;

- (void) showErrorBorder;
- (void) hideErrorBorder;
- (void) showErrorMessage;

@end
