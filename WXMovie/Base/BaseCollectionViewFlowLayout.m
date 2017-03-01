//
//  BaseCollectionViewFlowLayout.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/23.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BaseCollectionViewFlowLayout.h"

@implementation BaseCollectionViewFlowLayout

- (instancetype)init{
    self = [super init] ;
    if (self != nil) {
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    }
    return self;
    
}


@end
