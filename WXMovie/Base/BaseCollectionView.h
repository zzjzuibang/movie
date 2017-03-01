//
//  BaseCollectionView.h
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionView : UICollectionView


@property (strong ,nonatomic)NSArray *collectionMoviesData;
@property (assign ,nonatomic)NSInteger currentPage;

@end
