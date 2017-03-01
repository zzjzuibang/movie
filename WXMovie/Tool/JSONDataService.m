//
//  JSONDataService.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "JSONDataService.h"

@implementation JSONDataService

+ (id)loadJSONData:(NSString *)fileName{
    //解析 JSON 中的数据:
    //1.获取 bundle 包中 JSON 文件的路径
    NSString *JSONPathString = [[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    //2.将对应路径中的 JSON 文件转化成二进制的文件
    NSData *JSONData = [NSData dataWithContentsOfFile:JSONPathString];
    //3.将 JSON 的二进制的文件转化成对象
    id data = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"dictionary = %@",dictionary);
    return data;

}

@end
