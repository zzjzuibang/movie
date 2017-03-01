//
//  BaseViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BaseViewController.h"
#import "WXTabBarButton.h"

@interface BaseViewController ()

@end


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];

}

//内存不够使用的时候,发出通知,会通知每一个继承与当前基类的视图控制器.然后会调用这个方法
- (void)didReceiveMemoryWarning {

    if (self.view.window == nil && self.isViewLoaded) {
        self.view = nil;
        NSLog(@"获取到警告的类%@",NSStringFromClass(self.class));
    }
}


@end
