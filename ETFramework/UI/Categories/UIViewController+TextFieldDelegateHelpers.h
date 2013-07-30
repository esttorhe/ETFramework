//
//  UIViewController+TextFieldDelegateHelpers.h
//  Esteban Torres
//
//  Created by Esteban Torres on 4/12/13.
//  Copyright (c) 2013 Log(n). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TextFieldDelegateHelpers)<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *viewTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

- (void) resignTextFields;
- (void) cleanTextFields;

@end
