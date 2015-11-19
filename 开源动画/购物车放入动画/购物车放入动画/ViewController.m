//
//  ViewController.m
//  购物车放入动画
//
//  Created by Pony on 15/11/19.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, assign) CGRect cellButtonFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    return cell;
}

- (IBAction)btnCellClick:(UIButton *)sender {
    NSLog(@"按钮点击");
    CGRect btnFrame = sender.frame;
    TableViewCell *cell = (TableViewCell *)sender.superview;
    //按钮映射到self.view上的坐标
    CGRect rect = [cell convertRect:btnFrame toView:cell.superview.superview];
    NSLog(@"%@",NSStringFromCGRect(rect));
    _cellButtonFrame = rect;
    
    //这个不方便咯，用上面映射的那个
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    CGRect cellInTableViewRect = [self.tableView rectForRowAtIndexPath:indexPath];
//    CGRect superViewRect = [self.tableView convertRect:cellInTableViewRect toView:self.tableView.superview];
    [self startAnimation];
}

- (void)startAnimation{
    self.layer = [CALayer layer];
    self.layer.contents = (__bridge id)([UIImage imageNamed:@"test01.jpg"].CGImage);
    self.layer.masksToBounds = YES;
    self.layer.bounds = CGRectMake(0, 0, 30, 30);
    self.layer.cornerRadius = 15;
    self.layer.position = CGPointMake(50, 150);
    [self.view.layer addSublayer:self.layer];
    
    
    self.path = [UIBezierPath bezierPath];
    CGFloat centerX = _cellButtonFrame.origin.x + _cellButtonFrame.size.width - _cellButtonFrame.size.width/2;
    CGFloat centerY = _cellButtonFrame.origin.y + _cellButtonFrame.size.height - _cellButtonFrame.size.height/2;
    [self.path moveToPoint:CGPointMake(centerX,centerY)];
    
    /**
     * 
     画二元曲线，一般和moveToPoint配合使用
     addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
     参数：
     endPoint:曲线的终点
     controlPoint:画曲线的基准点
     */
    [self.path addQuadCurveToPoint:self.car.center controlPoint:self.view.center];
    
    [self groupAnimation];
}

- (void)groupAnimation{
    CAKeyframeAnimation *keyAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimate.path = self.path.CGPath;
    //转动
    keyAnimate.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *basicAnimate = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimate.fromValue = @(0);
    basicAnimate.duration = 0.5;
    basicAnimate.toValue = @(1);
    basicAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
//    CAKeyframeAnimation *keyAnimate2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//    NSValue *value1 = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(0, 0)];
//    NSValue *value2 = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(5, 5)];
//    NSValue *value3 = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(0, 0)];
//    keyAnimate2.duration = 1;
//    keyAnimate2.keyTimes = @[@(0),@(0.5),@(1)];
//    
//    keyAnimate.values = @[value1,value2,value3];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    group.animations = @[keyAnimate,basicAnimate];
    [self.layer addAnimation:group forKey:@"group"];
    [self performSelector:@selector(removeLayer) withObject:nil afterDelay:1];
}

- (void)removeLayer{
    [self.layer removeFromSuperlayer];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (anim == [self.layer animationForKey:@"group"]) {
        self.layer.transform = CATransform3DMakeScale(0, 0, 1);
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        ani.fromValue = [NSNumber numberWithFloat:-5];
        ani.toValue = [NSNumber numberWithFloat:5];
        //动画结束时是否执行逆动画
        ani.autoreverses = YES;
        ani.duration = 0.25;
        ani.autoreverses = YES;
        [self.car.layer addAnimation:ani forKey:@"nil"];
    }
}



@end
