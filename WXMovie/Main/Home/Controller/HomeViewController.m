//
//  HomeViewController.m
//  WXMovieZZJ
//
//  Created by zhongzhongjun on 16/4/17.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HomeViewController.h"
#import "MovieModel.h"
#import "JSONDataService.h"
#import "MovieCell.h"
#import "PostView.h"

#define CellID @"ListTabViewCellID"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>{

    PostView *_postView; //海报视图
    UITableView *_listView; //列表视图
    NSMutableArray *_moviesData; //model 数组

}


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self _loadData];
    //创建导航栏右边的按钮
    [self _createNavigationRightItem];
    //创建海报视图
    [self _createPostView];
    //创建列表视图
    [self _createListView];
    
    //导航栏左右两边的按钮
       
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 25);
    [button setImage:[UIImage imageNamed:@"Task-Manager"] forState:UIControlStateNormal];
    //警告没影响,调用的是第三方框架中的方法(在本类中没有声明该方法)
    [button addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
 }
#pragma mark - 加载数据
- (void)_loadData{
////解析 JSON 中的数据:
////1.获取 bundle 包中 JSON 文件的路径
//    NSString *JSONPathString = [[NSBundle mainBundle]pathForResource:@"new_movie" ofType:@"json"];
////2.将对应路径中的 JSON 文件转化成二进制的文件
//    NSData *JSONData = [NSData dataWithContentsOfFile:JSONPathString];
////3.将 JSON 的二进制的文件转化成对象
//    /*
//     NSJSONReadingMutableContainers = (1UL << 0),
//     NSJSONReadingMutableLeaves = (1UL << 1),-->容器当中有可变字符串
//     NSJSONReadingAllowFragments = (1UL << 2) @"123"
//     */
//    //Data: JSON 的二进制文件  options: 转换时的选项(一般情况下选第一个)
//    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
//    //NSLog(@"dictionary = %@",dictionary);
    
    NSDictionary *dictionary = [JSONDataService loadJSONData:@"new_movie"];
    
//4.将字典转化成 model 数组
    //1>从字典中取出subjects数组
    NSArray *subjects = dictionary[@"subjects"];
    //2.forin 循环将subjects数组中的每一个电影字典取出来,将字典中有用的数据存放到单独的 model 对象
    //创建一个可变数组,这里准备存放每一个含有电影信息的 model
    _moviesData = [NSMutableArray array];
    for (NSDictionary *movieDic in subjects) {
        //创建 model 对象
        MovieModel *movieModel = [[MovieModel alloc]init];
        movieModel.rating = movieDic[@"rating"];
        movieModel.genres = movieDic[@"genres"];
        movieModel.collect_count = [movieDic[@"collect_count"] integerValue];
        movieModel.original_title = movieDic[@"original_title"];
        movieModel.title = movieDic[@"title"];
        movieModel.year = movieDic[@"year"];
        movieModel.images = movieDic[@"images"];
        // 把每一个 model 存放到可变数组中
        [_moviesData addObject:movieModel];
    }

}

#pragma mark - 创建海报视图
- (void)_createPostView{
    
    _postView = [[PostView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - TabBarHeight - NavigationBarHeight)];
    _postView.hidden = NO;
    _postView.postMoviesData = _moviesData;
    [self.view addSubview:_postView];


}
#pragma mark - 创建列表视图
- (void)_createListView{
    //创建表视图
    _listView = [[UITableView alloc]initWithFrame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - TabBarHeight - NavigationBarHeight)style:UITableViewStylePlain];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.hidden = YES;
    _listView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_listView];
    //注册单元格
    [_listView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID];

}

#pragma mark - 创建导航栏右边的按钮
- (void)_createNavigationRightItem{

//创建一个父视图
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    rightView.tag = 1000;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
//在父视图上创建两个按钮
    //创建第一个按钮,并且进行设置
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(1, 2, 48, 26);
    button1.tag = 1001;
    [button1 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button1];
    
    //一开始让第一个按钮隐藏掉
    button1.hidden = YES;
    
    //创建第二个按钮,并且进行设置
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(1, 2, 48, 26);
    button2.tag = 1002;
    [button2 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button2];
    //一开始让第二个按钮显示
    button2.hidden = NO;
    
}
#pragma mark - 导航栏右边按钮的点击事件
- (void)buttonAction:(UIButton *)button{
    
    /*
     如果把导航控制器比作一个剧院，那导航栏就相当于舞台，舞台必然是属于剧院的，所以，导航栏是导航控制器的一个属性。视图控制器（UIViewController）就相当于一个个剧团，而导航项（navigation item）就相当于每个剧团的负责人，负责与剧院的人接洽沟通。显然，导航项应该是视图控制器的一个属性。虽然导航栏和导航项都在做与导航相关的事情，但是它们的从属是不同的。
     我想，这个类比应该能解决以上的疑惑吧。导航栏相当于负责剧院舞台的布景配置，导航项则相当于协调每个在舞台上表演的演员（bar button item,title 等等），每个视图控制器的导航项可能都是不同的，可能一个右边有一个选择照片的bar button item,而另一个视图控制器的右边有两个bar button item。
     */
    //首先获取到对应的按钮和视图
    UIView *rightView = [self.navigationController.navigationBar viewWithTag:1000];
    UIButton *button1 = [self.navigationController.navigationBar viewWithTag:1001];
    UIButton *button2 = [self.navigationController.navigationBar viewWithTag:1002];
    //构造一个动画变换的变量
    UIViewAnimationOptions options = button1.hidden?UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight;
    //进行动画
    [UIView transitionWithView:rightView duration:.35 options:options animations:^{
        button1.hidden = !button1.hidden;
        button2.hidden = !button2.hidden;
    } completion:^(BOOL finished) {
        ;
    }];
    
    //进行动画
    [UIView transitionWithView:self.view duration:.35 options:options animations:^{
        _postView.hidden = !_postView.hidden;
        _listView.hidden = !_listView.hidden;
    } completion:^(BOOL finished) {
        ;
    }];

}

#pragma mark - 表视图相关的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _moviesData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    //通过 setter 方法传对应 cell 的 model(数据)
    cell.cellModel = _moviesData[indexPath.row];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;

}















@end
