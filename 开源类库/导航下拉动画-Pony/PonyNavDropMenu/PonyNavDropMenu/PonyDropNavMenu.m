//
//  PonyDropNavMenu.m
//  PonyNavDropMenu
//
//  Created by 王云鹏 on 15/11/28.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "PonyDropNavMenu.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface PonyDropNavMenu () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    CGRect _beginFrame;
    CGRect _endFrame;
    CGFloat _horizonSpacing;
    BOOL _isOpen;
}
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *backView;

@end

@implementation PonyDropNavMenu

- (instancetype)initWithWidth:(CGFloat)width{
    self = [super init];
    if (self) {
        _itemRowCount = 1;
        _beginFrame = CGRectZero;
        _endFrame = CGRectZero;
        _itemHeight = 44;
        _showItemCount = 5;
        _horizonSpacing = 1;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return self;
}

- (void)layoutSubviews{
    [self addSubview:self.collectionView];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kWidth - (_itemRowCount * _horizonSpacing)) / _itemRowCount, _itemHeight);
}


#pragma mark Actions
- (void)show:(UINavigationController *)navc{
    self.backView.frame = CGRectMake(0, 0, kWidth, navc.view.frame.size.height);
    CGFloat height = _itemHeight * _showItemCount;
    _beginFrame = CGRectMake(0, -height ,kWidth, height);
    self.frame = _beginFrame;
    self.collectionView.frame = CGRectMake(0, 0,self.frame.size.width, self.frame.size.height);
    [self.collectionView reloadData];
    _endFrame = CGRectMake(0, navc.navigationBar.frame.size.height + navc.navigationBar.frame.origin.y, navc.view.frame.size.width, height);
    [navc.view insertSubview:self.backView belowSubview:navc.navigationBar];
    [navc.view insertSubview:self belowSubview:navc.navigationBar];
    [UIView  animateWithDuration:0.5
            delay:0.0
            usingSpringWithDamping:0.6
            initialSpringVelocity:1.0
            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
    animations:^{
        self.frame = _endFrame;
    } completion:^(BOOL finished) {

    }];
    
}

- (void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y + 10, kWidth, self.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.frame = _beginFrame;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.backView removeFromSuperview];
        }];
    }];

}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    [self dismiss];
}


#pragma mark SetterGetter

- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc]initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 0) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = self.contentDirection;
        _flowLayout.minimumInteritemSpacing = 1;
        _flowLayout.minimumLineSpacing = 1;
        _flowLayout.itemSize = CGSizeMake(kWidth/ _itemRowCount, _itemHeight);
    }
    return _flowLayout;
}

@end
