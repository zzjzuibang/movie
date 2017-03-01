//
//  CinemaModel.m
//  WXMovie
//
//  Created by wei.chen on 13-9-5.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CinemaModel.h"

@implementation CinemaModel

//- (void)setAttributes:(NSDictionary *)jsonDic {
//    [super setAttributes:jsonDic];
//    
//    self.cinemaId = [jsonDic objectForKey:@"id"];
//}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        
        
        self.cinemaId = value;
    }

}
@end
