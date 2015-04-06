//
//  MIMBaseModel.m
//  mismeet
//
//  Created by 方俊 on 15-4-5.
//  Copyright (c) 2015年 sunloc. All rights reserved.
//

#import "MIMBaseModel.h"

@implementation MIMBaseModel

+ (id) model {
    return self;
}

+ (id)modelWithJson:(NSDictionary *)json {
    return [[[self class] alloc]initWithDictionary:json];
}

+ (id)modelArrayWithJson:(NSArray *)jsonArray {
    Class clazz = [self class];
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
    
    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [ret addObject:[clazz modelWithJson:obj]];
    }];
    
    return ret;
}

#pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder {
    NSArray *keys = [self keys];
    
    if ([aDecoder allowsKeyedCoding]) {
        [keys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    } else {
        [keys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            [self setValue:[aDecoder decodeObject] forKey:obj];
        }];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *keys = [self keys];
    
    if ([aCoder allowsKeyedCoding]) {
        [keys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            [aCoder encodeObject:[self valueForKey:obj] forKey:obj];
        }];
    } else {
        [keys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            [aCoder encodeObject:[self valueForKey:obj]];
        }];
    }
}

- (NSArray *)keys {
    return nil;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:[self keys].count];
    NSArray *keys = self keys;
    [keys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        id value = [self valueForKey:obj];
        if (value && ![value isKindOfClass:[NSNull class]]) {
            [ret setObject:value forKey:obj];
        }
    }];
    return ret;
}

@end
