//
//  TopCell.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "TopCell.h"
#import "StarView.h"
#import "UIImageView+WebCache.h"

@interface TopCell (){

    UIImageView *_topImageView;
    UILabel *_titleLabel;
    StarView *_starView;
    UILabel *_ratingLabel;

}

@end

@implementation TopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ;
        //创建 Cell 的视图
        [self _createSubviews];
    }
    return self;
}
#pragma mark - 创建子视图
- (void)_createSubviews{
    //电影图片
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width + 20)];
    [self.contentView addSubview:_topImageView];
    
    // 标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _topImageView.height - 16, self.width, 16)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.backgroundColor = [UIColor colorWithWhite:.3 alpha:.5];
    [self.contentView addSubview:_titleLabel];
    
    //星星视图
    _starView = [[StarView alloc]initWithFrame:CGRectMake(0, self.height - 25, self.width - 30, 16)];
    [self.contentView addSubview:_starView];
    
    //设置评分 Label
    _ratingLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_starView.frame) + 6, self.height - 23, 30, 16)];
    _ratingLabel.textAlignment = NSTextAlignmentCenter;
    _ratingLabel.textColor = [UIColor orangeColor];
    _ratingLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_ratingLabel];

}
#pragma  mark - setter方法
- (void)setTopCellModel:(TopModel *)topCellModel{
    _topCellModel = topCellModel;
//更新图片
    NSURL *url = [NSURL URLWithString:_topCellModel.images[@"medium"] ];
    [_topImageView sd_setImageWithURL:url];
//电影标题
    _titleLabel.text = _topCellModel.title;
//评分
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",[_topCellModel.rating[@"average"] floatValue]];
//星星视图
    _starView.rating =  [_topCellModel.rating[@"average"] floatValue];

}





@end
