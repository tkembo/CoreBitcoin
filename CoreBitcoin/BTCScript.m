// Oleg Andreev <oleganza@gmail.com>

#import "BTCScript.h"
#import "BTCAddress.h"

@implementation BTCScript

+ (instancetype) scriptWithAddress:(NSString*)addressBase58
{
    BTCAddress* address = [BTCAddress addressWithBase58String:addressBase58];
    if ([address isKindOfClass:[BTCPublicKeyAddress class]])
    {
        // OP_DUP OP_HASH160 <hash> OP_EQUALVERIFY OP_CHECKSIG
        NSMutableData* data = [NSMutableData data];
        
        BTCOpCode prefix[] = {OP_DUP, OP_HASH160};
        [data appendBytes:prefix length:sizeof(prefix)];
        
        unsigned char length = data.length;
        [data appendBytes:&length length:sizeof(length)];
        
        [data appendData:address.data];
        
        BTCOpCode suffix[] = {OP_EQUALVERIFY, OP_CHECKSIG};
        [data appendBytes:suffix length:sizeof(suffix)];
        
        return [[BTCScript alloc] initWithData:data];
    }
    else if ([address isKindOfClass:[BTCScriptHashAddress class]])
    {
        // OP_HASH160 <hash> OP_EQUAL
        NSMutableData* data = [NSMutableData data];
        
        BTCOpCode prefix[] = {OP_HASH160};
        [data appendBytes:prefix length:sizeof(prefix)];
        
        unsigned char length = data.length;
        [data appendBytes:&length length:sizeof(length)];
        
        [data appendData:address.data];
        
        BTCOpCode suffix[] = {OP_EQUAL};
        [data appendBytes:suffix length:sizeof(suffix)];
        
        return [[BTCScript alloc] initWithData:data];
    }
    else
    {
        return nil;
    }
}

- (id) initWithData:(NSData*)data
{
    if (self = [super init])
    {
        // TODO
    }
    return self;
}

- (id) initWithString:(NSString*)string
{
    if (self = [super init])
    {
        // TODO
    }
    return self;
}

- (NSData*) data
{
    // TODO
    return nil;
}

- (id) string
{
    // TODO
    return nil;
}

@end