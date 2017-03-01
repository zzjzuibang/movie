//
//  LargeCollectionView.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "LargeCollectionView.h"
#import "LargeCell.h"
#define  LargeCellID @"LargeCellID"
#import "LargeCollectionFlowLayout.h"

@interface LargeCollectionView ()
//<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation LargeCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self != nil) {
//        self.dataSource = self;
//        self.delegate   = self;
//        //self.pagingEnabled = YES;
//        self.decelerationRate = UIScrollViewDecelerationRateFast;
//        self.showsHorizontalScrollIndicator = NO;
    //注册单元格
        [self registerClass:[LargeCell class] forCellWithReuseIdentifier:LargeCellID];
    
    }
    return self;
}
////Item 的数量
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    return _collectionMoviesData.count;
//}
//创建 Item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LargeCellID forIndexPath:indexPath];
    cell.largeCellModel = self.collectionMoviesData[indexPath.item];
    
    return cell;
}
//设置边缘距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10, (kScreenWidth - kScreenWidth *0.7)/2, 10, (kScreenWidth - kScreenWidth *0.7)/2);

}
//点击单元格会调用这个方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.currentPage != indexPath.item) {//当前中间视图不等于点击的视图
        //跳转到你点的那个 cell
        self.userInteractionEnabled = NO;
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //[self performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>];
        //过一段时间执行块中的代码
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
        //保存我点击之后对应中间的 item 的位置
        self.currentPage = indexPath.item;
        
    }else{
            //翻转
        //点击哪个单元格,对应的单元格要翻转
        LargeCell *selectedCell = (LargeCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //点击的单元格进行翻转
        [selectedCell cellFlip];

            
    }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    

    LargeCell *selectedCell = (LargeCell *)cell;
    //重置 cell 的翻转状态
    [selectedCell resetCell];
}

////在视图将要拖拽结束的时候会调用这个方法
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
///*
// scrollView:集合视图
// velocity:结束拖拽的时候滑动视图的速度,水平滑动,y = 0,并且向左滑动是负数,向右滑动是整数
// targetContentOffset:内容目标偏移量(最终停止的位置的偏移量)
// */
////    float xVelocity = velocity.x;
////    float yVelocity = velocity.y;
////    NSLog(@"xVelocity = %f,yVelocity = %f",xVelocity,yVelocity);
////  获取滑动之后,最终停止的位置
//    float xOffset = targetContentOffset->x;
//    
//    //NSLog(@"xOffset = %f",xOffset);
//    LargeCollectionFlowLayout *flowLayout = (LargeCollectionFlowLayout *)self.collectionViewLayout;
//    
//    //页码的宽度(当前 cell 的宽度加上两边的间隙一半)
//    NSInteger pageWidth = kScreenWidth * 0.7 + flowLayout.minimumLineSpacing/2 * 2;
//    //当前的页数
//    NSInteger pageNum = (pageWidth/2 + xOffset) /pageWidth;
//    
//    
//    //NSLog(@"pageNum = %ld",pageNum);
//    //通过判断滑动的速度来确定当前的页数(优化)
//    pageNum = velocity.x == 0 ? pageNum :((velocity.x > 0)?pageNum + 1:pageNum - 1);
//    
//    //通过当前的页数,直接修改目标偏移量到当前页的中间就可以
//    targetContentOffset ->x = pageNum * pageWidth;
//    
//}

@end
