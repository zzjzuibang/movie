//
//  LaunchViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/29.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "LaunchViewController.h"
#import "BaseTabBarController.h"
#import "RESideMenu.h"
#import "DEMOLeftMenuViewController.h"
#import "DEMORightMenuViewController.h"
#import "BaseTabBarController.h"

@interface LaunchViewController (){
    NSMutableArray *_imageArray;
    NSInteger _index;//默认就是0
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createImageView];
//    _index = 0;
    [self startAnimation];

}
//开始动画
- (void)startAnimation{
    // 跳出自己玩自己的循环
    if (_index >= _imageArray.count) {//玩到最后一张图片,我就停
        //切换根视图控制器-->标签控制器(通过故事板去取)
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BaseTabBarController *tabBarController = [storyBoard instantiateInitialViewController];
        //取出来之后,将视图缩小
        tabBarController.view.transform = CGAffineTransformMakeScale(.2, .2);
        //在放大(用动画放大-->动画有时间)
        [UIView animateWithDuration:1 animations:^{
            tabBarController.view.transform = CGAffineTransformIdentity;
        }];

        //当前这个View 必选在window上。
        //更改了rootViewController
        DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
        DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];
        RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:tabBarController
                                                                        leftMenuViewController:leftMenuViewController
                                                                       rightMenuViewController:rightMenuViewController];
        sideMenuViewController.backgroundImage = [UIImage imageNamed:@"bg_main"];
        sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
        sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
        sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
        sideMenuViewController.contentViewShadowOpacity = 0.6;
        sideMenuViewController.contentViewShadowRadius = 12;
        sideMenuViewController.contentViewShadowEnabled = YES;
        
        self.view.window.rootViewController = sideMenuViewController;
        
        
        
        return;//必须加这么一句,不加会继续走下面的方法,取出数组界外的东西,数组越界
    }
    //每次自己玩自己取出对应的图片, index 自己加一
    UIImageView *imageView = _imageArray[_index ++];
    //修改透明度(添加了属性动画)
    [UIView animateWithDuration:.1 animations:^{
        imageView.alpha = 1;
    }];
    //延迟自己玩自己的时间
    [self performSelector:@selector(startAnimation) withObject:self afterDelay:.1];
    
}

//创建每一张图片,并且提前设置他们的位置还有透明度
- (void)_createImageView{

    CGFloat width = kScreenWidth/4;
    CGFloat height = kScreenHeight/7;
    
    CGFloat count = 28;
    CGFloat x = 0;
    CGFloat y = 0;
    
    _imageArray = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        UIImageView *launchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        launchImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i + 1]];
        [self.view addSubview:launchImageView];

        if (i <= 3) {
            x = i * width;
            y = 0;
        }else if (i <= 9){
            x = kScreenWidth - width;
            y = (i - 3) * height;
        }else if (i <= 12 ){
            x = kScreenWidth - (i - 8) * width;
            y = kScreenHeight -height;
        }else if (i <= 17){
            x = 0;
            y = kScreenHeight - (i - 11)*height;
        }else if (i <= 19){
            x = (i - 17) * width;
            y = height;
        }else if ( i <= 23){
            x = 2 * width;
            y = (i - 18) * height;
        }else if (i <= 27){
            x = width;
            y = kScreenHeight - (i - 22)*height;
        }
        launchImageView.origin = CGPointMake(x, y);
        launchImageView.alpha = 0;
        [_imageArray addObject:launchImageView];
    }
}



@end
