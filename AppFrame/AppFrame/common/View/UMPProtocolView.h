//
//  UMPProtocolView.h
//  UMP-Doctor
//
//  Created by LeiXiang on 2021/3/10.
//  Copyright © 2021 UMP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMPProtocolModel.h"
#import "UMPNoMenuTextView.h"
#import "Define.h"

NS_ASSUME_NONNULL_BEGIN

@interface UMPProtocolView : UIView

@property (nonatomic, strong, readonly) UMPNoMenuTextView *textView;
@property (nonatomic, strong) UMPProtocolModel *protocolModel;

///点击协议回调
@property (nonatomic, copy) LXIdBlock prorotolClick;
///box点击回调,BOOL为点击后要修改的状态
@property (nonatomic, copy) LXBOOLBlock boxClick;

@end

NS_ASSUME_NONNULL_END
