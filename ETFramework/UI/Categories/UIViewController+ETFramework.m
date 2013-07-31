//
//  UIViewController+ETFramework.m
//  ETFramework
//
//  Created by Esteban Torres on 7/31/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "UIViewController+ETFramework.h"
#import "UIViewController+TextFieldDelegateHelpers.h"

@implementation UIViewController (ETFramework)

#pragma mark - Initialization

- (void) initializeViewController
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Gesture Recognizers

- (void) dismissKeyboard:(UITapGestureRecognizer *)tap
{
    [self setEditing:NO animated:YES];
    [self resignTextFields];
}

@end
