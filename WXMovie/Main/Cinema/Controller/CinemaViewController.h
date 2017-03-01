//
//  CinemaViewController.h
//  WXMovie
//
//  Created by mac on 15/3/2.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface CinemaViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    
    //结构
    /*
     [
     {"name" : "东城区","id" : "1029"},
     {"name" : "东城区","id" : "1029"}
     ...
     ]
     */
    NSArray *_districtArray;
    
    //结构
    /*
     {
     "1029":[
     影院Model1,
     影院Model2,
     ]
     }
     */
    NSMutableDictionary *_cinemaDictionary;
    
    
    //存储每一个组的是否收起的状态
    /*
     [NO,NO,NO]   //NO:收起  YES：展开
     */
    BOOL close[30]; 
    
}


@end
