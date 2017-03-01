//
//  HeadView.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HeadView.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "BaseNavigationController.h"

@implementation HeadView

- (void)setDetailModel:(DetailModel *)detailModel{
    _detailModel = detailModel;
    
    //图片
    [_movieCommonImageView sd_setImageWithURL:[NSURL URLWithString:_detailModel.image]];
    //电影标题
    _titleLabel.text = _detailModel.titleCn;
    
    //导演
    _directorLabel.text = _detailModel.directors[0];
    
    //类型
    _typeLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",_detailModel.type[0],_detailModel.type[1],_detailModel.type[2],_detailModel.type[3]];
    
    //区域 和时间
    _locationDateLabel.text = [NSString stringWithFormat:@"%@  %@",_detailModel.detailRelease[@"location"],_detailModel.detailRelease[@"date"]];
    
    //滑动视图
    NSArray *images = _detailModel.images;
    //定义每一张图片的宽度
    float width = _scrollView.frame.size.width /4;
    //定义内容尺寸
    _scrollView.contentSize = CGSizeMake(width * images.count + 30, _scrollView.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.layer.cornerRadius = 5;
    _scrollView.layer.borderWidth = 4;
    _scrollView.layer.borderColor = [UIColor orangeColor].CGColor;
    //在滑动视图上添加图片
    for (int i = 0; i < images.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * (width + 3), 0, width, _scrollView.height)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_detailModel.images[i]]];
        [_scrollView addSubview:imageView];
        
    }

}

- (IBAction)PlayAction:(UIButton *)sender {
    //获取当前View对应的导航控制器
    BaseNavigationController *baseNavi = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[2];
    
    MPMoviePlayerViewController *moviePlayerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/06/21/mp4/120621112404690593.mp4"]];
    
    //[baseNavi pushViewController:moviePlayerViewController animated:YES];
    [baseNavi presentMoviePlayerViewControllerAnimated:moviePlayerViewController];
    
    
}
@end
