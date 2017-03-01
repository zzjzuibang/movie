//
//  MoreTableViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/27.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MoreTableViewController.h"
#import "SDImageCache.h"

@interface MoreTableViewController ()<UIAlertViewDelegate>

@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"让不让磕碜帮你清除缓存?" message:@"爱啥啥" delegate: self cancelButtonTitle:@"太磕碜不让" otherButtonTitles:@"凑活来吧", nil];
        [alertView show];
  
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex = %ld",buttonIndex);
    if (buttonIndex == 1) {
        //清除缓存
        [[SDImageCache sharedImageCache] clearDisk];//清除沙盒路径里的缓存
        [[SDImageCache sharedImageCache]clearMemory];//清除运行内存中的缓存(这一步可以通过关闭软件来实现)
        
        [self.tableView reloadData];//刷新表格
        
    } else{
        //啥都不干
        
    }
}


- (void)viewWillAppear:(BOOL)animated{

    [self.tableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        UILabel *cacheLabel = (UILabel *)[cell.contentView viewWithTag:1024];
        NSUInteger size = [[SDImageCache sharedImageCache] getSize];
        //1M = 1024kb = 1024 * 1024 B
        NSLog(@"size = %ld",size);
        cacheLabel.text = [NSString stringWithFormat:@"%.1f MB",size/1024/1024.0];
   
    }

}






@end
