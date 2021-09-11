//
//  WKWebViewController.h
//  JsCallOc
//
//  Created by mac on 2018/1/28.
//  Copyright © 2018年 leixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXScriptMessageHandler.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController : UIViewController
@property (nonatomic,strong, readonly) WKWebView *webView;

- (instancetype)initWithUrlStr:(NSString *)urlStr;
- (instancetype)initWithFilePath:(NSString *)filePath;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (void)addJsMessageHandler:(id<LXScriptMessageHandlerDelegate>)handler;
@end
