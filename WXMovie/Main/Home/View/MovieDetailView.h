//
//  MovieDetailView.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "MovieModel.h"

@interface MovieDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *MovieImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet StarView *starView;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (strong, nonatomic)MovieModel *movieModel;


@end
