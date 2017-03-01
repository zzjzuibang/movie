//
//  DetailModel.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
//[<DetailModel 0x7fe69b47aca0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key rating.'
//当属性的名字和字典中的 key 不一样,还有字典中的 key有关键字 都会报错

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //value:值对象(key 对应)
    //key: 哪个key 是关键字
    if ([key isEqualToString:@"release"]) {
        _detailRelease = value;
    }
}

@end
