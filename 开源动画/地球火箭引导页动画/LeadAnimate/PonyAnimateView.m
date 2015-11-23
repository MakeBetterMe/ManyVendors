//
//  PonyAnimateView.m
//  LeadAnimate
//
//  Created by Pony on 15/11/23.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "PonyAnimateView.h"
#import "PonyEarthView.h"
@interface PonyAnimateView ()
{
    CGFloat _bigCloudX;
    CGFloat _smallCloudX;
    CGFloat _bigMoveX; /**<x轴上每次移动的距离咯*/
    CGFloat _smallMoveX;
}
@property (nonatomic,strong) UIImageView *bigCloudImageView;
@property (nonatomic,strong) UIImageView *smallCloudImageView;
@property (nonatomic,strong) UIImage *bigImage;
@property (nonatomic,strong) UIImage *smallImage;
@end


@implementation PonyAnimateView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self animateConfig];
    }
    return self;
}
#pragma mark Lazy Loading
- (UIImageView *)bigCloudImageView{
    if (_bigCloudImageView == nil) {
        _bigCloudImageView = [[UIImageView alloc]init];
        _bigImage = [UIImage imageNamed:@"ream"];
        _bigCloudImageView.image = _bigImage;
    }
    return _bigCloudImageView;
}

- (UIImageView *)smallCloudImageView{
    if (_smallCloudImageView == nil) {
        _smallCloudImageView = [[UIImageView alloc]init];
        _smallImage = [UIImage imageNamed:@"yun"];
        _smallCloudImageView.image = _smallImage;
    }
    return _smallCloudImageView;
}



#pragma mark 配置参数
- (void)configParam:(NSDictionary *)param{
    
}



- (void)animateConfig{
    self.backgroundColor = [UIColor blueColor];
    _bigMoveX = 1.0;
    _smallMoveX = 0.7;
    
    _bigCloudX = [UIScreen mainScreen].bounds.size.width;
    _smallCloudX  = [UIScreen mainScreen].bounds.size.width;
    [self addSubview:self.bigCloudImageView];
    [self addSubview:self.smallCloudImageView];
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    PonyEarthView * ainmeView =[[PonyEarthView alloc]initWithFrame:self.bounds];
    [self addSubview:ainmeView];
}


- (void)drawRect:(CGRect)rect{
    _bigCloudX = _bigCloudX - _bigMoveX;
    if (_bigCloudX <= -150) {
        _bigCloudX = [UIScreen mainScreen].bounds.size.width;
    }
    self.bigCloudImageView.frame = CGRectMake(_bigCloudX,20,_bigImage.size.width,_bigImage.size.height);
    
    //小云
    _smallCloudX -= _smallMoveX;
    if (_smallCloudX <= -50) {
        _smallCloudX = [UIScreen mainScreen].bounds.size.width;
    }
    self.smallCloudImageView.frame = CGRectMake(_smallCloudX, 20, _smallImage.size.width, _smallImage.size.height);
    
}




@end
