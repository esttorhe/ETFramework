//
//  UITextField+EmailValidation.m
//  Esteban Torres
//
//  Created by Esteban Torres on 4/18/13.
//  Copyright (c) 2013 Log(n). All rights reserved.
//

#import "UITextField+EmailValidation.h"

#ifndef EMAIL_REGEX
#define EMAIL_REGEX                   @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#endif

@implementation UITextField (EmailValidation)

- (BOOL) isValidEmailAddress
{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EMAIL_REGEX];
    
    return [emailTest evaluateWithObject:self.text];
}

@end
