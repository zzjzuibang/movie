//
//  NewsModel.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
/*
 "id" : 1491539,
 "type" : 0,
 "image" : "http://img31.mtime.cn/mg/2012/06/28/102611.94434483.jpg",
 "title" : "阿汤哥加盟翻拍版\"范海辛\"",
 "summary" : "汤姆·克鲁斯,艾里克斯·库兹曼,范海辛"
 */
@property (copy ,nonatomic)NSNumber *newsID;
@property (copy ,nonatomic)NSNumber *type;
@property (copy ,nonatomic)NSString *image;
@property (copy ,nonatomic)NSString *title;
@property (copy ,nonatomic)NSString *summary;


@end
