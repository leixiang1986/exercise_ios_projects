//
//  WKWebViewController.m
//  JsCallOc
//
//  Created by mac on 2018/1/28.
//  Copyright © 2018年 leixiang. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "LXScriptMessageHandler.h"

@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"WKWebView 调用原生";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"百度" style:(UIBarButtonItemStyleDone) target:self action:@selector(mapClick)];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//    [userContentController addScriptMessageHandler:self name:@"removeNavigationBar"];
//    [userContentController addScriptMessageHandler:self name:@"AddNavigationBar"];//添加导航栏
    LXScriptMessageHandler *handler1 = [[LXScriptMessageHandler alloc] init];
    handler1.name = @"111";
    LXScriptMessageHandler *handler2 = [[LXScriptMessageHandler alloc] init];
    handler2.name = @"222";
    [userContentController addScriptMessageHandler:handler2 name:@"removeNavigationBar"];
    [userContentController addScriptMessageHandler:handler2 name:@"AddNavigationBar"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    config.userContentController = [[WKUserContentController alloc] init];
//    [config.userContentController addScriptMessageHandler:self name:@"app"];
//    WKPreferences *preferences = [[WKPreferences alloc] init];
//    preferences.javaScriptCanOpenWindowsAutomatically = YES;
//    config.preferences = preferences;
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:config];
//    self.webView.UIDelegate = self;
//    self.webView.navigationDelegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
//    NSString *pageSource = @"<!DOCTYPE html><html><head><title>title</title></head><body><h1>My Mobile phone</h1><p>Please enter deatails</p><form name=\"feedback\" method=\"post\" action=\"mailto:you@site.com\"><!-- From elements will go in here --></form><form name=\"inputform\"> <input type=\"button\" onClick=\"submitButton('My Test Parameter')\" value=\"submit\"> </form></body></html>";
//    [self.webView loadHTMLString:pageSource baseURL:nil];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(20, 300, 50, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(runjs) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}


- (void)runjs {
    [self.webView evaluateJavaScript:@"alert('test')" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"执行结束");
    }];
    
    [self.webView evaluateJavaScript:@"haha" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"nihao");
    }];
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)mapClick {
    NSString *path = [@"baidumap://map/geocoder?address=北京市海淀区上地信息路9号奎科科技大厦&src=ios.baidu.openAPIdemo" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path] options:@{} completionHandler:^(BOOL success) {
        NSLog(@"跳转是否成功");
    }];
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    //    URL = [NSURL URLWithString:@"mweeclient://menuOrderDetail?id=111"];
            decisionHandler(WKNavigationActionPolicyAllow);
    
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"js调用了:%@",message.name);
    
    
}






/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%@",error);
}

/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {

        

        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];

        

        completionHandler(NSURLSessionAuthChallengeUseCredential,card);

    }
}

/*! @abstract Invoked when the web view's web content process is terminated.
 @param webView The web view whose underlying web content process was terminated.
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}

/*! @abstract Invoked when the web view is establishing a network connection using a deprecated version of TLS.
 @param webView The web view initiating the connection.
 @param challenge The authentication challenge.
 @param decisionHandler The decision handler you must invoke to respond to indicate whether or not to continue with the connection establishment.
 */
- (void)webView:(WKWebView *)webView authenticationChallenge:(NSURLAuthenticationChallenge *)challenge shouldAllowDeprecatedTLS:(void (^)(BOOL))decisionHandler API_AVAILABLE(macos(11.0), ios(14.0)) {
    decisionHandler(YES);
}




@end
