//
//  LXJSMessageModel.h
//  JsCallOc
//
//  Created by LeiXiang on 2021/9/11.
//  Copyright © 2021 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LXJSMessageModel : NSObject
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSDictionary *parameters;
@property (nonatomic, copy) NSString *callback;

///拼接参数后的方法
@property (nonatomic, copy, readonly) NSString *fullMethod;

+ (instancetype)messageModelWithBody:(NSDictionary *)body;

//回调方法
- (void)callbackWithResponse:(id)res webView:(WKWebView *)webView;
@end

NS_ASSUME_NONNULL_END
