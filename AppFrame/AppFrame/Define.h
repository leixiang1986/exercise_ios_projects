//
//  Define.h
//  AppFrame
//
//  Created by leixiang on 2021/3/23.
//  Copyright © 2021 admin. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define WEAKSELF(weakSelf)                  __weak __typeof(&*self)weakSelf             = self;
#define STRONGSELF(strongSelf)              __strong __typeof(&*weakSelf)strongSelf = weakSelf;

#endif /* Define_h */
