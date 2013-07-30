//
//  ETAlert.m
//  Esteban Torres - UIAlertView extensions
//
//  Created by Esteban Torres on 09/04/13.
//  Copyright (c) 2013 Log(n). All rights reserved.
//

#import "ETAlert.h"
#import "ETCoreFramework.h"

@interface UIAlertViewDelegateQueue : NSObject

@end

static UIAlertViewDelegateQueue* theUIAlertViewDelegateQueue = nil;

@interface UIAlertViewDelegateQueue ()

@property (nonatomic, retain) NSMutableArray* queue;

@end

@implementation UIAlertViewDelegateQueue

@synthesize queue = _queue;

- (id) init
{
    self = [super init];
    if (self)
    {
        self.queue = [NSMutableArray array];
    }
    
    return self;
}

- (void) dealloc
{
    self.queue = nil;
}

+ (UIAlertViewDelegateQueue*) sharedQueue
{
    if (theUIAlertViewDelegateQueue == nil)
    {
        theUIAlertViewDelegateQueue = [[UIAlertViewDelegateQueue alloc] init];
    }
    
    return theUIAlertViewDelegateQueue;
}

- (void) add:(NSObject<UIAlertViewDelegate>*)client
{
    @synchronized(self) 
    {
        [self.queue addObject:client];
    }
}

- (void) remove:(NSObject<UIAlertViewDelegate>*)client
{
    @synchronized(self) 
    {
        [self.queue removeObject:client];
    }
}

@end

@interface UIAlertViewBlockDelegate : NSObject<UIAlertViewDelegate>

- (id) initWithBlock:(void (^)(NSInteger buttonIndex))completionHandler;

@end

@interface UIAlertViewBlockDelegate ()

@property (nonatomic, copy) void (^blocksCompletionHandler)(NSInteger buttonIndex);

@end

@implementation UIAlertViewBlockDelegate

@synthesize blocksCompletionHandler;

- (id) initWithBlock:(void (^)(NSInteger buttonIndex))completionHandler
{
    self = [super init];
    
    if (self)
    {
        if (completionHandler)
        {
            self.blocksCompletionHandler = completionHandler;
        }
    }
    
    [[UIAlertViewDelegateQueue sharedQueue] add:self];
    return self;
}

- (void) dealloc
{
    if (self.blocksCompletionHandler)
    {
        self.blocksCompletionHandler = NULL;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.blocksCompletionHandler)
    {
        self.blocksCompletionHandler(buttonIndex);
    }
    
    [[UIAlertViewDelegateQueue sharedQueue] remove:self];
}

@end


@implementation UIAlertView (ETFramework)

+ (void) showAlertWithTitle:(NSString *)alertTitle 
                    message:(NSString *)alertMessage 
                   delegate:(id <UIAlertViewDelegate>)delegate
{

    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:alertMessage
                                                   delegate:delegate 
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    //    alert.title = alertTitle;
    //    alert.message = alertMessage;
    //    alert.delegate = delegate;
    
    [alert show];  
}

+ (void) showAlertWithTitle:(NSString *)alertTitle 
                    message:(NSString *)alertMessage 
          completionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIAlertViewBlockDelegate* delegate = [[UIAlertViewBlockDelegate alloc] initWithBlock:completionHandler];
    [UIAlertView showAlertWithTitle:alertTitle message:alertMessage delegate:delegate];
}

+ (void) showAlertWithAppTitleAndMessage:(NSString *)alertMessage
                                delegate:(id<UIAlertViewDelegate>)delegate
{
    NSString *appTitle = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
    
    [self showAlertWithTitle:appTitle
                     message:alertMessage
                    delegate:delegate];
}

+ (void) showAlertWithAppTitleAndMessage:(NSString *)alertMessage
                       completionHandler:(void (^)(NSInteger))completionHandler
{
    NSString *appTitle = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
    
    [self showAlertWithTitle:appTitle
                     message:alertMessage
           completionHandler:completionHandler];
}

+ (void) showAlertWithAppTitleAndError:(NSError *)error
{
    [self showAlertWithAppTitleAndError:error completionHandler:NULL];
}

+ (void) showAlertWithAppTitleAndError:(NSError *)error
                     completionHandler:(void (^)(NSInteger))completionHandler
{
    NSString *message = [error localizedDescription];
    [self showAlertWithAppTitleAndMessage:message completionHandler:completionHandler];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message completionHandler:(void (^)(NSInteger buttonIndex))completionHandler buttonTitles:(NSString *)defaultButtonTitle, ...
{
    UIAlertViewBlockDelegate* delegate = [[UIAlertViewBlockDelegate alloc] initWithBlock:completionHandler];
    
	NSMutableArray* argumentArray = [[NSMutableArray alloc] init];
	va_list argList;
	va_start(argList, defaultButtonTitle);
	NSString* otherButtonTitle = va_arg(argList, NSString*);
	if (otherButtonTitle)
	{
		NSString* buttonMessage = va_arg(argList, NSString*);
		while (buttonMessage)
		{
			[argumentArray addObject:[NSString stringWithString:buttonMessage]];
			buttonMessage = va_arg(argList, NSString*);
		}
	}
	va_end(argList);
    
	self = [self initWithTitle:title message:message delegate:delegate cancelButtonTitle:defaultButtonTitle otherButtonTitles:(NSString*)otherButtonTitle,nil];
	for (int i = 0; i < [argumentArray count]; i++)
	{
		[self addButtonWithTitle:[argumentArray objectAtIndex:i]];
	}
    
	return self;
}

+ (id)okCancelAlert:(NSString *)title message:(NSString *)message completionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
	return [[UIAlertView alloc] initWithTitle:title message:message completionHandler:completionHandler buttonTitles:@"Cancel", @"Ok", nil];
}

+ (id)oneButtonAlert:(NSString *)title message:(NSString *)message button:(NSString*)button completionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
	return [[UIAlertView alloc] initWithTitle:title message:message completionHandler:completionHandler buttonTitles:button, nil];
}

+ (id)twoButtonAlert:(NSString *)title message:(NSString *)message buttonOne:(NSString*)buttonOne buttonTwo:(NSString*)buttonTwo completionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
	return [[UIAlertView alloc] initWithTitle:title message:message completionHandler:completionHandler buttonTitles:buttonOne, buttonTwo, nil];
}

@end
