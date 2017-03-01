//
//  NewsWebViewController.m
//  WXMovie
//
//  Created by zhongzhongjun on 16/4/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "NewsWebViewController.h"
#import "JSONDataService.h"

@interface NewsWebViewController ()<UIWebViewDelegate>{

    UIActivityIndicatorView *_activityIndicatorView;
}

@end

@implementation NewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     "title" : "\"银河护卫队\"库珀配音浣熊 灭霸成反派幕后首脑",
     "content" :
     "time" : "2013-8-31 15:01:54",
     "source" : "Mtime时光网",
     "author" : "gmzyq 哈麦",
     */
    //解析数据
    NSDictionary *newsWebData = [JSONDataService loadJSONData:@"news_detail"];
    NSString *title = newsWebData[@"title"];
    NSString *content = newsWebData[@"content"];
    NSString *author = newsWebData[@"author"];
    NSString *source = newsWebData[@"source"];
    NSString *time = newsWebData[@"time"];
    //将来源和年份整合一下
    NSString *timeSource = [NSString stringWithFormat:@"年份是%@,来源是%@",time,source];
 
//这个页面显示的是一个从本地加载的网页数据
//这个 html 他的结构是本地的,里面的数据数网络的
// [NSString stringWithFormat:html 的内容,@"dfadsfadsf",@"fafdafsa",@"fasdfa"];
    
    //从本地加载 html 数据
    NSString *pathString = [[NSBundle mainBundle]pathForResource:@"news.html" ofType:nil];
    NSString *newsHtmlString = [NSString stringWithContentsOfFile:pathString encoding:NSUTF8StringEncoding error:nil];
    //newsHtmlString它代表的@"%@ %@ %@ %@",前面格式符
    //将 html 的数据(html 的结构)和 html 中需要展示的内容进行合并
    NSString *htmlString = [NSString stringWithFormat:newsHtmlString,title,content,author,timeSource];
    //创建网页视图
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight)];
    webView.scalesPageToFit = YES;//网页视图自适应
    webView.delegate = self;
    [self.view addSubview:webView];
    //网页视图加载 html 格式的字符串,并且进行显示
    [webView loadHTMLString:htmlString baseURL:nil];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc]initWithCustomView:_activityIndicatorView];
    self.navigationItem.rightBarButtonItem = activityItem;
    
//    [activityIndicatorView startAnimating];
    

}
//网页正在加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //开始旋转
    [_activityIndicatorView startAnimating];
}
//网页已经加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//结束旋转
    [_activityIndicatorView stopAnimating];

}


@end
