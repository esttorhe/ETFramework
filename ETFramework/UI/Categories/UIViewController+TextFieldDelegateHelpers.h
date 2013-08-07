//
//  UIViewController+TextFieldDelegateHelpers.h
//  Esteban Torres
//
//  Created by Esteban Torres on 4/12/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 `UIViewController (TextFieldDelegateHelpers)` is a helper category that "automatically" handles `UITextFieldDelegate` calls.
 */
@interface UIViewController (TextFieldDelegateHelpers)<UITextFieldDelegate>
/**------------------------------------------------------------------------------------------------------------------
 * @name UITextField handling methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Iterates through the list of `UIView` subviews and calling `checkTextField:`.
 
 This methods calls `resignFirstResponder` to each `UITextField`.
 
 @see -[UIView checkTextField:]
 */
- (void) resignTextFields;

/**
 Iterates through the list of `UIView` subviews from the main `view` and calls `cleanTextFields` to each of them.
 
 @see -[UIView cleanTextField:]
 */
- (void) cleanTextFields;

@end
