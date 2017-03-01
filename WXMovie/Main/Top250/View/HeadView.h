//
//  HeadView.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface HeadView : UIView

- (IBAction)PlayAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIImageView *movieCommonImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationDateLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong , nonatomic)DetailModel *detailModel;





@end
