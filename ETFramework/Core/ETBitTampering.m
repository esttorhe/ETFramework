//
//  ETBitTampering.h
//  Esteban Torres - NSData & NSMutableData Bit Tampering
//
//  Copyright (c) 2013 Esteban Torres. All rights reserved.
//

#import "ETBitTampering.h"

@implementation NSData (ETBitTampering)

- (UInt8) uint8AtIndex:(NSUInteger)index
{
	UInt8 data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (UInt16) uint16AtIndex:(NSUInteger)index
{
	UInt16 data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (UInt32) uint32AtIndex:(NSUInteger)index
{
	UInt32 data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (UInt64) uint64AtIndex:(NSUInteger)index
{
	UInt64 data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (SInt8) sint8AtIndex:(NSUInteger)index
{
	SInt8 data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (SInt16) sint16AtIndex:(NSUInteger)index
{
	SInt16 data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (SInt32) sint32AtIndex:(NSUInteger)index
{
	SInt32 data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (SInt64) sint64AtIndex:(NSUInteger)index
{
	SInt64 data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (float) floatAtIndex:(NSUInteger)index
{
    float data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (double) doubleAtIndex:(NSUInteger)index
{
    double data = 0;
	[[self subdataWithRange:NSMakeRange(index, sizeof(data))] getBytes:&data length:sizeof(data)];
	return data;
}

- (NSString*) stringAtIndex:(NSUInteger)index withEncoding:(NSStringEncoding)encoding
{
    NSUInteger length = [self uint32AtIndex:index];
    index += sizeof(UInt32);
    
    return [[NSString alloc] initWithData:[self subdataWithRange:NSMakeRange(index, length)] encoding:encoding];
}

@end


@implementation NSMutableData (ETBitTampering)

- (void) appendUInt8:(UInt8)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendUInt16:(UInt16)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendUInt32:(UInt32)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendUInt64:(UInt64)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendSInt8:(SInt8)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendSInt16:(SInt16)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendSInt32:(SInt32)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendSInt64:(SInt64)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendFloat:(float)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendDouble:(double)data
{
	[self appendBytes:&data length:sizeof(data)];
}

- (void) appendString:(NSString*)data withEncoding:(NSStringEncoding)encoding
{
	if (data != nil)
	{
        [self appendUInt32:[data lengthOfBytesUsingEncoding:encoding]];
		[self appendData:[data dataUsingEncoding:encoding]];
	}
}

- (void) replaceUInt8:(UInt8)data AtIndex:(NSUInteger)index
{
	[self replaceBytesInRange:NSMakeRange(index, sizeof(data)) withBytes:&data];
}

- (UInt8) uint8AtIndex:(NSUInteger)index
{
	const char* bytes = [self bytes];
	return (UInt8)bytes[index];
}

@end

