//
//  JWTClaimBase.m
//  JWT
//
//  Created by Dmitry Lobanov on 10.08.2020.
//  Copyright © 2020 JWTIO. All rights reserved.
//

#import <JWT/JWTClaimBase.h>

@interface JWTClaimBase ()
@property (nonatomic, readwrite) NSObject *value;
@property (copy, nonatomic, readwrite) NSString *name;
@end
@implementation JWTClaimBase
@synthesize value = _value;
- (instancetype)initWithValue:(NSObject *)value {
    if (self = [super init]) {
        self.value = value;
    }
    return self;
}

// MARK: - NSCopying
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return [self copyWithValue:self.value];
}

// MARK: - JWTClaimProtocol
+ (NSString *)name { return @""; }
- (NSString *)name { return _name ?: self.class.name; }
- (instancetype)copyWithValue:(NSObject *)value {
    typeof(self) result = [[self.class alloc] initWithValue:value];
    result.name = self.name;
    return result;
}
- (instancetype)copyWithName:(NSString *)name {
    typeof(self) result = [[self.class alloc] initWithValue:self.value];
    result.name = name;
    return result;
}

@end
