//
//  XZPayboxPopupView.m
//  Paybox
//
//  Created by knight on 2018/8/9.
//  Copyright © 2018年 developer. All rights reserved.
//
#define KSCREEN_W [UIScreen mainScreen].bounds.size.width
#define KSCREEN_H [UIScreen mainScreen].bounds.size.height
#define kDotSize CGSizeMake ((KScaleW *10), (KScaleW *10)) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height (KScaleW *45.f)  //每一个输入框的高度
#define topSpace (KScaleW *40.0f)

#define motif_whiteColor      [UIColor whiteColor];
#define motif_grayColor       [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00] // [UIColor darkGrayColor]


#import "XZPayboxPopupView.h"
#import "XZPayboxTextField.h"
#import "UIView+Extensions.h"
#import "XZFitwithHeader.h"

@interface XZPayboxPopupView ()<UITextFieldDelegate>
/** 底层父视图载体 */
@property (nonatomic,strong) UIView *parentView;


/** 顶部view */
@property (nonatomic,strong) UIView *topView;
/** 返回上一级 */
@property (nonatomic,strong) UIButton *btnBack;
/** 忘记密码 */
@property (nonatomic,strong) UIButton *btnForgetPwd;
/** 分割线 */
@property (nonatomic,strong) UIView *splitLine;

/** 密码输入框 */
@property (nonatomic,strong) XZPayboxTextField *pwdTF;
/** 存放点 */
@property (nonatomic,strong) NSMutableArray *dotArray;
@end

@implementation XZPayboxPopupView

+ (XZPayboxPopupView *)initXZPayboxPopupView:(CGRect)rect delegate:(id<PayboxPopUpViewDelegate>)delegateVC parent:(UIView *)parent
{
    XZPayboxPopupView * vv = [[XZPayboxPopupView alloc]initWithFrame:rect];
    vv.delegate = delegateVC;
    [parent addSubview:vv];
    return vv;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = motif_whiteColor
    
        [self parentView];
        [self topView];
        [self btnBack];
        [self btnForgetPwd];
        [self splitLine];
        
        [self pwdTF];
        [self initPwdTextField];
    }
    return self;
}

#warning 大小从这里面设置, 位置就乱了 ↓
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    _parentView.frame = CGRectMake(0, 0, KSCREEN_W, CGRectGetHeight(self.frame));
//
//    _topView.frame = CGRectMake(0, 0, KSCREEN_W, topSpace);
//
//
//    CGSize sizeB = [self setupStringSize:@"←返回" font:15.f];
//    _btnBack.frame = CGRectMake(0, 0, 100, sizeB.height);
//    _btnBack.centerY = _topView.centerY;
//    [_btnBack.titleLabel sizeToFit];
//
//    CGSize sizeF = [self setupStringSize:@"忘记密码" font:15.f];
//    _btnForgetPwd.frame = CGRectMake(0, 0, 100, sizeF.height);
//    _btnForgetPwd.x = KSCREEN_W - 100 - 10 ;
//    _btnForgetPwd.centerY = _topView.centerY;
//    [_btnForgetPwd.titleLabel sizeToFit];
//
//    _splitLine.frame = CGRectMake(0, topSpace - 1, KSCREEN_W, 1);
//
//    _pwdTF.frame = CGRectMake(16, _topView.maxY + 15, KSCREEN_W - 32, K_Field_Height);
//}

