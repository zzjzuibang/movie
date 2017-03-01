//
//  PhotoViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/27.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
#define  PhotoCellID @"photoCellID"

@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_photoCollectionView;

}

@end

@implementation PhotoViewController

- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SingleTap" object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
//自定义导航栏
    [self _createNavigationBarButton];
//创建集合视图
    [self _createPhotoCollectionView];
    
//直接滑到我点击的位置上
    [self _slideToSelectedLocation];
    
//添加接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleTapAction) name:@"SingleTap" object:nil];



}
#pragma mark - 创建导航栏上的按钮
- (void)_createNavigationBarButton{
//创建按钮
    UIButton *naviButton = [UIButton buttonWithType:UIButtonTypeCustom];
    naviButton.frame = CGRectMake(0, 0, 60, 40);
    [naviButton setTitle:@"返回" forState:UIControlStateNormal];
    naviButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [naviButton addTarget:self action:@selector(returnButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//将按钮转化成UIBarButtonItem类型
    UIBarButtonItem *leftReturnItem = [[UIBarButtonItem alloc]initWithCustomView:naviButton];
    self.navigationItem.leftBarButtonItem = leftReturnItem;

}
- (void)returnButtonAction:(UIButton *)button{
//返回上一个视图控制器
    [self dismissViewControllerAnimated:YES completion:^{
        NULL;
    }];
}

#pragma mark - 接受通知后执行的方法
- (void)singleTapAction{
    
    if (self.navigationController.navigationBar.hidden) {
        //当导航栏隐藏的时候,单击显示
        [self.navigationController setNavigationBarHidden:NO animated:NO];
//        _photoCollectionView.transform = CGAffineTransformMakeTranslation(0, -NavigationBarHeight);
        _photoCollectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight);
    }else{
        //当导航栏显示的时候,单击隐藏
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
//        _photoCollectionView.transform = CGAffineTransformMakeTranslation(0, NavigationBarHeight);
        _photoCollectionView.frame = CGRectMake(0, NavigationBarHeight - 10, kScreenWidth, kScreenHeight - NavigationBarHeight);
    }
}

#pragma mark - 创建集合视图
- (void)_createPhotoCollectionView{
    //创建布局对象
    UICollectionViewFlowLayout *photoFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    photoFlowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - NavigationBarHeight - 20);
    photoFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    photoFlowLayout.minimumLineSpacing = 0;
    //创建集合视图
    _photoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight) collectionViewLayout:photoFlowLayout];
    _photoCollectionView.backgroundColor = [UIColor clearColor];
    _photoCollectionView.pagingEnabled = YES;
    [self.view addSubview:_photoCollectionView];
    //设置代理
    _photoCollectionView.dataSource = self;
    _photoCollectionView.delegate = self;
    //注册单元格
    [_photoCollectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:PhotoCellID];
    
}
#pragma mark - 滑动到我点击的那个单元格的位置
- (void)_slideToSelectedLocation{

    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForItem:_seletedLocation inSection:0];
    [_photoCollectionView scrollToItemAtIndexPath:selectedIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];

}
#pragma mark - 集合视图的相关代理方法

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _photoModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    //传值
    cell.photoModel = _photoModels[indexPath.item];
    
    return cell;
}
//在 item 已经消失的时候回调用这个方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //强转
    PhotoCell *photoCell = (PhotoCell *)cell;
    //从消失的 Item 中获取滑动视图
    UIScrollView *photoScrollView = (UIScrollView *)[photoCell.contentView viewWithTag:1000];
    //让图片恢复原比例
    [photoScrollView setZoomScale:1];

}




@end
