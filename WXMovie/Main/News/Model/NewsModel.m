//
//  NewsModel.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        _newsID = value;
    }
}

@end
