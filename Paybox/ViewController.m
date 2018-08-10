//
//  ViewController.m
//  Paybox
//
//  Created by knight on 2018/8/9.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "ViewController.h"
#import "XZPayboxPopupView.h"
#import "XZFitwithHeader.h"

#define KSCREEN_W [UIScreen mainScreen].bounds.size.width
#define KSCREEN_H [UIScreen mainScreen].bounds.size.height
#define H(hhh) ((hhh) + (KScaleW *45) + (KScaleW *30) + (KScaleW *40))
@interface ViewController ()<PayboxPopUpViewDelegate>
{
    CGFloat _keyboardHeight ;
}
/** strong */
@property (nonatomic,strong) XZPayboxPopupView *payView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"密码输入框";
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    if (IS_IPHONE_4_OR_LESS) {
        _keyboardHeight = 200;
    }else if (IS_IPHONE_5){
        _keyboardHeight = 216;
    }else if (IS_IPHONE_6){
        _keyboardHeight = 216;
    }else if (IS_IPHONE_6P){
        _keyboardHeight = 226;
    }else if (IS_IPHONE_X){
        _keyboardHeight = 291;
    }
    
    // 初始化
   XZPayboxPopupView * payView =  [XZPayboxPopupView initXZPayboxPopupView:CGRectMake(0, KSCREEN_H, KSCREEN_W, H(_keyboardHeight)) delegate:self parent:self.view];
    self.payView = payView;
    
    UIButton *  my_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    my_Button.frame = CGRectMake(100, 100, 100, 30);
    [my_Button setTitle:@"弹 出" forState:UIControlStateNormal];
    [my_Button setTitle:@"收 回" forState:UIControlStateSelected];
    [my_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [my_Button addTarget:self action:@selector(click_button:) forControlEvents:UIControlEventTouchUpInside];
    my_Button.selected =NO;
    [self.view addSubview:my_Button];
    
    // 获取最终密码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gainPayPwdInfo:) name:@"payPwdInfo" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)onject
{
    NSDictionary *info = [onject userInfo];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat _keyY = endKeyboardRect.size.height;
    NSLog(@"键盘信息=%@\n键盘高度=%.f",info,_keyY);
}

- (void)gainPayPwdInfo:(NSNotification *)object
{
    if (object) {
        NSString * pwd = object.object;
        NSLog(@"最终支付密码==>>%@",pwd);
    }
}

- (void)click_button:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        [UIView animateWithDuration:0.35 animations:^{
            self.payView.hidden = NO;
        } completion:^(BOOL finished) {
            CGRect rect = self.payView.frame;
            rect.origin.y = KSCREEN_H - (H(_keyboardHeight)) ;
            self.payView.frame = rect;
            [self.payView.pwdTextF becomeFirstResponder];
        }];
    }else{
        [UIView animateWithDuration:0.35 animations:^{
            CGRect rect = self.payView.frame;
            rect.origin.y = KSCREEN_H ;
            self.payView.frame = rect;
            [self.payView.pwdTextF resignFirstResponder];
        } completion:^(BOOL finished) {
            self.payView.hidden = YES;
        }];
    }
}

#pragma mark -
 -(void)paybox:(NSInteger)integer
{
    switch (integer) {
        case 1:
            {
                NSLog(@"返回!!");
            }
            break;
        case 2:
        {
            NSLog(@"忘记密码!!");
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
