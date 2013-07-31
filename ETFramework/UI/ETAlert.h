//
//  ETAlert.h
//  Esteban Torres - UIAlertView extensions
//
//  Created by Esteban Torres on 04/09/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (ETFramework)

+ (void) showAlertWithTitle:(NSString *)alertTitle 
                    message:(NSString *)alertMessage 
                   delegate:(id <UIAlertViewDelegate>)delegate;

+ (void) showAlertWithTitle:(NSString *)alertTitle 
                    message:(NSString *)alertMessage 
                  completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

+ (void) showAlertWithAppTitleAndMessage:(NSString *)alertMessage
                                delegate:(id <UIAlertViewDelegate>)delegate;
+ (void) showAlertWithAppTitleAndMessage:(NSString *)alertMessage
                       completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

+ (void) showAlertWithAppTitleAndError:(NSError *)error;
+ (void) showAlertWithAppTitleAndError:(NSError *)error
                     completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  completionHandler:(void (^)(NSInteger buttonIndex))completionHandler
       buttonTitles:(NSString *)defaultButtonTitle, ...;

+ (id)okCancelAlert:(NSString *)title
            message:(NSString *)message
  completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;
+ (id)oneButtonAlert:(NSString *)title
             message:(NSString *)message
              button:(NSString*)button
   completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;
+ (id)twoButtonAlert:(NSString *)title
             message:(NSString *)message
           buttonOne:(NSString*)buttonOne
           buttonTwo:(NSString*)buttonTwo
   completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

@end
