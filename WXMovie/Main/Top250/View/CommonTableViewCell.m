//
//  CommonTableViewCell.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CommonTableViewCell

- (void)setCommonModel:(CommonModel *)commonModel{
    _commonModel = commonModel;
    //图片
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_commonModel.userImage]];

    //昵称
    _nickNameLabel.text = _commonModel.nickname;
    
    //评分
    _ratingLabel.text = _commonModel.rating;
    
    //评论
    _commonLabel.text = _commonModel.content;

}

@end
