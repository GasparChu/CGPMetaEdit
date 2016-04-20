//
//  ViewController.m
//  MetaWithEdit
//
//  Created by PP－mac001 on 16/4/19.
//  Copyright © 2016年 ChuGaopeng. All rights reserved.
//

#import "ViewController.h"
#import "CGPMetaView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    BOOL isre;
    CGPMetaView *_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    


    NSArray *titleArr = @[@"放假客服第三方",@"大幅度发的说法",@"额外热任务二",@"需水电费的说法",@"第三个第三方第三方",@"过分的话风格化",@"让他热特让他认为",@"且稳定是",@"收到",@"你沉默许久发了就独守空房"];
    _view = [[CGPMetaView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200)];
    [_view setDragable:YES];
    for (NSString *title in titleArr) {
        [_view addButtonWithTitle:title];
    }

    [self.view addSubview:_view];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btn_Clicked:(id)sender {
    if (isre) {
        [_view setEdit:NO];
        isre = NO;
    } else {
        [_view setEdit:YES];
        isre = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
