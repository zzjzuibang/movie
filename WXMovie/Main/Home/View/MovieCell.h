//
//  MovieCell.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
#import "StarView.h"

@interface MovieCell : UITableViewCell
@property (strong, nonatomic)MovieModel *cellModel;

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet StarView *starView;

@end
