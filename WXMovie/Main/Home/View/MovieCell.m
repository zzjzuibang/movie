//
//  MovieCell.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"

@implementation MovieCell


//这个方法在 cell 将要显示的时候调用
- (void)setCellModel:(MovieModel *)cellModel{
    _cellModel = cellModel;
    
    //1.电影名称
    _titleLabel.text = _cellModel.title;
    
    //2.年份
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@",_cellModel.year];
    
    //3.评分
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",[_cellModel.rating[@"average"] floatValue]];
    //4.图片
    //_movieImageView.image = [UIImage imageNamed:@""];本地图片这样加载
    NSURL *url = [NSURL URLWithString:_cellModel.images[@"medium"]];
    [_movieImageView sd_setImageWithURL:url];
    
    //iOS9 之后苹果增加安全策略,要 https网络才可以请求数据,但是我们的服务器大多数还是使用 http 协议,需要关闭苹果的安全措施
    //在plist 文件中加入这么一个属性 App Transport Security Settings,并且在该属性下面(点箭头)再添加一个属性:Allow Arbitrary Loads,并且他的值设置为 yes
    //5.设置星星视图
    //    //灰色星星图片
    //    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    //    //黄色星星图片
    //    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    ////1.根据灰色星星图片创建具有五个灰色星星背景视图
    //    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    //    grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    //    [_starView addSubview:grayView];
    ////2.根据黄色星星图片创建具有五个黄色星星背景视图
    //    UIView *yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    //    yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    //    [_starView addSubview:yellowView];
    ////3.调整星星视图的大小(根据当前背景视图的高度和星星视图的高度之间的比例--->放大比例)
    //    //放大倍数 = 背景视图的高度/星星视图的高度
    //    float scale = _starView.frame.size.height /grayView.frame.size.height;
    //    grayView.transform = CGAffineTransformMakeScale(scale, scale);
    //    yellowView.transform = CGAffineTransformMakeScale(scale, scale);
    ////4.两个星星的视图的坐标放回原点
    ////    CGRect rect = grayView.frame;
    ////    rect.origin = CGPointZero;
    ////    grayView.frame = rect;
    ////    yellowView.frame = rect;
    //    yellowView.origin = CGPointZero;
    //    grayView.origin = CGPointZero;
    ////5.调整灰色星星视图的宽度
    //    //宽度 = 整个宽度 * 评分的百分比(评分/10)
    //    float rating = [_cellModel.rating[@"average"] floatValue];
    //    yellowView.width = yellowView.width * (rating /10.00);
    
    _starView.rating = [_cellModel.rating[@"average"] floatValue];
    
    

    




}

- (void)layoutSubviews{
    [super layoutSubviews];
////1.电影名称
//    _titleLabel.text = _cellModel.title;
//
////2.年份
//    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@",_cellModel.year];
//    
////3.评分
//    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",[_cellModel.rating[@"average"] floatValue]];
////4.图片
//    //_movieImageView.image = [UIImage imageNamed:@""];本地图片这样加载
//    NSURL *url = [NSURL URLWithString:_cellModel.images[@"medium"]];
//    [_movieImageView sd_setImageWithURL:url];
//    
//    //iOS9 之后苹果增加安全策略,要 https网络才可以请求数据,但是我们的服务器大多数还是使用 http 协议,需要关闭苹果的安全措施
//    //在plist 文件中加入这么一个属性 App Transport Security Settings,并且在该属性下面(点箭头)再添加一个属性:Allow Arbitrary Loads,并且他的值设置为 yes
////5.设置星星视图
////    //灰色星星图片
////    UIImage *grayImage = [UIImage imageNamed:@"gray"];
////    //黄色星星图片
////    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
//////1.根据灰色星星图片创建具有五个灰色星星背景视图
////    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
////    grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
////    [_starView addSubview:grayView];
//////2.根据黄色星星图片创建具有五个黄色星星背景视图
////    UIView *yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
////    yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
////    [_starView addSubview:yellowView];
//////3.调整星星视图的大小(根据当前背景视图的高度和星星视图的高度之间的比例--->放大比例)
////    //放大倍数 = 背景视图的高度/星星视图的高度
////    float scale = _starView.frame.size.height /grayView.frame.size.height;
////    grayView.transform = CGAffineTransformMakeScale(scale, scale);
////    yellowView.transform = CGAffineTransformMakeScale(scale, scale);
//////4.两个星星的视图的坐标放回原点
//////    CGRect rect = grayView.frame;
//////    rect.origin = CGPointZero;
//////    grayView.frame = rect;
//////    yellowView.frame = rect;
////    yellowView.origin = CGPointZero;
////    grayView.origin = CGPointZero;
//////5.调整灰色星星视图的宽度
////    //宽度 = 整个宽度 * 评分的百分比(评分/10)
////    float rating = [_cellModel.rating[@"average"] floatValue];
////    yellowView.width = yellowView.width * (rating /10.00);
//    
//    _starView.rating = [_cellModel.rating[@"average"] floatValue];
//
//

}

@end
