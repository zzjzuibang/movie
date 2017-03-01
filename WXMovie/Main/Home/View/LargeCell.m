//
//  LargeCell.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "LargeCell.h"
#import "UIImageView+WebCache.h"
#import "MovieDetailView.h"


@interface LargeCell (){
    UIImageView *_postImageView;
    MovieDetailView *_movieDetailView;

}

@end

@implementation LargeCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ;
        self.contentView.backgroundColor = [UIColor clearColor];
        //创建 Item 上的视图
        [self _createSubviews];
    }
    return self;
}

- (void)_createSubviews{
    //创建 Item 上的电影海报图片
    _postImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:_postImageView];
    
    //创建 item上的电影详情视图
    _movieDetailView = [[[NSBundle mainBundle]loadNibNamed:@"MovieDetailView" owner:self options:nil] firstObject];
    _movieDetailView.layer.cornerRadius = 6;
    _movieDetailView.layer.borderWidth = 4;
    _movieDetailView.layer.borderColor = [UIColor orangeColor].CGColor;
    _movieDetailView.hidden = YES;
    [self.contentView addSubview:_movieDetailView];
    
}


- (void)setLargeCellModel:(MovieModel *)largeCellModel{
    _largeCellModel = largeCellModel;
    
    //NSLog(@"_largeCellModel = %@",_largeCellModel);
    //给电影海报视图添加图片
    NSURL *url = [NSURL URLWithString:_largeCellModel.images[@"large"]];
    [_postImageView sd_setImageWithURL:url];
    
    //给电影详情视图传递数据
    _movieDetailView.movieModel = _largeCellModel;
}
//单元格翻转
- (void)cellFlip{
    
    //设置翻转模式
    UIViewAnimationOptions options = _movieDetailView.hidden?UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight;
    //让对应的进行视图翻转动画
    [UIView transitionWithView:self.contentView duration:.5 options:options animations:^{
        //将两个视图的隐藏装太都进行改变
        _postImageView.hidden = !_postImageView.hidden;
        _movieDetailView.hidden = !_movieDetailView.hidden;
    } completion:^(BOOL finished) {
        ;
    }];


}
//重置 cell 的翻转状态
- (void)resetCell{
    _postImageView.hidden = NO;
    _movieDetailView.hidden = YES;

}

@end
