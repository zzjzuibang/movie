//
//  CinemaViewController.m
//  WXMovie
//
//  Created by mac on 15/3/2.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaModel.h"
#import "CinemaCell.h"
@interface CinemaViewController ()

@end

@implementation CinemaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //1.创建导航栏上的按钮
    [self _loadNavigationItem];
    //2.创建表视图
    [self _loadTableView];
    //3.获取影院列表数据
    [self _loadRequestData];
    
    self.title = @"影院";
}

//获取影院列表数据
- (void)_loadRequestData
{

    _cinemaDictionary = [[NSMutableDictionary alloc] init];

    //1.处理影院列表数据

    //    NSDictionary *jsonData = [WXDataService requestData:@"cinema_list.json"];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"cinema_list.json" ofType:nil];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    //[{},{},{},{},...]
    NSArray* cinemaList = [jsonData objectForKey:@"cinemaList"];

    //整理影院列表的数据
    //结构如下
    /*
     {
     “区ID1” : [影院1，影院2，影院3,…]
     “区ID2” : [影院10，影院12，影院13,…]，
     “区ID3” : [影院10，影院12，影院13,…]，
     “区ID4” : [影院10，影院12，影院13,…]，
     ...
     }
     */
    for (NSDictionary* cinemaDic in cinemaList) {
        CinemaModel* cm = [[CinemaModel alloc] init];

        [cm setValuesForKeysWithDictionary:cinemaDic];
        //此影院所在的区ID
        NSString* districtId = cm.districtId;

        //通过区ID，取得对应的影院列表
        NSMutableArray* cinemasArray = [_cinemaDictionary objectForKey:districtId];
        if (cinemasArray == nil) {
            //如果影院列表为空，则为区id创建一个新的数组
            cinemasArray = [NSMutableArray array];
            [_cinemaDictionary setObject:cinemasArray forKey:districtId];
        }

        [cinemasArray addObject:cm];
    }

    //2.处理区列表数据
    //    NSDictionary *districtDic = [WXDataService requestData:@"district_list.json"];

    NSString* filePath1 = [[NSBundle mainBundle] pathForResource:@"district_list.json" ofType:nil];
    NSData* data1 = [NSData dataWithContentsOfFile:filePath1];
    NSDictionary* districtDic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
    _districtArray = [districtDic objectForKey:@"districtList"];

    //3.刷新UI
    [_tableView reloadData];
}

#pragma mark - Load UI
//创建导航栏上的按钮
- (void)_loadNavigationItem
{

    UIButton* locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setImage:[UIImage imageNamed:@"movieLocationIcon.png"] forState:UIControlStateNormal];
    locationButton.frame = CGRectMake(0, 0, 20, 20);
    [locationButton addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:locationButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)_loadTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    _tableView.separatorColor = [UIColor darkGrayColor];
    [self.view addSubview:_tableView];
}

- (void)locationAction:(UIButton*)button
{
    NSLog(@"显示地图");
}

#pragma mark - UITableView dataSource
/*
 //区数据
 [
 {"name" : "东城区","id" : "1029"},
 {"name" : "东城区","id" : "1029"}
 ...
 ]
 
 //影院数据
 {
 “区ID” : [影院1，影院2，影院3,…]
 “区ID” : [影院10，影院12，影院13,…]，
 “区ID” : [影院10，影院12，影院13,…]，
 “区ID” : [影院10，影院12，影院13,…]，
 ...
 }
 */
//1.返回组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return _districtArray.count;
}

//2.返回每个组中单元格的个数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    //判断每个组的收起状态,如果是收起状态，则返回0个单元格
    BOOL isClose = close[section];
    if (!isClose) {
        return 0;
    }

    //获取区的字典数据
    NSDictionary* districtDic = [_districtArray objectAtIndex:section];
    //区ID
    NSString* districtId = [districtDic objectForKey:@"id"];

    //影院列表数组
    NSArray* cinemaArray = [_cinemaDictionary objectForKey:districtId];

    return cinemaArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    static NSString* identify = @"cinema-cell";

    CinemaCell* cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        //        cell = [[[CinemaCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify] autorelease];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CinemaCell" owner:self options:nil] lastObject];
    }

    //获取区的字典数据
    NSDictionary* districtDic = [_districtArray objectAtIndex:indexPath.section];
    //区ID
    NSString* districtId = [districtDic objectForKey:@"id"];

    //影院列表数组
    NSArray* cinemaArray = [_cinemaDictionary objectForKey:districtId];

    CinemaModel* cm = [cinemaArray objectAtIndex:indexPath.row];
    cell.model = cm;

    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSDictionary *district = [_districtArray objectAtIndex:section];
//    NSString *name = [district objectForKey:@"name"];
//    return name;
//}

//设置组的头视图
- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{

    NSDictionary* district = [_districtArray objectAtIndex:section];
    NSString* name = [district objectForKey:@"name"];

    UIControl* titleView = [[UIControl alloc] initWithFrame:CGRectZero];
    titleView.frame = CGRectMake(0, 0, 100, 40);
    titleView.tag = section;
    titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hotMovieBottomImage@2x.png"]];
    [titleView addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];

    UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 0, 0)];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.text = name;
    [textLabel sizeToFit];

    [titleView addSubview:textLabel];

    return titleView;
}

//设置组的头视图高度
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)sectionAction:(UIControl*)control
{
    NSInteger section = control.tag;

    //1.切换点击组的状态
    close[section] = !close[section];

    //2.刷新tableView
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:section];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

@end
