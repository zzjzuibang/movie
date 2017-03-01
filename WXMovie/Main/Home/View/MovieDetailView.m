//
//  MovieDetailView.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MovieDetailView.h"
#import "UIImageView+WebCache.h"

@implementation MovieDetailView
//复写 setter 方法
- (void)setMovieModel:(MovieModel *)movieModel{
    _movieModel = movieModel;
    
    //1.电影名称
    _titleLabel.text = _movieModel.title;
    
    //2.年份
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@",_movieModel.year];
    
    //3.评分
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",[_movieModel.rating[@"average"] floatValue]];
    //4.图片
    //_movieImageView.image = [UIImage imageNamed:@""];本地图片这样加载
    NSURL *url = [NSURL URLWithString:_movieModel.images[@"large"]];
    [_MovieImageView sd_setImageWithURL:url];
    
    //5.星星视图
    _starView.rating = [_movieModel.rating[@"average"] floatValue];





}

@end
