//
//  LXScriptMessageHandler.m
//  JsCallOc
//
//  Created by LeiXiang on 2021/8/25.
//  Copyright © 2021 leixiang. All rights reserved.
//

#import "LXScriptMessageHandler.h"

@implementation LXScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"LXScriptMessageHandler--%@--%@",message.name,self.name);
}
@end
