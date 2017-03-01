//
//  NewsViewController.m
//  WXMovieZZJ
//
//  Created by zhongzhongjun on 16/4/17.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "JSONDataService.h"
#import "NewsCell.h"
#define  NewsCellID @"NewsCellID"
#import "UIImageView+WebCache.h"
#import "NewsWebViewController.h"
#import "NewsImageViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *_newsDataModels; //model 数组
    UITableView *_newsTabelView;//表视图
    UIImageView *_headImageView;//头视图上的图片

}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//加载数据
    [self _loadData];
//创建表视图
    [self _createTableView];
//下拉视图的创建
    [self _pushDownImage];
    
    
    

}

#pragma mark - 加载数据
- (void)_loadData{
    //解析 JSON 文件
    NSArray *newsList = [JSONDataService loadJSONData:@"news_list"];
    //实例化可变数组
    _newsDataModels = [NSMutableArray array];
    //遍历解析出来的数组
    for (NSDictionary * dic in newsList) {
        //将数据存放到 Model 对象中
        NewsModel *model = [[NewsModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        //将每一个 Model 对象存放在 Model 数组中
        [_newsDataModels addObject:model];
    }
}
#pragma mark - 创建表视图
- (void)_createTableView{
    //1.
    _newsTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight - TabBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:_newsTabelView];
    //2
    _newsTabelView.delegate = self;
    _newsTabelView.dataSource = self;
    _newsTabelView.backgroundColor = [UIColor clearColor];
    
    //3.注册单元格
    [_newsTabelView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NewsCellID];

}
#pragma mark - 下拉放大海报视图的创建
- (void)_pushDownImage{
    //创建头视图(不起显示的作用,用来设置头视图的初始高度)
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
    [_newsTabelView setTableHeaderView:headView];
    
    //表视图头视图上覆盖的图片
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    NewsModel *pushDownModel = _newsDataModels[0];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString: pushDownModel.image]];
    [self.view addSubview:_headImageView];

    //删除第一条 数据
    if (_newsDataModels.count > 0) {
        [_newsDataModels removeObjectAtIndex:0];
        [_newsTabelView reloadData];
    }
}
//数据源代理方法
//1.每组单元格的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _newsDataModels.count;
}
//2.创建点每个单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.newsModel = _newsDataModels[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;

}
//滑动视图正在滑动的时候一直在调用这个方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 0) {//当偏移量大于零的时候(跟着走的时候)
        //头视图上的图片也向上偏移offset距离
        _headImageView.top = -offset;
    }else if (offset < 0){//当偏移量小于零的时候(放大的时候)
     // width / height = newWidth /newHeight;
        //获取图片的新的高度
        CGFloat newHeight = 200 + ABS(offset);
        //同比例的放大图片的宽度
        CGFloat newWidth =  newHeight * (kScreenWidth / 200);
        //给图片设置新的 frame
        _headImageView.frame = CGRectMake(-(newWidth - kScreenWidth)/2, 0, newWidth, newHeight);
    }
}
//点击单元格的时候会调用这个方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = _newsDataModels[indexPath.row];
    int type = [model.type intValue];
    
    if (type == kWordType) {
        //加载拥有网页的视图控制器
        NewsWebViewController *newsWebViewController = [[NewsWebViewController alloc]init];
        //当 push 的时候隐藏标签栏
        newsWebViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsWebViewController animated:YES];
        
    } else if (type == kImageType){
        //加载拥有图片的视图控制器
        NewsImageViewController *newsImageViewController = [[NewsImageViewController alloc]init];
        //当 push 的时候隐藏标签栏
        newsImageViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsImageViewController animated:YES];
        
    } else if (type == kVideoType){
        //加载拥有图片的视图控制器
        ;
    }
    



}



@end
