//
//  XZPayboxTextField.m
//  Paybox
//
//  Created by knight on 2018/8/9.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "XZPayboxTextField.h"

@implementation XZPayboxTextField

/** 禁止可被粘贴复制 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
