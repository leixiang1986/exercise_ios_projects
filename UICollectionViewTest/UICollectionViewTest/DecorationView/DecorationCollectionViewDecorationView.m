//
//  DecorationCollectionViewDecorationView.m
//  UICollectionViewTest
//
//  Created by LeiXiang on 2021/10/1.
//  Copyright © 2021 雷祥. All rights reserved.
//

#import "DecorationCollectionViewDecorationView.h"

@implementation DecorationCollectionViewDecorationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0 );
        self.layer.shadowRadius = 10;
        self.layer.shadowOpacity = 0.4;
        
    }
    return self;
}



@end
