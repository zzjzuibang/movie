//
//  PostView.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "PostView.h"
#import "LargeCollectionView.h"
#import "LargeCollectionFlowLayout.h"
#import "SmallCollectionView.h"
#import "SmallCollectionFlowLayout.h"
#import "MovieModel.h"

@interface PostView (){
    
    LargeCollectionView *_largeCollectionView;//中间的大得海报视图
    UIImageView *_headerView; //上面的头视图
    UIControl *_maskView; //遮罩视图
    SmallCollectionView *_smallCollectionView;//小的集合视图
    UILabel *_movieTitleLabel;//电影标题
    UIImageView *_leftLight;
    UIImageView *_rightLight;
}

@end

@implementation PostView
//移除观察者
- (void)dealloc{
    [_largeCollectionView removeObserver:self forKeyPath:@"currentPage"];
    [_smallCollectionView removeObserver:self forKeyPath:@"currentPage"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //在初始化方法中创建想要的视图
        //1.创建中间的大的集合视图
        [self _createLargeCollectionView];
        //2.创建遮罩视图
        [self _createMaskView];
        //3.创建上面两个灯
        [self _createLightView];
        //4.创建头视图
        [self _createHeaderView];
        //5.添加手势
        [self _createGesture];
        //6.创建小的海报视图
        [self _createSmallCollectionView];
        //7.创建最下面的电影标题
        [self _createMovieTitleView];
        
        //给大海报视图添加观察者-->既能找到小海报也能找到大海报
        [_largeCollectionView addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew context:nil];
        //给小海报视图添加观察者-->既能找到小海报也能找到大海报
        [_smallCollectionView addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew context:nil];
	    }
    return self;
}
#pragma mark - 当观察者观察到大海报和小海报currentPage属性发生变化&&&的时候,会调用这个方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //获取到监控到的最新的属性的变化之后的值
    NSInteger index = [change[@"new"] integerValue];
    NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    //如果大海报进行滑动的时候,小海报也会跟着进行滑动,小海报滑动,大海报进行滑动,这样引起循环引用,最终造成野指针的错误
    //解决方案: 当监控到滑动的时候,先判断一下变化的属性和自身一样不,如果不一样就滑动,如果一样就不进行滑动
    //修改底部电影标题
    MovieModel *model = _postMoviesData[index];
    _movieTitleLabel.text = model.title;
    
    if ([object isKindOfClass:[LargeCollectionView class]] && _smallCollectionView.currentPage != index) {
        //让小的海报视图也跟着一起动
        [_smallCollectionView scrollToItemAtIndexPath:itemIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //手动更新最新页数的值
        _smallCollectionView.currentPage = index;
        
    } else if ([object isKindOfClass:[SmallCollectionView class]]&& _largeCollectionView.currentPage != index){
        //让大的海报视图跟着一起动
        [_largeCollectionView scrollToItemAtIndexPath:itemIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //手动更新最新页数的值
        _largeCollectionView.currentPage = index;
    }
}
#pragma mark - 创建中间的大的集合视图
- (void)_createLargeCollectionView{
    //1.创建布局对象
    LargeCollectionFlowLayout *largeFlowLayout = [[LargeCollectionFlowLayout alloc]init];
    
    //2.构造大的集合视图
    CGRect largeRect = CGRectMake(0, 50, kScreenWidth, kScreenHeight - NavigationBarHeight - TabBarHeight - kMovieFooterViewHeight - kMovieHeaderViewHeight + 50);
    _largeCollectionView = [[LargeCollectionView alloc]initWithFrame:largeRect collectionViewLayout:largeFlowLayout];
    _largeCollectionView.backgroundColor = [UIColor clearColor];
    //强调:这里不能赋值,因为这时候还没有数据
    //largeCollectionView.largeCollectionMoviesData = _postMoviesData;
    [self addSubview:_largeCollectionView];

}
#pragma mark - 创建头部视图
- (void)_createHeaderView{
    //头视图的创建
    _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -kMovieHeaderViewOffSet, kScreenWidth, kMovieHeaderViewHeight)];
    //创建,拉伸头视图图片
    UIImage *image = [UIImage imageNamed:@"indexBG_home"];
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:0 topCapHeight:4];
    _headerView.image = newImage;
    //打开用户交互
    _headerView.userInteractionEnabled = YES;
    [self addSubview:_headerView];
    
    //创建 button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((kScreenWidth - 20)/2, kMovieHeaderViewHeight - 20, 20, 20);
    button.tag = 1000;
    [button setBackgroundImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];//选中状态是我们自己去控制器
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:button];

}
#pragma mark - 创建遮罩视图
- (void)_createMaskView{
    //
    _maskView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight - TabBarHeight)];
    //设置遮罩视图的灰度
    _maskView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    _maskView.hidden = YES;
    
    [_maskView addTarget:self action:@selector(_hideHeaderView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_maskView];

}
#pragma mark - 创建手势
- (void)_createGesture{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(_showHeaderView)];
    //滑动手势的方向
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeGesture];

}
#pragma mark - 创建小的海报视图
- (void)_createSmallCollectionView{
//1.创建布局对象
    SmallCollectionFlowLayout *smallFlowLayout = [[SmallCollectionFlowLayout alloc]init];
//    smallFlowLayout.itemSize = CGSizeMake(80, kMovieHeaderViewOffSet);
//    smallFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
//2.创建小的集合视图
    _smallCollectionView = [[SmallCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kMovieHeaderViewOffSet) collectionViewLayout:smallFlowLayout];
    [_headerView addSubview:_smallCollectionView];
}
#pragma mark - 头视图上按钮的点击方法
- (void)buttonAction:(UIButton *)button{
    
    if (button.selected) {//选中的时候
        [self _hideHeaderView];//头视图隐藏

    }else{//没选中的的时候
        [self _showHeaderView];//头视图显示
    }

}
#pragma mark - 显示头视图
- (void)_showHeaderView{
    UIButton *button = [_headerView viewWithTag:1000];
    button.selected = YES;
    //遮罩视图显示
    _maskView.hidden = NO;
    //改变灯的状态
    [UIView animateWithDuration:1 animations:^{
        _leftLight.hidden = YES;
        _rightLight.hidden = YES;
    }];
    

    [UIView animateWithDuration:.4 animations:^{
        //修改头视图的位置(下拉)
        _headerView.transform = CGAffineTransformMakeTranslation(0, kMovieHeaderViewOffSet);
    }];
}
#pragma mark - 缩回头视图
- (void)_hideHeaderView{
    UIButton *button = [_headerView viewWithTag:1000];
    button.selected = NO;
    //遮罩视图的隐藏
    _maskView.hidden = YES;
    //改变灯的状态
    [UIView animateWithDuration:1 animations:^{
        _leftLight.hidden = NO;
        _rightLight.hidden = NO;
    }];
    

    [UIView animateWithDuration:.4 animations:^{
        //让头视图位置复原
        _headerView.transform = CGAffineTransformIdentity;

    }];
    
}
#pragma mark - 创建最下面的电影标题
- (void)_createMovieTitleView{

    _movieTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight - TabBarHeight - 130, kScreenWidth, 50)];
    _movieTitleLabel.textAlignment = NSTextAlignmentCenter;
    _movieTitleLabel.font = [UIFont systemFontOfSize:20];
    _movieTitleLabel.textColor = [UIColor orangeColor];
    [self addSubview:_movieTitleLabel];


}
#pragma mark - 创建上面两个灯
-(void)_createLightView{
    
    _leftLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light"]];
    _leftLight.frame = CGRectMake(10, 5, 124, 204);
    
    _rightLight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light"]];
    _rightLight.frame = CGRectMake(kScreenWidth-10-124, 5, 124, 204);
    
    [self addSubview:_leftLight];
    [self addSubview:_rightLight];
}


#pragma mark -model 数据的 setter方法
- (void)setPostMoviesData:(NSArray *)postMoviesData{
    _postMoviesData = postMoviesData;
    //将数据传递给大的集合视图
    _largeCollectionView.collectionMoviesData = _postMoviesData;
    //将数据传递给小的集合视图
    _smallCollectionView.collectionMoviesData = _postMoviesData;
    //给第一页的电影附一个值
    MovieModel *model = _postMoviesData[0];
    _movieTitleLabel.text = model.title;

}


@end
