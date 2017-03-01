//
//  CommonModel.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject
/*
 {
 "userImage" : "http://img2.mtime.com/images/default/head.gif",
 "nickname" : "yangna988",
 "rating" : "9.0",
 "content" : "儿子很喜欢 一直期盼上映"
 }
 */
@property (copy, nonatomic)NSString *userImage;
@property (copy, nonatomic)NSString *nickname;
@property (copy, nonatomic)NSString *rating;
@property (copy, nonatomic)NSString *content;



@end
