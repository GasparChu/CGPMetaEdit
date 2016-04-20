//
//  CGPMetaButton.h
//  MetaWithEdit
//
//  Created by PP－mac001 on 16/4/19.
//  Copyright © 2016年 ChuGaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGPMetaButton : UIButton

//更新frame
- (void)setupUIWithFrame:(CGRect)frame;
//是否编辑
@property (assign, nonatomic, getter = isEdit) BOOL edit;
//删除
@property (copy, nonatomic) void(^block_DeleteBlock)(CGPMetaButton *delete_Btn);
@end
