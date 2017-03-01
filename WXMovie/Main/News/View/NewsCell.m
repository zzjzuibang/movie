//
//  NewsCell.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"


@implementation NewsCell

- (void)setNewsModel:(NewsModel *)newsModel{
    _newsModel = newsModel;
    
//新闻图片
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.image]];

//类型图片
    if ([_newsModel.type integerValue] == kWordType ) {
        _typeImageView.image = nil;
    }else if ([_newsModel.type integerValue] == kImageType){
        _typeImageView.image = [UIImage imageNamed:@"sctpxw"];
    }else if ([_newsModel.type integerValue] == kVideoType){
        _typeImageView.image = [UIImage imageNamed:@"scspxw"];
    }
//新闻标题
    _titleLabel.text = _newsModel.title;
    
//概述
    _summaryLabel.text = _newsModel.summary;

}



@end
