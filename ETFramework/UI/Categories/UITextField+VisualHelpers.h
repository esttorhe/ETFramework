//
//  UITextField+VisualHelpers.h
//  Esteban Torres
//
//  Created by Esteban Torres on 6/25/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 `UITextField (VisualHelpers)` is a helper category that provided methods to handle showing and hiding error messaging.
 */
@interface UITextField (VisualHelpers)

/**------------------------------------------------------------------------------------------------------------------
 * @name Error messaging helper properties.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 The `NSString` object that will be displayed as an error message on the `UITextField` instance.
 */
@property (nonatomic, retain) NSString *errorMessage;

/**------------------------------------------------------------------------------------------------------------------
 * @name Error handling methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Shows a `[[UIColor redColor] colorWithAlphaComponent:0.7f]` border around the `UITextField` instance.
 */
- (void) showErrorBorder;

/**
 Hides the error border (if any) of the `UITextField` instance.
 
 @see -showErrorBorder;
 */
- (void) hideErrorBorder;

/**
 Shows the errorMessage associated to the `UITextField` instance on the top half part of it.
 
 @see -errorMessage;
 */
- (void) showErrorMessage;

@end
