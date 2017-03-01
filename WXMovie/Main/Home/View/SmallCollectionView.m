//
//  SmallCollectionView.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/23.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "SmallCollectionView.h"
#import "SmallCell.h"
#define SmallCellID @"smallCellID"

@implementation SmallCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self != nil) {
        //注册单元格
        [self registerClass:[SmallCell class] forCellWithReuseIdentifier:SmallCellID];
        
    }
    return self;
}
//创建 item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SmallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SmallCellID forIndexPath:indexPath];
    cell.smallCellModel = self.collectionMoviesData[indexPath.item];
    return cell;

}
//设置边缘距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, (kScreenWidth - 80)/2, 0, (kScreenWidth - 80)/2);
    
}

@end
