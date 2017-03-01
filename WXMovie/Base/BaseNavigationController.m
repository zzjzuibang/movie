//
//  BaseNavigationController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//给当前的导航栏设置背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all-64"] forBarMetrics:UIBarMetricsDefault];
//修改状态栏的字体:
    //1.需要我们在系统的 plist 文件中增加 View controller-based status bar appearance这个属性,并且将这个属性改为 YES
    //2.复写- (UIStatusBarStyle)preferredStatusBarStyle,返回对应的样式

//修改导航栏的字体
    //1.修改导航栏的样式
    //self.navigationBar.barStyle = UIBarStyleBlack;//黑底白字
    
    //2.修改导航栏的字体属性(非常强大)
    //UIView
    //创建属性字典
    NSDictionary *attributesDic = @{
                                    NSForegroundColorAttributeName:[UIColor whiteColor],
                                    NSFontAttributeName:[UIFont systemFontOfSize:18]
                                    };
    self.navigationBar.titleTextAttributes = attributesDic;
    
    //3.自定义:根据自己的需求来设置每个视图控制器上的导航项的标题的样式

//透明度(设置为不透明)
    self.navigationBar.translucent = NO;
    
    



}
//设置状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
