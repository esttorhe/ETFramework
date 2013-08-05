//
//  ETImageCache.m
//  Beergram
//
//  Created by Jonathan Hays on 6/6/12.
//  Copyright (c) 2012 Beergram. All rights reserved.
//

#import "ETImageCache.h"
#import "ETDebugLog.h"

@implementation ETImageCache

+ (NSString *) cachePathForURL:(NSURL*)url
{
	NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
	NSString * path = [url absoluteString];
	path = [[path componentsSeparatedByCharactersInSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]] componentsJoinedByString:@"-"];
	path = [cachePath stringByAppendingPathComponent:path];
	path = [path stringByAppendingString:@".png"];
	ETDebugLog(@"%@", path);
	return path;
}

+ (UIImage*) imageForURL:(NSURL*)url
{
    if (url != nil)
    {
        UIImage* image = [ETImageCache bundleImageForUrl:url];
        if (image == nil)
        {
            NSString * path = [ETImageCache cachePathForURL:url];
            image = [UIImage imageWithContentsOfFile:path];
        }
        
        return image;
    }
    else
    {
        return nil;
    }
}
	
+ (void) cacheImage:(UIImage*)image forURL:(NSURL*)url
{
	NSData * data = UIImagePNGRepresentation(image);
	NSString * path = [ETImageCache cachePathForURL:url];
	
	[data writeToFile:path atomically:YES];
}

+ (UIImage*) imageForURL:(NSURL *)url scale:(CGFloat)scale
{
    if (url != nil)
    {
        UIImage* image = [ETImageCache bundleImageForUrl:url];
        if (image == nil)
        {
            UIImage* raw = [ETImageCache imageForURL:url];
            image  = [UIImage imageWithCGImage:[raw CGImage] scale:scale orientation:UIImageOrientationUp];
        }
        
        return image;
    }
    else
    {
        return nil;
    }
}

+ (UIImage*) bundleImageForUrl:(NSURL*)url
{
    if (url != nil && url.scheme == nil && url.scheme.length <= 0)
    {
        //NSLog(@"url.resourceSpecifier: %@, url.absolutePath: %@", url.resourceSpecifier, url.absoluteString);
        return [UIImage imageNamed:url.absoluteString];
    }
    
    return nil;
}

+ (void) clearImageCacheForURL:(NSURL*)url
{
    NSString * path = [ETImageCache cachePathForURL:url];
    NSFileManager* fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path])
    {
        NSError* err = nil;
        if (![fm removeItemAtPath:path error:&err])
        {
            ETDebugLog(@"Failed to delete image at cache path: %@", path);
        }
    }
}

+ (void) getImages:(NSArray*)sourceUrls completionHandler:(void (^)(NSDictionary* results))completionHandler
{
    __block NSMutableDictionary* results = [[NSMutableDictionary alloc] init];
    __block NSMutableArray* urlsRemaining = [[NSMutableArray alloc] initWithArray:sourceUrls];
    
    void (^doneCallback)(NSURL* sourceUrl, UIImage* image) = ^(NSURL* sourceUrl, UIImage* image)
    {
        @synchronized(results)
        {
            if (image != nil)
            {
                [ETImageCache cacheImage:image forURL:sourceUrl];
                [results setObject:image forKey:sourceUrl];
            }
            
            [urlsRemaining removeObject:sourceUrl];
            
            if (urlsRemaining.count == 0)
            {
                if (completionHandler)
                {
                    completionHandler(results);
                }
            }
        }
    };
    
    for (NSURL* sourceUrl in sourceUrls)
    {
        UIImage* image = [ETImageCache imageForURL:sourceUrl];
        if (image)
        {
            doneCallback(sourceUrl, image);
        }
        else
        {
            dispatch_queue_t downloadQueue = dispatch_queue_create("es.estebantorr.downloadImageQueue", NULL);
            dispatch_async(downloadQueue, ^
            {
                NSData * imageData = [NSData dataWithContentsOfURL:sourceUrl];
                UIImage* image = [UIImage imageWithData:imageData];
                doneCallback(sourceUrl, image);
            });
        }
    }
}

@end
