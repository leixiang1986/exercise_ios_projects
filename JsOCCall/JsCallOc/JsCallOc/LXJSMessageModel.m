//
//  LXJSMessageModel.m
//  JsCallOc
//
//  Created by LeiXiang on 2021/9/11.
//  Copyright © 2021 leixiang. All rights reserved.
//

#import "LXJSMessageModel.h"

@implementation LXJSMessageModel
+ (instancetype)messageModelWithBody:(NSDictionary *)body {
    LXJSMessageModel *model = [[LXJSMessageModel alloc] init];
    model.callback = body[@"callback"];
    model.method = body[@"method"];
    model.parameters = body[@"parameters"];
    return model;
}

- (NSString *)fullMethod {
    if (_method.length == 0) {
        return nil;
    }
    NSString *fullMethod = _method;
    if (![_method hasSuffix:@":"]) {
        fullMethod = [fullMethod stringByAppendingString:@":"];
    }
    if (![fullMethod hasPrefix:@"jsapi_" ]) {
        fullMethod = [@"jsapi_" stringByAppendingString:fullMethod];
    }
    
    return fullMethod;
}

- (void)callbackWithResponse:(id)res webView:(WKWebView *)webView {
    if (!self.callback) {
        return;
    }
    NSString *callback = self.callback;
    if ([res isKindOfClass:[NSString class]]) {
        callback = [NSString stringWithFormat:@"%@(%@)",callback,res];
    } else if ([res isKindOfClass:[NSDictionary class]] || [res isKindOfClass:[NSArray class]]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:res options:0 error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
        callback = [NSString stringWithFormat:@"%@(%@)",callback,str];
    }
    [webView evaluateJavaScript:callback completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"执行js回调%@:%@",callback,error == nil ? @"成功" : @"失败");
    }];
    
}
@end
