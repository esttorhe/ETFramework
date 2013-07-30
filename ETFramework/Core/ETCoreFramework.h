//
//  ETFramework.h
//  Esteban Torres - Master Include File
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#ifndef __ETCoreFramework_h__
#define __ETCoreFramework_h__

#import "ETDebugLog.h"
#import "ETBitTampering.h"
#import "ETString.h"
#import "ETObject.h"
#import "ETArray.h"
#import "ETDictionary.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif
