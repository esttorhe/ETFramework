//
//  ETBitTampering.h
//  Esteban Torres - NSData & NSMutableData Bit Tampering
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `NSData (ETBitTampering)` is a helper class that allows easy `NSData` objects manipulation.
 */
@interface NSData (ETBitTampering)
/**------------------------------------------------------------------------------------------------------------------
 * @name UInt<#> retrieval methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns a `UInt8` value located at the specified index.
 
 @param index The character index that will be returned as a `UInt8`.
 
 @return A `UInt8` value from the character at the specified index.
 */
- (UInt8)  uint8AtIndex:(NSUInteger)index;

/**
 Returns a `UInt16` value located at the specified index.
 
 @param index The character index that will be returned as a `UInt16`.
 
 @return A `UInt16` value from the character at the specified index.
 */
- (UInt16) uint16AtIndex:(NSUInteger)index;

/**
 Returns a `UInt32` value located at the specified index.
 
 @param index The character index that will be returned as a `UInt32`.
 
 @return A `UInt32` value from the character at the specified index.
 */
- (UInt32) uint32AtIndex:(NSUInteger)index;

/**
 Returns a `UInt64` value located at the specified index.
 
 @param index The character index that will be returned as a `UInt64`.
 
 @return A `UInt64` value from the character at the specified index.
 */
- (UInt64) uint64AtIndex:(NSUInteger)index;

/**------------------------------------------------------------------------------------------------------------------
 * @name SInt<#> retrieval methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns a `SInt8` value located at the specified index.
 
 @param index The character index that will be returned as a `SInt8`.
 
 @return A `SInt8` value from the character at the specified index.
 */
- (SInt8)  sint8AtIndex:(NSUInteger)index;

/**
 Returns a `SInt16` value located at the specified index.
 
 @param index The character index that will be returned as a `SInt16`.
 
 @return A `SInt16` value from the character at the specified index.
 */
- (SInt16) sint16AtIndex:(NSUInteger)index;

/**
 Returns a `SInt32` value located at the specified index.
 
 @param index The character index that will be returned as a `SInt32`.
 
 @return A `SInt32` value from the character at the specified index.
 */
- (SInt32) sint32AtIndex:(NSUInteger)index;

/**
 Returns a `SInt64` value located at the specified index.
 
 @param index The character index that will be returned as a `SInt64`.
 
 @return A `SInt64` value from the character at the specified index.
 */
- (SInt64) sint64AtIndex:(NSUInteger)index;

/**------------------------------------------------------------------------------------------------------------------
 * @name Float & Double retrieval methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns a `float` value located at the specified index.
 
 @param index The character index that will be returned as a `float`.
 
 @return A `float` value from the character at the specified index.
 */
- (float) floatAtIndex:(NSUInteger)index;

/**
 Returns a `double` value located at the specified index.
 
 @param index The character index that will be returned as a `double`.
 
 @return A `double` value from the character at the specified index.
 */
- (double) doubleAtIndex:(NSUInteger)index;

/**------------------------------------------------------------------------------------------------------------------
 * @name String retrieval methods.
 * ------------------------------------------------------------------------------------------------------------------
 */
/**
 Returns a `NSString` object from the character at the specified index with the provided encoding.
 
 @param index The index of the "character" that will be converted to `NSString`
 
 @param encoding The `NSStringEncoding` that should be used to convert the character into `NSString`.
 
 @return A `NSString` object from the index specified formatted using the provided encoding.
 */
- (NSString *) stringAtIndex:(NSUInteger)index withEncoding:(NSStringEncoding)encoding;

@end

/**
 `NSMutableData (ETBitTampering)` is a helper class that allows easy `NSMutableData` objects manipulation.
 */
@interface NSMutableData (ETBitTampering)

/**
 Appends a `UInt8` value to the `NSMutableData` object.
 
 @param data The `UInt8` value to be appended to the `NSMutableData`.
 */
- (void) appendUInt8:(UInt8)data;

/**
 Appends a `UInt16` value to the `NSMutableData` object.
 
 @param data The `UInt16` value to be appended to the `NSMutableData`.
 */
- (void) appendUInt16:(UInt16)data;

/**
 Appends a `UInt32` value to the `NSMutableData` object.
 
 @param data The `UInt32` value to be appended to the `NSMutableData`.
 */
- (void) appendUInt32:(UInt32)data;

/**
 Appends a `UInt64` value to the `NSMutableData` object.
 
 @param data The `UInt64` value to be appended to the `NSMutableData`.
 */
- (void) appendUInt64:(UInt64)data;

/**
 Appends a `SInt8` value to the `NSMutableData` object.
 
 @param data The `SInt8` value to be appended to the `NSMutableData`.
 */
- (void) appendSInt8:(SInt8)data;

/**
 Appends a `SInt16` value to the `NSMutableData` object.
 
 @param data The `SInt16` value to be appended to the `NSMutableData`.
 */
- (void) appendSInt16:(SInt16)data;

/**
 Appends a `SInt32` value to the `NSMutableData` object.
 
 @param data The `SInt32` value to be appended to the `NSMutableData`.
 */
- (void) appendSInt32:(SInt32)data;

/**
 Appends a `SInt64` value to the `NSMutableData` object.
 
 @param data The `SInt64` value to be appended to the `NSMutableData`.
 */
- (void) appendSInt64:(SInt64)data;

/**
 Appends a `float` value to the `NSMutableData` object.
 
 @param data The `float` value to be appended to the `NSMutableData`.
 */
- (void) appendFloat:(float)data;

/**
 Appends a `double` value to the `NSMutableData` object.
 
 @param data The `double` value to be appended to the `NSMutableData`.
 */
- (void) appendDouble:(double)data;

/**
 Appends a `NSString` object to the `NSMutableData` object using the provided `NSStringEncoding`.
 
 @param data The `NSString` object that will be appended to the `NSMutableData` object.
 
 @param encoding The `NSStringEncoding` that will be used to encode the provided `NSString` and appended to the `NSMutableData`.
 */
- (void) appendString:(NSString *)data withEncoding:(NSStringEncoding)encoding;

@end