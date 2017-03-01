//
//  ImageCell.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ImageCell.h"
#import "UIImageView+WebCache.h"

@interface ImageCell (){
    UIImageView *_imageView;

}

@end

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建图片视图
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
        
    }
    return self;
}

- (void)setImageModel:(NewsImageModel *)imageModel{
    _imageModel = imageModel;
    //更新图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageModel.image]];

}

@end
