//
//  SmallCollectionFlowLayout.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/23.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "SmallCollectionFlowLayout.h"

@implementation SmallCollectionFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.itemSize = CGSizeMake(80, kMovieHeaderViewOffSet);

    }
    return self;
}


@end
