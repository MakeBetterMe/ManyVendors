//
//  ViewController.m
//  KeyBoardPopUPDemo
//
//  Created by 王云鹏 on 15/11/26.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
//@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

- (IBAction)sendButtonClick:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(boardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(boardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

//监听文字改变 换行时要更改输入框的位置
- (void)textDidChanged:(NSNotification *)notif{
    CGSize contentSize = self.inputTextView.contentSize;
    
    if (contentSize.height > 140){
        return;
    }
    self.backViewHeightConstrant.constant = 14 * 2 + contentSize.height;
    
//    CGFloat minus = 3;
//    CGRect selfFrame = self.backView.frame;
//    CGFloat selfHeight = self.mTextView.superview.frame.origin.y * 2 + contentSize.height - minus + 2 * 2;
//    CGFloat selfOriginY = selfFrame.origin.y - (selfHeight - selfFrame.size.height);
//    selfFrame.origin.y = selfOriginY;
//    selfFrame.size.height = selfHeight;
//    self.mBackView.frame = selfFrame;
//    self.mSecondaryBackView.frame =CGRectMake(10, 10, 230, selfHeight-20);
//    NSLog(@"文字改变");
}



- (void)boardShow:(NSNotification *)nf{
    NSDictionary *nfDict = [nf userInfo];
    CGRect endFrame = [nfDict[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    float duration = [nfDict[@"UIKeyboardAnimationDurationUserInfoKey"]floatValue];
    CGRect keyBoardBounds = [self.view convertRect:endFrame toView:nil];
    
//    CGRect viewFrame = self.backView.frame;
    float height = keyBoardBounds.size.height;//键盘高度
    
    // CGAffineTransformMakeTranslation 每次都是以最初位置的中心点为起始参照
    // CGAffineTransformTranslate每次都是以传入的transform为起始参照
    if (duration > 0) {
        [UIView animateWithDuration:duration delay:0 options:[nfDict[@"UIKeyboardAnimationCurveUserInfoKey"] intValue] << 16 animations:^{
            self.backView.transform = CGAffineTransformMakeTranslation(0,-height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)boardHide:(NSNotification *)nf{
    NSDictionary *nfDict = [nf userInfo];
    float duration = [nfDict[@"UIKeyboardAnimationDurationUserInfoKey"]floatValue];
    if (duration > 0 ) {
        [UIView animateWithDuration:duration delay:0 options:[nfDict[@"UIKeyboardAnimationCurveUserInfoKey"] intValue] << 16 animations:^{
            //还原所有变换
            self.backView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)sendButtonClick:(UIButton *)sender {
}
@end
