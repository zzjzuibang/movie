//
//  BaseCollectionView.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BaseCollectionView.h"
#import "LargeCollectionFlowLayout.h"
#import "BaseCollectionViewFlowLayout.h"

@interface BaseCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation BaseCollectionView

/*
 1.他们都有一个属性: 数据
 2.都需要设置代理,并且实现方法(个数一样)
 3.居中对齐
 4.都隐藏了滑动条
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self != nil) {
        self.dataSource = self;
        self.delegate   = self;
        //self.pagingEnabled = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.showsHorizontalScrollIndicator = NO;
        
    }
    return self;
}

//Item 的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _collectionMoviesData.count;
}
//创建 Item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}
//在视图将要拖拽结束的时候会调用这个方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    /*
     scrollView:集合视图
     velocity:结束拖拽的时候滑动视图的速度,水平滑动,y = 0,并且向左滑动是负数,向右滑动是整数
     targetContentOffset:内容目标偏移量(最终停止的位置的偏移量)
     */
    //    float xVelocity = velocity.x;
    //    float yVelocity = velocity.y;
    //    NSLog(@"xVelocity = %f,yVelocity = %f",xVelocity,yVelocity);
    //  获取滑动之后,最终停止的位置
    float xOffset = targetContentOffset->x;
    
    //NSLog(@"xOffset = %f",xOffset);
    BaseCollectionViewFlowLayout *flowLayout = (BaseCollectionViewFlowLayout *)self.collectionViewLayout;
    float itemWidth = flowLayout.itemSize.width;
    //页码的宽度(当前 cell 的宽度加上两边的间隙一半)
    NSInteger pageWidth = itemWidth + flowLayout.minimumLineSpacing/2 * 2;
    //当前的页数
    NSInteger pageNum = (pageWidth/2 + xOffset) /pageWidth;
    
    
    //NSLog(@"pageNum = %ld",pageNum);
    //通过判断滑动的速度来确定当前的页数(优化)
    pageNum = velocity.x == 0 ? pageNum :((velocity.x > 0)?pageNum + 1:pageNum - 1);
    //设置当前 pagenum 的范围(0 -- _collectionMoviesData.count-1)
    pageNum = MIN(MAX(pageNum, 0), _collectionMoviesData.count-1);
    //通过当前的页数,直接修改目标偏移量到当前页的中间就可以
    targetContentOffset ->x = pageNum * pageWidth;
    //通过 setter 方法来给属性赋值,这样话才能触发观察者方法&&&&&&&&
    self.currentPage = pageNum;
    
}




@end
