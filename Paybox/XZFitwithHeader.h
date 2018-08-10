//
//  XZFitwithHeader.h
//  XZPageMap
//
//  Created by knight on 2018/7/27.
//  Copyright © 2018年 knight. All rights reserved.
//

#ifndef XZFitwithHeader_h
#define XZFitwithHeader_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

// 屏幕宽高
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height

//判断机型为iPad或者iPhone
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 是否为plus
#define IS_PLUS  (IS_IPHONE && SCREEN_MAX_LENGTH == 2248.)



// 是否iPhone X
#define    kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define VScaleW(w)   IS_IPAD ? ((kScreenWidth/768.0) * w) :  ((kScreenWidth/375.0) * w)
#define VScaleH(h)   IS_IPAD ? ((kScreenHeight/1024.0) * h) :  ((kScreenHeight/667.0) * h)

#define KScaleW   IS_IPAD ? (kScreenWidth/768.0) :  (kScreenWidth/375.0)
#define KScaleH   IS_IPAD ? (kScreenHeight/1024.0)  :  (kScreenHeight/667.0)


// 横屏 - 宽/高
#define HScaleW(w) (kScreenWidth/667) * w //HorizontalScreenScale
#define HScaleH(h) ((h *1.0)/(h*1.0)) * ((kScreenWidth/667) * h) //HorizontalScreenScaleH

// 导航栏(navigationbar) 高度
#define navigationbar self.navigationController.navigationBar.frame
// 状态栏(statusbar) 高度
#define statusbar [[UIApplication sharedApplication] statusBarFrame]
// 适配iPhone x 底栏高度  (49+34)
#define TabbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height >20.f ? 83.f : 49.f)
// 状态栏高度
#define    kStatusBar_Height    (kDevice_Is_iPhoneX ? 44.f : 20.f)
//导航栏 + 状态栏高度
#define    kTableView_Height    (kDevice_Is_iPhoneX ? 88.f : 64.f)
//标签栏的安全区域距离底部的距离
#define  kTabbarSafeBottomMargin        (kDevice_Is_iPhoneX ? 34.f : 0.f)


// 系统版本号
#define SYSTEMVESION [[[UIDevice currentDevice] systemVersion] floatValue]
// APP版本号
#define APP_VERSION  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]


// 系统不是iOS8.0
//system_version_greater_than_or_equal_to()
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IS_IOS8_OR_ABOVE        SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:a]


// 获取bundle里资源文件内容
#define MyBundle_Name  @"Resource"
#define MyBundle_Path       [[NSBundle mainBundle]pathForResource:MyBundle_Name ofType:@"bundle"]
#define MyBundle    [NSBundle bundleWithPath:MyBundle_Path]
#define File_Path(string)    [MyBundle pathForResource:string ofType:@""]
#define Image_Path(string)   [UIImage imageWithContentsOfFile:File_Path(string)]


// 返回image
// UIImage * img ;
// GET_XZSDK_IMAGE(img, @"12.png");
#define GET_XZSDK_IMAGE(image,name){\
NSBundle *bkBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"]]; \
NSString* path = [bkBundle pathForResource:name ofType:nil]; \
image= [UIImage imageWithContentsOfFile:path]; \
}\


#define WEAKSELF(aa)  __weak  typeof(aa)weak##aa = aa;
#endif /* XZFitwithHeader_h */
