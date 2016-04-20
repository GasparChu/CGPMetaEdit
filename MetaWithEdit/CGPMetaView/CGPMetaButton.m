//
//  CGPMetaButton.m
//  MetaWithEdit
//
//  Created by PP－mac001 on 16/4/19.
//  Copyright © 2016年 ChuGaopeng. All rights reserved.
//

#import "CGPMetaButton.h"
#import "UIButton+EnlargeTouchArea.h"

@implementation CGPMetaButton
{
    UIButton *_btn_Delete;
    CABasicAnimation *_animation;
    CALayer *_layer_Mask;
}

- (void)setupUIWithFrame:(CGRect)frame
{
    self.frame = (CGRect){frame.origin, CGSizeMake(frame.size.width, frame.size.height)};
    self.backgroundColor = [UIColor clearColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (_layer_Mask == nil) {
        _layer_Mask = [CALayer layer];
        _layer_Mask.masksToBounds = YES;
        _layer_Mask.cornerRadius = 10;
        _layer_Mask.backgroundColor = [UIColor lightGrayColor].CGColor;
        _layer_Mask.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _layer_Mask.position = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self.layer insertSublayer:_layer_Mask below:self.titleLabel.layer];
    }
    
    if (_btn_Delete == nil) {
        _btn_Delete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_Delete.bounds = CGRectMake(0, 0, 15, 15);
        _btn_Delete.center = CGPointMake(0, 2);
        _btn_Delete.hidden = YES;
        [_btn_Delete setBackgroundImage:[UIImage imageNamed:@"channel_edit_delete"] forState:UIControlStateNormal];
        [_btn_Delete addTarget:self action:@selector(btn_DeleteClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_Delete];
        
        [_btn_Delete setEnlargeEdgeWithTop:10 right:20 bottom:15 left:10];
    }
}

- (void)setEdit:(BOOL)edit
{
    _edit = edit;
    if (_edit == YES) {
        _btn_Delete.hidden = NO;
        if (_animation) {
        }
    }else {
        _btn_Delete.hidden = YES;
        if (_animation) {
        }
    }
}

//删除
- (void)btn_DeleteClicked {
    self.block_DeleteBlock(self);
}

@end
