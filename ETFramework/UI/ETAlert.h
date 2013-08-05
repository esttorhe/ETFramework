//
//  ETAlert.h
//  Esteban Torres - UIAlertView extensions
//
//  Created by Esteban Torres on 04/09/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 `UIAlertView (ETFramework)` is a helper category that adds some better handling functionality to `UIAlertView` objects.
 */
@interface UIAlertView (ETFramework)
/**------------------------------------------------------------------------------------------------------------------
 * @name Show UIAlertView objects
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Shows a `UIAlertView` object with the provided title, message and delegate.
 
 @param alertTitle The `NSString` object that will be used as the `UIAlertView` title.
 
 @param alertMessage The `NSString` object that will be displayed as the `UIAlertView` body message.
 
 @param delegate The `id<UIAlertViewDelegate>` object that will be set as the delegate of the shown `UIAlertView`.
 */
+ (void) showAlertWithTitle:(NSString *)alertTitle 
                    message:(NSString *)alertMessage 
                   delegate:(id <UIAlertViewDelegate>)delegate;

/**
 Shows a `UIAlertView` object with the provided title, message and completion `block`.
 
 @param alertTitle The `NSString` object that will be used as the `UIAlertView` title.
 
 @param alertMessage The `NSString` object that will be displayed as the `UIAlertView` body message.
 
 @param completionHandler The code `block` that will be executed when any button is tapped on the shown `UIAlertView`.
 */
+ (void) showAlertWithTitle:(NSString *)alertTitle 
                    message:(NSString *)alertMessage 
                  completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

/**------------------------------------------------------------------------------------------------------------------
 * @name Show UIAlertView objects with predefined title (AppName)
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Shows a `UIAlertView` object with the AppName as the `UIAlertView` title and the provided message and delegate.
 
 @param alertMessage The `NSString` object that will be displayed as the `UIAlertView` body message.
 
 @param delegate The `id<UIAlertViewDelegate>` object that will be set as the delegate of the shown `UIAlertView`.
 */
+ (void) showAlertWithAppTitleAndMessage:(NSString *)alertMessage
                                delegate:(id <UIAlertViewDelegate>)delegate;

/**
 Shows a `UIAlertView` object with the AppName as the `UIAlertView` title and the provided message and executes the provided code `block` whenever a button on the shown `UIAlertView` is tapped.
 
 @param alertMessage The `NSString` object that will be displayed as the `UIAlertView` body message.
 
 @param completionHandler The code `block` that will be executed when any button is tapped on the shown `UIAlertView`.
 */
+ (void) showAlertWithAppTitleAndMessage:(NSString *)alertMessage
                       completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;
/**------------------------------------------------------------------------------------------------------------------
 * @name Show NSError as UIAlertView with predefined title (AppName)
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Shows a `UIAlertView` with the AppName as the title and the `localizedDescription` property of the provided `NSError` as the body.
 
 @param error The `NSError` that will be displayed in the `UIAlertView`.
 */
+ (void) showAlertWithAppTitleAndError:(NSError *)error;

/**
 Shows a `UIAlertView` with the AppName as the title and the `localizedDescription` property of the provided `NSError` as the body.
 
 @param error The `NSError` that will be displayed in the `UIAlertView`.
 
 @param completionHandler The code `block` that will be executed when any button is tapped on the shown `UIAlertView`.
 */
+ (void) showAlertWithAppTitleAndError:(NSError *)error
                     completionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

/**------------------------------------------------------------------------------------------------------------------
 * @name
 * ------------------------------------------------------------------------------------------------------------------
 */
/**------------------------------------------------------------------------------------------------------------------
 * @name Initialization methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Creates a `UIAlertView` object with the provided details.
 
 @param title The `NSString` object that will be used as the `UIAlertView` title.
 
 @param message The `NSString` object that will be used as the `UIAlertView` message body.
 
 @param completionHandler The code `block` that will be executed when any button is tapped on the shown `UIAlertView`.
 
 @param defaultButtonTitle The `NSString` that will be used as the default button title. 
 
 @param ... More `NSString` objects (separated by `,`) that can be used as additional buttons on the `UIAlertView` (Up to 16 objects/buttons).
 
 @return A `UIAlertView` initialized with the provided parameterds. The `UIAlertView` is just initialized but not shown.
 */
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  completionHandler:(void (^)(NSInteger buttonIndex))completionHandler
       buttonTitles:(NSString *)defaultButtonTitle, ...;

@end
