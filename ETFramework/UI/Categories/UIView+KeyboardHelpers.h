//
//  UIView+KeyboardHelpers.h
//  Esteban Torres
//
//  Created by Esteban Torres on 4/10/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 `UIView (KeyboardHelpers)` is a helper category that provides easy to use methods to manipulate views when the keyboard show/hide to avoid `UITextField` from getting covered by the keyboard.
 */
@interface UIView (KeyboardHelpers)
/**------------------------------------------------------------------------------------------------------------------
 * @name Category properties
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 The distance that the `UIView` will animate when the keyboard is showing or hiding.
 
 The default value should work. Don't change it unless **REALLY** necessary.
 */
@property (nonatomic, retain) NSNumber *animatedDistance;

/**------------------------------------------------------------------------------------------------------------------
 * @name Keyboard animation methods
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Detects if the keyboard is going to cover the provided `UITextField` and slides up the `UIView` to avoid the it getting covered by the keyboard.
 
 @param textField The `UITextField` object that needs to be checked if its going to be covered by the keyboard or not.
 
 @see -animatedDistance;
 */
- (void) slideUpIfNecessaryForTextField:(UITextField *)textField;

/**
 Detects if the `UIView` was moved up due to some keyboard covering it and slides it back to "normal".
 */
- (void) slideDownIfNecessary;

/**
 Iterates through the provided `UIView` container and calls `resignFirstResponder` if its a `UITextField` if not drills down on that object looking for more `UITextField`.
 
 This method calls down `[UIView checkTextField:]`
 
 @param container The `UIView` object that will be used as the "top" container to start drilling down looking for `UITextField` objects.
 
 @see -checkTextField:;
 */
- (void) resignTextFields:(UIView *)container;

/**
 Checks if the provided object is a `UITextField`. If positive calls `resignFirstResponder` if the object is `UIView` calls `resignTextFields:`
 
 @param object The object that will be evaluated as a `UITextField` or `UIView`.
 
 @see -resignTextFields:;
 */
- (void) checkTextField:(id)object;

/**
 Checks if the provided object is a `UITextField`. If positive sets the `text` property to `@""`; if the object is `UIView` calls `resignTextFields:`
 
 @param object The object that will be evaluated as a `UITextField` or `UIView`.
 
 @see -resignTextFields:;
 */
- (void) cleanTextField:(id)object;
@end
