//
//  UMPNoMenuTextView.m
//  UMP-Doctor
//
//  Created by leixiang on 2021/3/15.
//  Copyright © 2021 UMP. All rights reserved.
//

#import "UMPNoMenuTextView.h"

@implementation UMPNoMenuTextView

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (BOOL) canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(select:) ||
        action == @selector(paste:) ||
        action == @selector(selectAll:) ||
        action == @selector(copy:) ||
        action == @selector(cut:) ||
        action == @selector(delete:)|| action == @selector(selectToHere:)) {
        if ( [UIMenuController sharedMenuController] ) {
           [UIMenuController sharedMenuController].menuVisible = NO;
        }
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

- (UITextRange *)selectedTextRange {
    return nil;
}

- (void)setSelectedTextRange:(UITextRange *)selectedTextRange {
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) {
        return [super gestureRecognizerShouldBegin:gestureRecognizer];
    }
    if ([gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]]) {
        return [super gestureRecognizerShouldBegin:gestureRecognizer];
    }
    if ( [gestureRecognizer isMemberOfClass:[UILongPressGestureRecognizer class]] && [(UILongPressGestureRecognizer *)gestureRecognizer minimumPressDuration] < 0.325) {
        return [super gestureRecognizerShouldBegin:gestureRecognizer];
    }
    [gestureRecognizer setEnabled:NO] ;
    return NO;
}

@end
