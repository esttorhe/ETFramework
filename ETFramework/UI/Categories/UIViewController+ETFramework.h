//
//  UIViewController+ETFramework.h
//  ETFramework
//
//  Created by Esteban Torres on 7/31/13.
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 `UIViewController (ETFramework)` is a helper category that adds some helper methods to `UIViewController` to handle and easily facilitate the use of this framework.
 */
@interface UIViewController (ETFramework)

/**--------------------------------------------
 * @name Initialisation methods
 *---------------------------------------------
 */
/**
 Adds a predefined `UITapGestureRecognizer` with `-numberOfTouchesRequired:`1 and `-numberOfTapsRequired:`1 that will internally call `-resignTextFields` and will dismiss the keyboard.
 */
- (void) initializeViewController;

@end
