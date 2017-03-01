//
//  CommonViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "CommonViewController.h"
#import "JSONDataService.h"
#import "CommonModel.h"
#import "CommonTableViewCell.h"
#define CommonCellID @"CommonCellID"
#import "HeadView.h"
#import "DetailModel.h"

@interface CommonViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *_commonDataModels;//model 数组
    UITableView *_commonTableView;//表视图
    NSIndexPath *_selectedIndexPath;//选中的单元格的位置
    DetailModel *_detailModel; //头视图的 数据model(头视图只有一个)
}

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//加载数据
    [self _loadData];
//创建表视图
    [self _createTableView];
//创建头视图
    [self _creatHeadView];


}
#pragma mark - 加载数据
- (void)_loadData{
    //解析表视图的 JSON 数据
    NSDictionary *dic = [JSONDataService loadJSONData:@"movie_comment"];
    NSArray *list = dic[@"list"];
    _commonDataModels = [NSMutableArray array];
    for (NSDictionary *commonDic in list) {
        //创建 model 对象
        CommonModel *model = [[CommonModel alloc]init];
        //给model 对象的属性依次赋值
        [model setValuesForKeysWithDictionary:commonDic];
        //将每一个存放 数据的 model 对象放到数组中
        [_commonDataModels addObject:model];
    }
    
    //解析头视图的数据
    NSDictionary *headDic = [JSONDataService loadJSONData:@"movie_detail"];
    _detailModel = [[DetailModel alloc]init];
    [_detailModel setValuesForKeysWithDictionary:headDic];
    
}

#pragma mark - 创建表视图
- (void)_createTableView{
    //1.创建表视图对象
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight-TabBarHeight);
    _commonTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    [self.view addSubview:_commonTableView];
    _commonTableView.backgroundColor = [UIColor clearColor];
    _commonTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //2.设置代理
    _commonTableView.dataSource = self;
    _commonTableView.delegate = self;
    
    //3.注册单元格
    //[_commonTableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:CommonCellID];
    [_commonTableView registerNib:[UINib nibWithNibName:@"CommonTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommonCellID];


}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _commonDataModels.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommonCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.commonModel = _commonDataModels[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.刷新单元格
    //[tableView reloadData];
    //保存点击的单元格的位置
    _selectedIndexPath = indexPath;
    
    //2.点击哪个单元格,我就刷新哪个单元格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //一刷新,就会重新走单元格高度确定的方法
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonModel *model =  _commonDataModels[indexPath.row];
    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(200, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:14]
                                                                                                                        } context:nil];
    
    if (indexPath == _selectedIndexPath) {
        if (rect.size.height + 50 <= 80) {
            return 80;
        }
        //返回变高的高度
        return rect.size.height + 80;
        
    }
    return 80;
    
}

- (void)_creatHeadView{
    
    HeadView *headView = [[[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:self options:nil]firstObject];
    headView.detailModel = _detailModel;
    [_commonTableView setTableHeaderView:headView];
    
}

@end
