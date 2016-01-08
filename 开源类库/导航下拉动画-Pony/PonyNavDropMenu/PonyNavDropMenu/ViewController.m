//
//  ViewController.m
//  PonyNavDropMenu
//
//  Created by 王云鹏 on 15/11/28.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "ViewController.h"
#import "PonyDropNavMenu.h"
@interface ViewController ()
{
    PonyDropNavMenu *_menu;
    BOOL isShow;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menu = [[PonyDropNavMenu alloc]initWithWidth:[UIScreen mainScreen].bounds.size.width];
    _menu.dataArr = @[@"1号线",@"2号线",@"3",@"4",@"5",@"6"];
    _menu.itemHeight = 80;
    _menu.itemRowCount = 1;
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(show)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)show{
    if (!isShow) {
        isShow = YES;
        [_menu show:self.navigationController];
    }else{
        isShow = NO;
        [_menu dismiss];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end
