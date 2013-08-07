//
//  UIViewController+TextFieldDelegateHelpers.m
//  Esteban Torres
//
//  Created by Esteban Torres on 4/12/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "UIViewController+TextFieldDelegateHelpers.h"
#import "UIView+KeyboardHelpers.h"

@implementation UIViewController (TextFieldDelegateHelpers)

#pragma mark - UITextFieldDelegate implementation

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    textField.textAlignment = NSTextAlignmentCenter;
    
    [self.view slideUpIfNecessaryForTextField:textField];
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    [self.view slideDownIfNecessary];
}

- (void) resignTextFields{
    for (id view in [self.view subviews]) {
        [self.view checkTextField:view];
    }
}

- (void) cleanTextFields{
    for (id view in [self.view subviews]) {
        [self.view cleanTextField:view];
    }
}

@end
