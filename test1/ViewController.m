//
//  ViewController.m
//  test1
//
//  Created by qinlun on 2018/5/23.
//  Copyright © 2018年 qinlun. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>


@interface ViewController () <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (weak, nonatomic) IBOutlet UIView *testView;

/*
 * 用于显示web的视图
 */
@property (strong, nonatomic)  WKWebView *webView;
//webView的配置
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
//设置加载进度条
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, copy) NSString *urlStr;

@end

@implementation ViewController

- (WKWebViewConfiguration *)wkConfig {
    if (!_wkConfig) {
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        _wkConfig.allowsInlineMediaPlayback = YES;
    }
    return _wkConfig;
}


- (WKWebView *)webView {
    if (_webView == nil) {
        // js配置
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        
        // WKWebView的配置
        self.wkConfig.userContentController = userContentController;
        
        // 显示WKWebView
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 400, 500) configuration:self.wkConfig];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self; // 设置WKUIDelegate代理
        _webView.opaque = NO;
        /*! 关闭多点触控 */
        _webView.multipleTouchEnabled = YES;
    }
    return _webView;
}


- (void)loadView{
    [super loadView];
    
    NSLog(@"创建试图loadView");
    
    
    //1.布局UI
    [self prepareUI];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"--------------允许页面跳转-------------------");
  
}


#pragma mark -- <布局UI界面>
- (void)prepareUI{
    
    [self.testView layer].masksToBounds = NO;
    [self.testView layer].shadowPath = [UIBezierPath bezierPathWithRect:self.testView.bounds].CGPath;
    [[self.testView layer] setShadowOffset:CGSizeMake(0, 2.0)];
    [[self.testView layer] setShadowRadius:2.0];
    [[self.testView layer] setShadowOpacity:0.8];
    [[self.testView layer] setShadowColor:[UIColor redColor].CGColor];
    
    [self.view addSubview:self.webView];
    
    self.urlStr = @"https://www.baidu.com/";
    
    [self loadData];
}

- (void)loadData{
    //1.URL地址
    [self.webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0]];
}

#pragma mark -- <WKNavigationDelegate>
//页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    //允许页面跳转
    NSLog(@"允许页面跳转:%@",navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (IBAction)buttonReload:(UIButton *)sender {
    
   
    self.urlStr = @"https://www.baidu.com/";
    
    [self loadData];
}

@end
