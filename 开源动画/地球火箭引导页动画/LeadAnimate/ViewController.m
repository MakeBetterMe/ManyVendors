//
//  ViewController.m
//  LeadAnimate
//
//  Created by Pony on 15/11/23.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "ViewController.h"
#import "PonyAnimateView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
}


- (void)setView{
    PonyAnimateView *anime = [[PonyAnimateView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:anime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
