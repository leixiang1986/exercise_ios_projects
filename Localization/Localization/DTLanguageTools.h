//
//  DTLanguageTools.h
//  powercontrol
//
//  Created by leixiang on 2018/6/14.
//  Copyright © 2018年 datangtiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,DTLanguageType) {
    DTLanguageType_en,
    DTLanguageType_zh_Hans
};

@interface DTLanguageTools : NSObject
@property (nonatomic, assign) DTLanguageType languageType;

+ (instancetype)shareManager;



@end
