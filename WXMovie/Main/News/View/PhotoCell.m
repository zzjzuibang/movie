//
//  PhotoCell.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/27.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "PhotoCell.h"
#import "UIImageView+WebCache.h"

@interface PhotoCell ()<UIScrollViewDelegate>{
    UIScrollView *_photoScrollView;
    UIImageView *_photoImageView;

}

@end

@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建子视图
        [self _createSubviews];
    }
    return self;
}

# pragma mark - 创建子视图
- (void)_createSubviews{
    //滑动视图
    _photoScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:_photoScrollView];
    _photoScrollView.tag = 1000;
    _photoScrollView.delegate = self;
    _photoScrollView.minimumZoomScale = 0.5;
    _photoScrollView.maximumZoomScale = 3;
    //创建图片视图
    _photoImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_photoScrollView addSubview:_photoImageView];
    //添加单击手势
    UITapGestureRecognizer *tapGestureRecognizeSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
    [_photoScrollView addGestureRecognizer:tapGestureRecognizeSingle];
    //添加双击手势
    UITapGestureRecognizer *tapGestureRecognizeDouble = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction:)];
    //几个手指头
    tapGestureRecognizeDouble.numberOfTouchesRequired = 1;
    //点几次
    tapGestureRecognizeDouble.numberOfTapsRequired = 2;
    [_photoScrollView addGestureRecognizer:tapGestureRecognizeDouble];
    //双击的时候让单击失效
    [tapGestureRecognizeSingle requireGestureRecognizerToFail:tapGestureRecognizeDouble];
    
}
//缩放的代理方法(返回值是你要缩放的视图)
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return _photoImageView;

}
#pragma  mark - 单击的方法
- (void)singleTapAction:(UITapGestureRecognizer *)tapGestureRecognizer{
//发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SingleTap" object:nil];

}

#pragma  mark - 双击的方法
- (void)doubleTapAction:(UITapGestureRecognizer *)tapGestureRecognizer{
    
    if (_photoScrollView.zoomScale == 1) {//如果没放大
        //放大2倍
        [_photoScrollView setZoomScale:2 animated:YES];
    }else if (_photoScrollView.zoomScale == 2){//如果放大了
        //恢复
        [_photoScrollView setZoomScale:1 animated:YES];
    }
}

- (void)setPhotoModel:(NewsImageModel *)photoModel{
    _photoModel = photoModel;
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:_photoModel.image]];
}


@end
