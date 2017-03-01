//
//  JSONDataService.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONDataService : NSObject
//解析 JSON 数据

+ (id)loadJSONData:(NSString *)fileName;

@end