#pragma mark - init
- (UIView *)parentView
{
    if (!_parentView) {
        _parentView = [[UIView alloc]init];
        _parentView.frame = CGRectMake(0, 0, KSCREEN_W, CGRectGetHeight(self.frame));
        _parentView.backgroundColor = motif_whiteColor
        [self addSubview:_parentView];
    }
    return _parentView;
}
-(UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.frame = CGRectMake(0, 0, KSCREEN_W, topSpace);
        _topView.backgroundColor = motif_whiteColor
        [self.parentView addSubview:_topView];
    }
    return _topView;
}
-(UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize sizeB = [self setupStringSize:@"←返回" font:KScaleW *15.f];
        _btnBack.frame = CGRectMake(0, 0, 100, sizeB.height);
        _btnBack.centerY = _topView.centerY;
        [_btnBack.titleLabel sizeToFit];
        [_btnBack setTitle:@"←back" forState:UIControlStateNormal];
        [_btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnBack.titleLabel.font = [UIFont systemFontOfSize:KScaleW * 16.f];
        [self.topView addSubview:_btnBack];
        _btnBack.tag = 9090 + 1;
        [_btnBack addTarget:self action:@selector(clickEventPay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}
-(UIButton *)btnForgetPwd{
    if (!_btnForgetPwd) {
        _btnForgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize sizeF = [self setupStringSize:@"忘记密码" font:15.f];
        _btnForgetPwd.frame = CGRectMake(0, 0, (KScaleW *100), sizeF.height);
        _btnForgetPwd.x = KSCREEN_W - (KScaleW *100) - 10 ;
        _btnForgetPwd.centerY = _topView.centerY;
        [_btnForgetPwd.titleLabel sizeToFit];
        [_btnForgetPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_btnForgetPwd setTitleColor:[UIColor colorWithRed:0.35 green:0.82 blue:0.99 alpha:1.00] forState:UIControlStateNormal];
        _btnForgetPwd.titleLabel.font = [UIFont systemFontOfSize:KScaleW *16.f];
        [self.topView addSubview:_btnForgetPwd];
        _btnForgetPwd.tag = 9090 + 2;
        [_btnForgetPwd addTarget:self action:@selector(clickEventPay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnForgetPwd;
}
- (UIView *)splitLine{
    if (!_splitLine) {
        _splitLine = [[UIView alloc]init];
        _splitLine.frame = CGRectMake(0, topSpace - 1, KSCREEN_W, 1);
        
        _splitLine.backgroundColor = motif_grayColor;
        [self.topView addSubview:_splitLine];
    }
    return _splitLine;
}


- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = (KSCREEN_W - 32) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pwdTF.frame) + (i + 1) * width, CGRectGetMinY(self.pwdTF.frame), 1, K_Field_Height)];
        lineView.backgroundColor = motif_grayColor ;
        [self.parentView addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pwdTF.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.pwdTF.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //预先隐藏
        [self.parentView addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        //NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

// 密码输入框
- (XZPayboxTextField *)pwdTF
{
    if (!_pwdTF) {
        _pwdTF = [[XZPayboxTextField alloc] init];
        _pwdTF.frame = CGRectMake(16, _topView.maxY + 15, KSCREEN_W - 32, K_Field_Height);

        _pwdTF.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _pwdTF.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _pwdTF.tintColor = [UIColor whiteColor];
        _pwdTF.delegate = self;
        _pwdTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _pwdTF.keyboardType = UIKeyboardTypeNumberPad;
        _pwdTF.layer.borderColor = [motif_grayColor CGColor];
        _pwdTF.layer.borderWidth = 1;
        [_pwdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.parentView addSubview:_pwdTF];
        _pwdTextF = _pwdTF;
    }
    return _pwdTF;
}

/** 重置显示的点 */
- (void)textFieldDidChange:(XZPayboxTextField *)textField
{
    // 全先隐藏
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    // 123313
    // 长度为几, 就显示几个
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    
    // 够六位后...
    if (textField.text.length == kDotCount) {
        // 只有正确的的密码才会发出去 密码信息
        [[NSNotificationCenter defaultCenter] postNotificationName:@"payPwdInfo" object:textField.text];
        
        if ([textField.text isEqualToString:@"666999"]) {
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"输入成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }else{
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }
        [self clearUpPassword];
    }
    
}

/** 清除密码 */
- (void)clearUpPassword
{
    self.pwdTF.text = @"";
    [self textFieldDidChange:self.pwdTF];
}

#pragma mark - 按钮方法
- (void)clickEventPay:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(paybox:)]) {
        [_delegate paybox:button.tag - 9090];
    }
}

- (CGSize)setupStringSize:(NSString *)string font:(CGFloat)font
{
    CGSize sizeFIrst = CGSizeMake(KSCREEN_W, MAXFLOAT);
    CGSize sizeFinally = [string boundingRectWithSize:sizeFIrst options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return sizeFinally;
}
@end
