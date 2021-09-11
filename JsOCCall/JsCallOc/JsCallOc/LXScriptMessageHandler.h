//
//  LXScriptMessageHandler.h
//  JsCallOc
//
//  Created by LeiXiang on 2021/8/25.
//  Copyright © 2021 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "LXJSMessageModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol LXScriptMessageHandlerDelegate <WKScriptMessageHandler>
@required
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) WKWebView *webView;
@end


typedef void(^LXJSMsgHandlerCallback)(id para);

@interface LXScriptMessageHandler : NSObject<LXScriptMessageHandlerDelegate>
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) LXJSMsgHandlerCallback callback;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) WKWebView *webView;

- (instancetype)initWithHandlerName:(NSString *)name callback:(LXJSMsgHandlerCallback)callback;
- (instancetype)initWithHandlerName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
