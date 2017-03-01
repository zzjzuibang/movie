//
//  TopModel.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopModel : NSObject

/*
 {
 "rating": {
 "max": 10,
 "average": 9.6,
 "stars": "50",
 "min": 0
 },
 "title": "肖申克的救赎",
 "images": {
 "small": "https://img1.doubanio.com/view/movie_poster_cover/ipst/public/p480747492.jpg",
 "large": "https://img1.doubanio.com/view/movie_poster_cover/lpst/public/p480747492.jpg",
 "medium": "https://img1.doubanio.com/view/movie_poster_cover/spst/public/p480747492.jpg"
 },
 }
 */
@property (strong,nonatomic)NSDictionary *rating;
@property (copy , nonatomic)NSString *title;
@property (strong,nonatomic)NSDictionary *images;

@end
