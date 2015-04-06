//
//  MIMBaseModel.h
//  mismeet
//
//  Created by 方俊 on 15-4-5.
//  Copyright (c) 2015年 sunloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIMBaseModel : NSObject<NSCoding> {
    
}

+ (id) model;

+ (id)modelWithJson:(NSDictionary *)json;

+ (id)modelArrayWithJson:(NSArray *)jsonArray;


@end
