//
//  ETImageCache.h
//  Beergram
//
//  Created by Jonathan Hays on 6/6/12.
//  Copyright (c) 2012 Beergram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETImageCache : NSObject 
	+ (UIImage*) imageForURL:(NSURL*)url;
    + (UIImage*) imageForURL:(NSURL *)url scale:(CGFloat)scale;
	+ (void) cacheImage:(UIImage*)image forURL:(NSURL*)url;
    + (void) clearImageCacheForURL:(NSURL*)url;
    + (void) getImages:(NSArray*)sourceUrls  completionHandler:(void (^)(NSDictionary* results))completionHandler;
@end
