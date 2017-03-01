//
//  NewsImageViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "NewsImageViewController.h"
#import "JSONDataService.h"
#import "NewsImageModel.h"
#import "ImageCell.h"
#define ImageCellID @"ImageCellID"
#import "BaseNavigationController.h"
#import "PhotoViewController.h"

@interface NewsImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{

    NSMutableArray *_newsImageModels;

}

@end

@implementation NewsImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//加载数据
    [self _loadData];
//创建集合视图
    [self _createCollectionView];
}


#pragma mark  - 加载数据
- (void)_loadData{
    NSArray *newsImageList = [JSONDataService loadJSONData:@"image_list"];
    _newsImageModels = [NSMutableArray array];
    
    for (NSDictionary *dic in newsImageList) {
        NewsImageModel *model = [[NewsImageModel alloc]init];
        model.image = dic[@"image"];
        [_newsImageModels addObject:model];
    }
}

#pragma mark - 创建集合视图
- (void)_createCollectionView{
//创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = (kScreenWidth - 5 * 10)/4;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
//创建集合视图
    UICollectionView *imageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:imageCollectionView];
    
    //设置代理
    imageCollectionView.dataSource = self;
    imageCollectionView.delegate = self;

//注册 单元格
    [imageCollectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:ImageCellID];
}

#pragma mark - 集合视图的相关代理方法
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _newsImageModels.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.cornerRadius = 10;
    cell.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.layer.borderWidth = 3;
    cell.clipsToBounds = YES;
    cell.imageModel = _newsImageModels[indexPath.item];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//模态
    //创建一个新的视图控制器,里面要展示图片
    PhotoViewController *photoViewController = [[PhotoViewController alloc]init];
    photoViewController.photoModels = _newsImageModels;
    photoViewController.seletedLocation = indexPath.item;
    //创建导航控制器(提供导航栏)
    BaseNavigationController *photoNavigationController = [[BaseNavigationController alloc]initWithRootViewController: photoViewController];
    //photoNavigationController.navigationBar.translucent = YES;
    //模态
    [self presentViewController:photoNavigationController animated:YES completion:^{
        NULL;
    }];


}


@end
