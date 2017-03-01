//
//  GuideViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/29.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "GuideViewController.h"
#import "LaunchViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建子视图
    [self _createScrollView];
}
//创建滑动视图
- (void)_createScrollView{
    
//创建滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = CGSizeMake(kScreenWidth *5, kScreenHeight);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];

//向滑动视图上添加图片
    for (int i = 0 ; i < 5; i ++) {
        //创建引导图片
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d",i + 1]];
        [scrollView addSubview:imageView];
        //创建分页图片
        UIImageView *pageImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 173)/2, kScreenHeight - 50, 173, 26)];
        pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideProgress%d",i + 1]];
        [imageView addSubview:pageImageView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x > kScreenWidth * 4) {
        self.view.window.rootViewController = [[LaunchViewController alloc]init];
    }

}

@end
