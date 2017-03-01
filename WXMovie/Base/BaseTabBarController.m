//
//  BaseTabBarController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BaseTabBarController.h"
#import "WXTabBarButton.h"

@interface BaseTabBarController (){

    UIImageView *_selectedImage;


}

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    //移除标签栏上的按钮
    //在这里不能移除标签栏上的按钮,移除之后还会加载它所管理的导航控制器,导航控制器会自动的给它重新添加(创建)上面的按钮
    //[self _removeTabBarButton];
    //添加按钮
    [self _createTabBarButton];
    
}
//视图将要显示的时候,进行移除(此时所有的视图都加载完成了)
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [self _removeTabBarButton];

}
//移除标签栏上的按钮
- (void)_removeTabBarButton{
    //NSLog(@"subviews = %@",self.tabBar.subviews);
    //UITabBarButtoniOS 框架中私有的类,不允许开发者直接使用
    //自己定义一个按钮的类型
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *view in self.tabBar.subviews) {//遍历
        
        if ([view isKindOfClass: class]) {//判断当前取出来的视图是不是我想移除的UITabBarButton类型
            [view removeFromSuperview];
        }
    }
}

- (void)_createTabBarButton{
    
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all"]];
    
    //每一个按钮的宽度
    float buttonWidth = kScreenWidth/5;
    _selectedImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectTabbar_bg_all"]];
    _selectedImage.frame = CGRectMake(0, 0, buttonWidth - 15, TabBarHeight - 5);
    [self.tabBar addSubview:_selectedImage];
    
    
    
    //创建所有按钮的标题数组(这样话可以有规律取出对应按钮的标题)
    NSArray *buttonTitles = @[@"首页",@"新闻",@"Top250",@"影院",@"更多"];
    NSArray *buttonImages = @[@"movie_home",@"msg_new",@"start_top250",@"icon_cinema",@"more_setting"];
    
    for (int i = 0; i < 5; i ++) {
        
        //创建标签栏上的按钮
//        UIButton *tabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        tabBarButton.frame = CGRectMake(i * buttonWidth , 0, buttonWidth, TabBarHeight);
//        [tabBarButton setTitle:buttonTitles[i] forState:UIControlStateNormal];
//        [tabBarButton setImage:[UIImage imageNamed:buttonImages[i]] forState:UIControlStateNormal];
//        [tabBarButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:tabBarButton];
//        //设置
//        tabBarButton.titleEdgeInsets = UIEdgeInsetsMake(20, -25, 0, 0);
//        tabBarButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 20, 0, 10);
        
        //创建 UIControl 对象(可以相应用户交互,是 UIView 的子类)
//        UIControl *tabBarControl = [[UIControl alloc]initWithFrame:CGRectMake(i * buttonWidth , 0, buttonWidth, TabBarHeight)];
//        [tabBarControl addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        
//        //创建UIControl对象上的图片
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((tabBarControl.frame.size.width  - 30)/2, 3, 30, 20)];
//        imageView.image = [UIImage imageNamed:buttonImages[i]];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [tabBarControl addSubview:imageView];
//        //创建UIControl对象上的标题
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame) + 5, tabBarControl.frame.size.width, 21)];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor whiteColor];
//        label.font = [UIFont systemFontOfSize:14];
//        label.text = buttonTitles[i];
//        [tabBarControl addSubview:label];
//        
//        [self.tabBar addSubview:tabBarControl];

        
//通过将 UIContol子类化,一方面继承了 UIcontrol 可以相应用户点击的功能,另一方面将一些比较个性化的功能添加子类中
        WXTabBarButton *tabBarButton = [[WXTabBarButton alloc]initWithFrame:CGRectMake(i * buttonWidth , 0, buttonWidth, TabBarHeight) withImage:buttonImages[i] withTitle:buttonTitles[i]];
        tabBarButton.tag = i + 1000;
        [tabBarButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:tabBarButton];
        
        //当创建第一个按钮的时候,将背景滑块的位置放在第一个按钮的中心
        if (i == 0) {
            _selectedImage.center = tabBarButton.center;
        }
    }

}
- (void)buttonAction:(UIButton *)button{
    //点击对应的按钮跳转到管理的对应的控制器
    self.selectedIndex = button.tag - 1000;
    //点击对应的按钮,将对应的背景滑块移动到对应的按钮的下面
    [UIView animateWithDuration:.35 animations:^{
        _selectedImage.center = button.center;
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
