//
//  XZPayboxPopupView.h
//  Paybox
//
//  Created by knight on 2018/8/9.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZPayboxTextField.h"

@protocol PayboxPopUpViewDelegate <NSObject>
@optional
/**
 界面操作响应协议

 @param integer 按钮的tag
 */
- (void)paybox:(NSInteger)integer;
@end

@interface XZPayboxPopupView : UIView

/** 密码输入框 */
@property (nonatomic,strong) XZPayboxTextField *pwdTextF;

/** 代理 */
@property (nonatomic,weak)id< PayboxPopUpViewDelegate > delegate;


/**
 类方法初始化

 @param rect 位置大小
 @param vc 代理对象
 @param parent 父视图
 @return 实例对象
 */
+ (XZPayboxPopupView *)initXZPayboxPopupView:(CGRect)rect delegate:(UIViewController *)vc parent:(UIView *)parent;
@end
