//
//  SmallCell.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/23.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "SmallCell.h"
#import "UIImageView+WebCache.h"

@interface SmallCell (){
    UIImageView *_smallImageView;

}
@end

@implementation SmallCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建cell 上的电影图片
        _smallImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_smallImageView];
        
    }
    return self;
}
- (void)setSmallCellModel:(MovieModel *)smallCellModel{

    _smallCellModel = smallCellModel;
    //给图片添加数据
    NSURL *url = [NSURL URLWithString:_smallCellModel.images[@"medium"]];
    [_smallImageView sd_setImageWithURL:url];


}

@end
