//
//  LXScriptMessageHandler.m
//  JsCallOc
//
//  Created by LeiXiang on 2021/8/25.
//  Copyright © 2021 leixiang. All rights reserved.
//

#import "LXScriptMessageHandler.h"

@implementation LXScriptMessageHandler

- (instancetype)initWithHandlerName:(NSString *)name {
    return [self initWithHandlerName:name callback:nil];
}

- (instancetype)initWithHandlerName:(NSString *)name callback:(LXJSMsgHandlerCallback)callback {
    self = [super init];
    if (self) {
        _name = name;
        _callback = callback;
    }
    return self;
}

- (void)dealJsMsgWithBody:(NSDictionary *)body {
    if (![body isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    LXJSMessageModel *model = [LXJSMessageModel messageModelWithBody:body];
    
    [self performSelectorWithMethod:model.fullMethod messageModel:model];
}

///执行方法
- (void)performSelectorWithMethod:(NSString *)method messageModel:(LXJSMessageModel *)model {
    if (method.length == 0 || model == nil) {
        return;
    }

    SEL selector = NSSelectorFromString(method);
    if (![self respondsToSelector:selector]) {
        NSLog(@"不响应方法========：%@",method);
        return;
    }
    IMP imp = [self methodForSelector:selector];
    
    void(*func)(id ,SEL,id) = (void*)imp;
    func(self,selector,model);
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (![self.name isEqualToString:message.name]) {
        return;
    }
    
    [self dealJsMsgWithBody:message.body];
    NSLog(@"LXScriptMessageHandler--%@--%@",message.name,self.name);
}





@end
