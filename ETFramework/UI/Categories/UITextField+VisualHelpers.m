//
//  UITextField+VisualHelpers.m
//  Esteban Torres
//
//  Created by Esteban Torres on 6/25/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "UITextField+VisualHelpers.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char const * const ErrorMessageKey = "ErrorMessageKey";

@implementation UITextField (VisualHelpers)

@dynamic errorMessage;

- (id)errorMessage {
    return objc_getAssociatedObject(self, ErrorMessageKey);
}

- (void)setErrorMessage:(NSString *)errorMessage {
    objc_setAssociatedObject(self, ErrorMessageKey, errorMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) showErrorBorder
{
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 0.8f;
    self.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.7f].CGColor;
    self.clipsToBounds = NO;
}

- (void) hideErrorBorder
{
    self.layer.borderWidth = 0.0f;
}

- (void) showErrorMessage
{
    UILabel *error = [[UILabel alloc] initWithFrame:CGRectZero];
    error.alpha = 0.0f;
    error.font = [UIFont systemFontOfSize:10.0f];
    error.textColor = [UIColor redColor];
    error.text = self.errorMessage;
    CGSize size = [error.text sizeWithFont:error.font];
    CGRect frame = CGRectMake(0, -1 * (size.height/2.0f), size.width, size.height);
    error.frame = frame;
    error.backgroundColor = [UIColor clearColor];
    
    [self addSubview:error];
    
    __block typeof(error) blockError = error;
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        blockError.alpha = 1.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5f delay:0.8f options:UIViewAnimationOptionAllowUserInteraction animations:^{
                blockError.alpha = 0.0f;
            } completion:^(BOOL finished){
                if(finished) {[blockError removeFromSuperview]; }
            }];
        }
    }];
}

@end
