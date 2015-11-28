//
//  PonyDropNavMenu.h
//  PonyNavDropMenu
//
//  Created by 王云鹏 on 15/11/28.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger,ContentDirection){
//    vertical = 0,
//    horizontal = 1,
//};

@interface PonyDropNavMenu : UIView



@property (nonatomic,assign) NSInteger itemRowCount;/**<每行显示cell的数量，默认为1吧*/

@property (nonatomic,strong) NSArray *dataArr; /**<数据源数组*/

@property (nonatomic,assign) NSInteger showItemCount; /**显示的高度为多少个cell的高度*/

@property (nonatomic,assign) CGFloat itemHeight; /**<每行的高度*/

@property (nonatomic,strong) UIColor *backGroundColor;

@property (nonatomic,assign) UICollectionViewScrollDirection contentDirection;


- (instancetype)initWithWidth:(CGFloat)width;

- (void)show:(UINavigationController *)navc;

- (void)dismiss;

@end
