//
//  LargeCell.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface LargeCell : UICollectionViewCell

@property (strong,nonatomic)MovieModel *largeCellModel;
//单元格翻转
- (void)cellFlip;

//重置 cell 的翻转状态
- (void)resetCell;

@end
