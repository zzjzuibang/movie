//
//  WXTabBarButton.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "WXTabBarButton.h"

@implementation WXTabBarButton

- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)imageName withTitle:(NSString *)titleName{

    self = [super initWithFrame:frame];
    
    if (self != nil) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width  - 30)/2, 3, 30, 20)];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        //创建UIControl对象上的标题
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame) + 5, self.frame.size.width, 21)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.text = titleName;
        [self addSubview:label];

    }
    return self;

}

@end
