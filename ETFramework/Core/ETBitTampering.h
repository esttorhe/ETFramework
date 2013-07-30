//
//  ETBitTampering.h
//  Esteban Torres - NSData & NSMutableData Bit Tampering
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ETBitTampering)

- (UInt8)  uint8AtIndex:(NSUInteger)index;
- (UInt16) uint16AtIndex:(NSUInteger)index;
- (UInt32) uint32AtIndex:(NSUInteger)index;
- (UInt64) uint64AtIndex:(NSUInteger)index;

- (SInt8)  sint8AtIndex:(NSUInteger)index;
- (SInt16) sint16AtIndex:(NSUInteger)index;
- (SInt32) sint32AtIndex:(NSUInteger)index;
- (SInt64) sint64AtIndex:(NSUInteger)index;

- (float) floatAtIndex:(NSUInteger)index;
- (double) doubleAtIndex:(NSUInteger)index;

- (NSString*) stringAtIndex:(NSUInteger)index withEncoding:(NSStringEncoding)encoding;

@end

@interface NSMutableData (ETBitTampering)

- (void) appendUInt8:(UInt8)data;
- (void) appendUInt16:(UInt16)data;
- (void) appendUInt32:(UInt32)data;
- (void) appendUInt64:(UInt64)data;

- (void) appendSInt8:(SInt8)data;
- (void) appendSInt16:(SInt16)data;
- (void) appendSInt32:(SInt32)data;
- (void) appendSInt64:(SInt64)data;

- (void) appendFloat:(float)data;
- (void) appendDouble:(double)data;
- (void) appendString:(NSString*)data withEncoding:(NSStringEncoding)encoding;

@end