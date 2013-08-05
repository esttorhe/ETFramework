//
//  UITextField+EmailValidation.h
//  Esteban Torres
//
//  Created by Esteban Torres on 4/18/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 `UITextField (EmailValidation)` is a helper category that provides email validation methods.
 */
@interface UITextField (EmailValidation)
/**------------------------------------------------------------------------------------------------------------------
 * @name Email validation methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns wether or not the text on the `UITextField` instance matches an email pattern.
 
 @return Returns `YES` if the text property of the `UITextField` instance matches a valid email pattern, `NO` otherwise.
 */
- (BOOL) isValidEmailAddress;

@end
