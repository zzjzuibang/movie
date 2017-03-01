//
//  TopViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "TopViewController.h"
#import "JSONDataService.h"
#import "TopModel.h"
#import "TopCell.h"
#define TopCellID @"topCellID"
#import "CommonViewController.h"

@interface TopViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{

    NSMutableArray *_topDataModels;

}

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self _loadData];
    //创建集合视图
    [self _createCollectionView];

}
#pragma mark - 加载数据
- (void)_loadData{
    // 解析 JSON 文件(出来的对象-->字典)
    NSDictionary *topDic = [JSONDataService loadJSONData:@"top250"];
    NSArray *subjects = topDic[@"subjects"];
    _topDataModels = [NSMutableArray array];//实例化 model 数组
    for (NSDictionary *dic in subjects) {
        TopModel *model = [[TopModel alloc]init];
//        model.title = dic[@"title"];
//        model.rating = dic[@"rating"];
//        model.images = dic[@"images"];
        //记住:王八的臀部--->规定
        //通过这个方法可以将字典中的对应 Model 中属性的值取出来,并且进行赋值
        [model setValuesForKeysWithDictionary:dic];
        [_topDataModels addObject:model];

    }
}
#pragma mark - 创建集合视图
- (void)_createCollectionView{
    
    //1.创建布局对象
    UICollectionViewFlowLayout *topFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    float width = (kScreenWidth - 10 * 4)/3;
    topFlowLayout.itemSize = CGSizeMake(width, width + 50);
    //2.创建集合视图对象
    UICollectionView *topCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight - TabBarHeight) collectionViewLayout:topFlowLayout];
    [self.view addSubview:topCollectionView];
    
    //3.设置代理
    topCollectionView.dataSource = self;
    topCollectionView.delegate = self;

    //4.注册单元格
    [topCollectionView registerClass:[TopCell class] forCellWithReuseIdentifier:TopCellID];


}
#pragma mark - 集合视图的相关代理方法
//单元格数量
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _topDataModels.count;

}
//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TopCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.topCellModel = _topDataModels[indexPath.item];
    
    return cell;


}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//选中 Item 的时候调用这个方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建视图控制器
    CommonViewController *commonViewController = [[CommonViewController alloc]init];
    //push
    [self.navigationController pushViewController:commonViewController animated:YES];

}


@end
