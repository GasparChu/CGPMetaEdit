//
//  CGPMetaView.m
//  MetaWithEdit
//
//  Created by PP－mac001 on 16/4/19.
//  Copyright © 2016年 ChuGaopeng. All rights reserved.
//

#import "CGPMetaView.h"
#import "CGPMetaButton.h"

@implementation CGPMetaView
{
    CGPMetaButton *_btn_Place;
    NSMutableArray *_mArray_BtnSize;
}

- (NSMutableArray *)mArray_Buttons {
    if (_mArray_Buttons == nil) {
        _mArray_Buttons = [NSMutableArray array];
    }
    return _mArray_Buttons;
}

- (void)addButtonWithTitle:(NSString *)title {
    CGPMetaButton *btn_Meta = [CGPMetaButton buttonWithType:UIButtonTypeCustom];
    [btn_Meta setTitle:title forState:UIControlStateNormal];
    if (self.isDragable) {
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [btn_Meta addGestureRecognizer:longGesture];
    }
    btn_Meta.edit = NO;
    [self addSubview:btn_Meta];
    [self.mArray_Buttons addObject:btn_Meta];
    [self refreshView];
    
    btn_Meta.block_DeleteBlock = ^(CGPMetaButton *delete_Btn) {
        [self.mArray_Buttons removeObject:delete_Btn];
        [delete_Btn removeFromSuperview];
        [self refreshView];
    };
}

- (void)refreshView {
    
    [UIView animateWithDuration:kDuration animations:^{
        int width = 0;
        int height = 0;
        int number = 0;
        int han = 0;
        
        for (int i  = 0; i < self.mArray_Buttons.count; i++) {
            CGPMetaButton *btn_Meta = self.mArray_Buttons[i];
            
            CGSize titleSize = [btn_Meta.titleLabel.text boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;

            //自动的折行
            han = han +titleSize.width+10;
            if (han > [[UIScreen mainScreen]bounds].size.width) {
                han = 0;
                han = han + titleSize.width;
                height++;
                width = 0;
                width = width+titleSize.width;
                number = 0;
                [btn_Meta setupUIWithFrame:CGRectMake(10, 10 +40*height, titleSize.width, 30)];
            }else{
                [btn_Meta setupUIWithFrame:CGRectMake(width+10+(number*10), 10 +40*height, titleSize.width, 30)];
                width = width+titleSize.width;
            }
            number++;
            [self addSubview:btn_Meta];
            
            //根据最后一个button设置本self的frame和contentsize
            if (i == self.mArray_Buttons.count - 1) {
                CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(btn_Meta.frame) + 10);
                
                self.contentSize = size;
            }
        }
        if (self.mArray_Buttons.count == 0) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
            self.contentSize = CGSizeZero;
        }
    }];
}

- (void)setEdit:(BOOL)edit {
    _edit = edit;
    for (CGPMetaButton *btn_Meta in self.mArray_Buttons) {
        btn_Meta.edit = _edit;
    }
}

#pragma mark Gesture Action
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
    CGPMetaButton *btn_Meta = (CGPMetaButton *)sender.view;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.edit = YES;
            if (_btn_Place == nil) {
                _btn_Place = [CGPMetaButton buttonWithType:UIButtonTypeCustom];
                [_btn_Place setTitle:btn_Meta.titleLabel.text forState:UIControlStateNormal];
                _btn_Place.hidden = YES;
                
                [self.mArray_Buttons insertObject:_btn_Place atIndex:[self.mArray_Buttons indexOfObject:btn_Meta]];
                [self.mArray_Buttons removeObject:btn_Meta];
            }
            [UIView animateWithDuration:kDuration animations:^{
                btn_Meta.transform = CGAffineTransformMakeScale(1.1, 1.1);
                btn_Meta.alpha = 0.7;
            }];
            
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint newPoint = [sender locationInView:self];
            CGFloat Xdelta = newPoint.x - btn_Meta.center.x;
            CGFloat Ydelta = newPoint.y - btn_Meta.center.y;
            //            NSLog(@"xdelta is %f, ydelta is %f", Xdelta, Ydelta);
            btn_Meta.center = CGPointMake(btn_Meta.center.x + Xdelta, btn_Meta.center.y + Ydelta);
            //检测是否进入其他button区域
            NSInteger newIndex = [self indexOfButtonWithMovingButton:btn_Meta];
            if (newIndex < 0) {
                
            }else {
                if (_btn_Place == nil) {
                    _btn_Place = [CGPMetaButton buttonWithType:UIButtonTypeCustom];
                    [_btn_Place setTitle:btn_Meta.titleLabel.text forState:UIControlStateNormal];
                    _btn_Place.hidden = YES;
                    
                    [self.mArray_Buttons removeObject:btn_Meta];
                }else {
                    [self.mArray_Buttons removeObject:_btn_Place];
                }
                [self.mArray_Buttons insertObject:_btn_Place atIndex:newIndex];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (_btn_Place != nil) {
                [self.mArray_Buttons replaceObjectAtIndex:[self.mArray_Buttons indexOfObject:_btn_Place] withObject:btn_Meta];
                _btn_Place = nil;
            }
            [UIView animateWithDuration:kDuration animations:^{
                btn_Meta.transform = CGAffineTransformIdentity;
                btn_Meta.alpha = 1;
            }];
        }
            break;
        default:
            break;
    }
    [self refreshView];
}

- (NSInteger)indexOfButtonWithMovingButton:(CGPMetaButton *)movingButton
{
    for (NSInteger i = 0;i<self.mArray_Buttons.count;i++)
    {
        CGPMetaButton *button = self.mArray_Buttons[i];
        if (button != movingButton)
        {
            if (CGRectContainsPoint(button.frame, movingButton.center))
            {
                return i;
            }
        }
    }
    return -1;
}

@end
