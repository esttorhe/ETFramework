//
//  UIViewController+TextFieldDelegateHelpers.m
//  Esteban Torres
//
//  Created by Esteban Torres on 4/12/13.
//  Copyright (c) 2013 Log(n). All rights reserved.
//

#import "UIViewController+TextFieldDelegateHelpers.h"
#import "UIView+KeyboardHelpers.h"
#import <objc/runtime.h>

static char const * const TitleLabelKey = "TitleLabelKey";
static char const * const LeftButtonKey = "LeftButtonKey";
static char const * const RightButtonKey = "RightButtonKey";

@implementation UIViewController (TextFieldDelegateHelpers)

#pragma Properties

- (id) viewTitleLabel {
    return objc_getAssociatedObject(self, TitleLabelKey);
}

- (void)setViewTitleLabel:(UILabel *)viewTitleLabel{
    objc_setAssociatedObject(self, TitleLabelKey, viewTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id) leftButton {
    return objc_getAssociatedObject(self, LeftButtonKey);
}

- (void) setLeftButton:(UIButton *)leftButton
{
    objc_setAssociatedObject(self, LeftButtonKey, leftButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id) rightButton {
    return objc_getAssociatedObject(self, RightButtonKey);
}

- (void) setRightButton:(UIButton *)rightButton
{
    objc_setAssociatedObject(self, RightButtonKey, rightButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

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

- (void) dealloc
{
    self.rightButton = nil;
    self.leftButton = nil;
    self.viewTitleLabel = nil;
}

@end
