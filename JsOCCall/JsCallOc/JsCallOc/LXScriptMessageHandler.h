//
//  LXScriptMessageHandler.h
//  JsCallOc
//
//  Created by LeiXiang on 2021/8/25.
//  Copyright © 2021 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXScriptMessageHandler : NSObject<WKScriptMessageHandler>
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
