//
//  UMPProtocolModel.m
//  UMP-Doctor
//
//  Created by LeiXiang on 2021/3/10.
//  Copyright © 2021 UMP. All rights reserved.
//

#import "UMPProtocolModel.h"
#import "UIColor+Extension.h"

@implementation UMPProtocolItem

- (NSInteger)fontSize {
    if (_fontSize < 5) {
        _fontSize = 14;
    }
    return _fontSize;
}

- (UIColor *)preDesColor {
    if (!_preDesColor) {
        _preDesColor = [UIColor colorWithHexString:@"333333"];
    }
    return _preDesColor;
}

- (UIColor *)protocolColor {
    if (!_protocolColor) {
        _protocolColor = [UIColor colorWithHexString:@"FF0000"];
    }
    return _protocolColor;
}

- (NSString *)nameWithsymbol {
    if (_name.length) {
        return [NSString stringWithFormat:@"《%@》",_name];
    } else {
        return @"";
    }
}

- (instancetype)initWithName:(NSString *)name
                         url:(NSString *)url
                      preDes:(NSString *)preDes {
    if (self = [super init]) {
        _name = name;
        _url = url;
        _preDes = preDes;
    }
    return self;
}
@end

@implementation UMPProtocolBox

- (NSString *)imageName {
    if (!_imageName) {
        _imageName = @"auth_agree_unselect";
    }
    return _imageName;
}

- (NSString *)selectImageName {
    if (!_selectImageName) {
        _selectImageName = @"auth_agree_select";
    }
    return _selectImageName;
}

@end

@implementation UMPProtocolModel

- (instancetype)initWithBox:(nullable UMPProtocolBox * )box
                      items:(NSArray *)items {
    self = [super init];
    if (self) {
        _box = box;
        _items = items;
    }
    return self;
}

/// 便利初始化
/// @param hasBox 是否有选中框
/// @param select 是否选中
/// @param items 协议数组
- (instancetype)initWithBox:(BOOL)hasBox
                     select:(BOOL)select
                      items:(NSArray <UMPProtocolItem *>*)items; {
    UMPProtocolBox *box = nil;
    if (hasBox) {
        box = [[UMPProtocolBox alloc] init];
        box.selected = select;
    }
    return [self initWithBox:box items:items];
}


@end
