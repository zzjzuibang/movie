//
//  LargeCollectionFlowLayout.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "LargeCollectionFlowLayout.h"

@implementation LargeCollectionFlowLayout

- (instancetype)init{
    self = [super init] ;
    if (self != nil) {
        
        self.itemSize = CGSizeMake(kScreenWidth * 0.7, kScreenHeight - NavigationBarHeight - TabBarHeight - kMovieFooterViewHeight - kMovieHeaderViewHeight);
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    }
    return self;

}
//当前范围内的bounds 发生改变的时候,让其他范围内的布局不起作用
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;

}

//放大缩小的功能

//这个方法,是布局对象的方法
//集合视图进行布局的时候进行调用(将要显示的时候就会调用)
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //声明 rect: 不是我们自己定义的,是系统已经给我们安排好了
    //NSLog(@"rect = %@",NSStringFromCGRect(rect));
    /*
     rect = {{0, 0}, {667, 667}}
     rect = {{0, 0}, {1334, 667}}
     rect = {{667, 0}, {1334, 667}}
     rect = {{1334, 0}, {1334, 667}}
     rect = {{2001, 0}, {1334, 667}}
     rect = {{2668, 0}, {1334, 667}}
     rect = {{3335, 0}, {1334, 667}}
     */
    
    //1.获取当前 collectionview内容可见的区域大小和坐标
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    //2.调用父类的方法,获取当前 rect 中这些 item 的布局属性(抽象显示当前显示区域这些 Item 的属性)
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    //保证数组中数据的安全
    NSArray *safeAttributes = [[NSArray alloc]initWithArray:attributes copyItems:YES];
    for (UICollectionViewLayoutAttributes *attribute  in safeAttributes) {
        //判断两个 rect 是否有交集(item 是否进入我系统的检测范围之内)
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            //计算当前显示区域的x 中心和监控范围内的 item 的 x 的中心之间的距离
            float distance = CGRectGetMidX(visibleRect) - attribute.center.x;
            //缩小这个数的倍数
            float discale = distance /200;
            
            if (ABS(distance) < 200) {
                float scale = 1 + 0.1 * (1 - ABS(discale));
                //CATransform3DMakeScale对空间三个方向进行放大
                attribute.transform3D = CATransform3DMakeScale(scale, scale, 1)
                ;
                attribute.zIndex = 1;//更改 z 轴的位置
            }
        }
    }
    return safeAttributes;
}



///参考:居中对齐的功能

//返回一个目标偏移量(滑动视图最终停留的位置)
/**
 *  @param proposedContentOffset 原计划偏移量
 *  @param velocity              <#velocity description#>
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
//
//    //找到屏幕的中心,取到所有的单元格,单元格的中心和屏幕的中心进行比较,找到离屏幕中心最近的单元格
//    //根据这个单元格期推算目标偏移量
//
//    //屏幕的X方向中心点
//    CGFloat xCenter = self.collectionView.bounds.size.width / 2 + proposedContentOffset.x;
//
//    //指定当前查找单元格的范围
//    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    //在指定的区域内,获取能够显示的所有单元格的属性
//    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
//
//    //定义一个单元格和屏幕中心距离最近的值
//    CGFloat minimumDistance = MAXFLOAT;//每次调用这个都会赋值一个最大浮点数
//
//    //遍历这些单元格的属性
//    for (UICollectionViewLayoutAttributes *attribute in attributes) {
//
//        //获取当前显示的每一个Item的的中心
//        CGFloat itemCenter = attribute.center.x;
//        if (ABS(xCenter - itemCenter) < ABS(minimumDistance)) {
//            //每次比较最多只有三次,三次之后minimumDistance变成最大的浮点数
//
//            //获取到最小的距离
//            minimumDistance = itemCenter - xCenter;
//        }
//    }
//    //每调用一次这个方法就确定一次目标偏移量
//    CGPoint targetContentOffset = CGPointMake(proposedContentOffset.x + minimumDistance, proposedContentOffset.y);
//
//    return targetContentOffset;
//}




@end
