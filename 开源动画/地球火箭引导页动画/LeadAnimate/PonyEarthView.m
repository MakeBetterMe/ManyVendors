//
//  PonyEarthView.m
//  LeadAnimate
//
//  Created by Pony on 15/11/23.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "PonyEarthView.h"

#define width  [UIScreen mainScreen].bounds.size.width
#define height  [UIScreen mainScreen].bounds.size.height

@interface PonyEarthView ()
{
    NSInteger value;
    double angle;
    double angleEarth;
}

@property (nonatomic,strong) UIImageView *earthImageView;
@property (nonatomic,strong) UIImageView *huojianImageView;

@end


@implementation PonyEarthView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

#pragma mark Lazy Loading
- (UIImageView *)earthImageView{
    if (_earthImageView == nil) {
        _earthImageView = [[UIImageView alloc]init];
        _earthImageView.image=[UIImage imageNamed:@"earth"];
    }
    return _earthImageView;
}

- (UIImageView *)huojianImageView{
    if (_huojianImageView == nil) {
        _huojianImageView = [[UIImageView alloc]init];
        _huojianImageView.image = [UIImage imageNamed:@"fire2s"];
    }
    return _huojianImageView;
}

- (void)config{
    _earthSpeed = 1.0;
    _huojianSpeed = 2;
    self.earthImageView.frame = CGRectMake((width - 260)/2, 160, 260, 260);
    self.huojianImageView.frame = CGRectMake((width - 30)/2, 260, 30, 60);
    [self addSubview:self.earthImageView];
    [self addSubview:self.huojianImageView];
    self.backgroundColor = [UIColor clearColor];
    [self startHuoJianAnimate];
    [self startAnimationEarth];
}

//FIXME:这个的调用机制
/*
 1、init初始化不会触发layoutSubviews
 
 2、addSubview会触发layoutSubviews 对的
 
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化 对的
 
 4、滚动一个UIScrollView会触发layoutSubviews
 
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件 对的
 */
//- (void)layoutSubviews{
//    self.earthImageView.frame = CGRectMake(31, 160, 260, 260);
//    self.huojianImageView.frame = CGRectMake(150, 260, 30, 60);
//}


- (void)startHuoJianAnimate{
    NSString *imageName;
    if (value>=3) {
        value=1;
    }
    imageName = [NSString stringWithFormat:@"fire%lds",value];
    self.huojianImageView.image = [UIImage imageNamed:imageName];
    value++;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    self.huojianImageView.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    self.huojianImageView.layer.anchorPoint=CGPointMake(5, 0.5);
    [UIView commitAnimations];
}
-(void)endAnimation{
    angle += 5 * self.huojianSpeed;
    [self startHuoJianAnimate];
    //换图片
}

-(void) startAnimationEarth
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimationEarth)];
    self.earthImageView.transform = CGAffineTransformMakeRotation(angleEarth * (M_PI / 180.0f));
    // imageViewEarth.layer.anchorPoint=CGPointMake(2.2, 2.2);
    [UIView commitAnimations];
}
-(void)endAnimationEarth
{
    angleEarth += 5 * _earthSpeed;
    [self startAnimationEarth];
}


@end
