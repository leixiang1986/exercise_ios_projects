//
//  UMPProtocolModel.h
//  UMP-Doctor
//
//  Created by LeiXiang on 2021/3/10.
//  Copyright © 2021 UMP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///单个协议
@interface UMPProtocolItem : NSObject
///文字大小 有默认
@property (nonatomic, assign) NSInteger fontSize;
///描述信息字体颜色，有默认
@property (nonatomic, strong) UIColor *preDesColor;
///协议文字颜色，有默认
@property (nonatomic, strong) UIColor *protocolColor;

///点击协议的回调
//@property (nonatomic, copy) UMPVoidBlock callback;
/// 协议名
@property (nonatomic, copy) NSString *name;
///带有书名号的协议名
@property (nonatomic, copy, readonly) NSString *nameWithsymbol;
///跳转链接
@property (nonatomic, copy) NSString *url;
///协议名前的描述
@property (nonatomic, copy) NSString *preDes;

- (instancetype)initWithName:(NSString *)name
                         url:(NSString *)url
                      preDes:(NSString *)preDes;
@end

///选中框的model
@interface UMPProtocolBox : NSObject
///未选中图片名，有默认
@property (nonatomic, copy) NSString *imageName;
///选中图片名，有默认
@property (nonatomic, copy) NSString *selectImageName;
///是否选中
@property (nonatomic, assign) BOOL selected;


@end

///协议模型
@interface UMPProtocolModel : NSObject
///选中框
@property (nonatomic, strong) UMPProtocolBox *box;
///协议数组
@property (nonatomic, copy) NSArray <UMPProtocolItem *>*items;

///Designed init
- (instancetype)initWithBox:(nullable UMPProtocolBox * )box
                      items:(NSArray <UMPProtocolItem *>*)items;

/// 便利初始化
/// @param hasBox 是否有选中框
/// @param select 是否选中
/// @param items 协议数组
- (instancetype)initWithBox:(BOOL)hasBox
                     select:(BOOL)select
                      items:(NSArray <UMPProtocolItem *>*)items;


@end

NS_ASSUME_NONNULL_END
