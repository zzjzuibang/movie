//
//  AppDelegate.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "GuideViewController.h"
#import "LaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    BaseTabBarController *baseTabBarCtrl = [storyBoard instantiateInitialViewController];
//    self.window.rootViewController = baseTabBarCtrl;
    
    //一般情况下,实在第一次安装程序或者更新程序的时候需要显示引导页
    //我们可以根据在沙盒路径中写入每次的版本进行比较完成是否进行引导页面的显示
    
    //获取沙盒路径中的版本号(沙盒路径中原本没有存储版本号)
    //当前APP 下载完(更新完之后)之后的版本信息
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //NSLog(@"infoDict = %@",infoDict);
    double version = [infoDict[@"CFBundleShortVersionString"] doubleValue];
   // NSLog(@"version = %f",version);
    
    //获取到管理用户偏好设置文件的对象
    NSUserDefaults *userDefauls = [NSUserDefaults standardUserDefaults];
    double lastVersion = [[userDefauls objectForKey:@"version"] doubleValue];//如果之前没有存储过,什么都取不出来,默认是0
   //NSString *homeDir =  NSHomeDirectory();
    //NSLog(@"homeDir = %@1",homeDir);
    //NSLog(@"lastVersion = %f",lastVersion);
    
    if (version > lastVersion) {//如果当前的版本比之前的版本要大
        //现实引导页面
        self.window.rootViewController = [[GuideViewController alloc]init];
        //更新沙盒路径中的版本信息
        [userDefauls setObject:@(version) forKey:@"version"];
    }else{
        
        self.window.rootViewController = [[LaunchViewController alloc]init];
    }
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
