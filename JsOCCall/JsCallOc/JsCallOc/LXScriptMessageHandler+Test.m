//
//  LXScriptMessageHandler+Test.m
//  JsCallOc
//
//  Created by LeiXiang on 2021/9/11.
//  Copyright © 2021 leixiang. All rights reserved.
//

#import "LXScriptMessageHandler+Test.h"
#import "WKWebViewController.h"

@implementation LXScriptMessageHandler (Test)
- (void)jsapi_getUserInfo:(LXJSMessageModel *)model {
    NSLog(@"jsapi_getUserInfo");
    NSDictionary *dic = @{@"name":@"leixiang",@"phone":@"1314520"};
    [model callbackWithResponse:dic webView:self.webView];
}

- (void)jsapi_newPage:(LXJSMessageModel *)model {
    NSLog(@"jsapi_newPage");
    NSString *url = model.parameters[@"url"];
    WKWebViewController *vc = [[WKWebViewController alloc] initWithUrlStr:url];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
