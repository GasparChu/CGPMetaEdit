//
//  CGPMetaView.h
//  MetaWithEdit
//
//  Created by PP－mac001 on 16/4/19.
//  Copyright © 2016年 ChuGaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDuration       0.5f
@interface CGPMetaView : UIScrollView
//btn数组
@property (strong, nonatomic) NSMutableArray *mArray_Buttons;

//是否可以编辑
@property (assign, nonatomic, getter = isEdit) BOOL edit;
//是否可以拖拽
@property (assign, nonatomic, getter=isDragable) BOOL dragable;

//添加btn
- (void)addButtonWithTitle:(NSString *)title;

@end
