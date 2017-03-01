//
//  StarView.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "StarView.h"

@interface StarView (){

    UIView *_yellowView;
    UIView *_grayView;
}

@end

@implementation StarView

//是用代码初始化的时候需要手动调用
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createStarView];
    }
    return self;
}
//nib 文件初始化 (初始化nib 文件的时候就会自动调用这个方法)
- (void)awakeFromNib{
    [super awakeFromNib];

    [self _createStarView];
}
//创建星星视图
- (void)_createStarView{

    //灰色星星图片
    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    //黄色星星图片
    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    
    //1.根据灰色星星图片创建具有五个灰色星星背景视图
    _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    [self addSubview:_grayView];
    //2.根据黄色星星图片创建具有五个黄色星星背景视图
    _yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    [self addSubview:_yellowView];
    //3.调整星星视图的大小(根据当前背景视图的高度和星星视图的高度之间的比例--->放大比例)
    //放大倍数 = 背景视图的高度/星星视图的高度
    float scale = self.frame.size.height /_grayView.frame.size.height;
    _grayView.transform = CGAffineTransformMakeScale(scale, scale);
    _yellowView.transform = CGAffineTransformMakeScale(scale, scale);
    //4.两个星星的视图的坐标放回原点
    //    CGRect rect = grayView.frame;
    //    rect.origin = CGPointZero;
    //    grayView.frame = rect;
    //    yellowView.frame = rect;
    _yellowView.origin = CGPointZero;
    _grayView.origin = CGPointZero;
    
    
    
    
//    //5.调整黄色星星视图的宽度
//    //宽度 = 整个宽度 * 评分的百分比(评分/10)
//    float rating = [_cellModel.rating[@"average"] floatValue];
//    yellowView.width = yellowView.width * (rating /10.00);


}

- (void)setRating:(float)rating{
    
    _rating = rating;
    _yellowView.width = _grayView.width * (rating /10.00);


}


@end
