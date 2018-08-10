//
//  XZPayboxViewController.m
//  Paybox
//
//  Created by knight on 2018/8/9.
//  Copyright © 2018年 developer. All rights reserved.
//

#define KSCREEN_W [UIScreen mainScreen].bounds.size.width
#define KSCREEN_H [UIScreen mainScreen].bounds.size.height
#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height 45  //每一个输入框的高度

#define motif_grayColor [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00]// [UIColor darkGrayColor]

#import "XZPayboxViewController.h"
#import "XZPayboxTextField.h"

@interface XZPayboxViewController ()<UITextFieldDelegate>
/** 密码输入框 */
@property (nonatomic,strong) XZPayboxTextField *pwdTF;
/** 存放点 */
@property (nonatomic,strong) NSMutableArray *dotArray;
@end

@implementation XZPayboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"安全设置";
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    [self.view addSubview:self.pwdTF];
    //页面出现时让键盘弹出
    [self.pwdTF becomeFirstResponder];
    [self initPwdTextField];
    
    // 监听键盘
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark ====== 监听键盘
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat _keyY = endKeyboardRect.origin.y;
    
}
- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = (KSCREEN_W - 32) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pwdTF.frame) + (i + 1) * width, CGRectGetMinY(self.pwdTF.frame), 1, K_Field_Height)];
        lineView.backgroundColor = motif_grayColor ;
        [self.view addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pwdTF.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.pwdTF.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //预先隐藏
        [self.view addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
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
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  清除密码
 */
- (void)clearUpPassword
{
    self.pwdTF.text = @"";
    [self textFieldDidChange:self.pwdTF];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self clearUpPassword];
}
/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(XZPayboxTextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    // 123313
    // 长度为几, 就显示几个
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        if ([textField.text isEqualToString:@"666999"]) {
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"输入成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }else{
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }
        [self clearUpPassword];
        NSLog(@"输入完毕");
    }
}

#pragma mark - 懒加载 init
- (XZPayboxTextField *)pwdTF
{
    if (!_pwdTF) {
        _pwdTF = [[XZPayboxTextField alloc] initWithFrame:CGRectMake(16, 100, KSCREEN_W - 32, K_Field_Height)];
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
    }
    return _pwdTF;
}


@end
