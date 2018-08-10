//
//  UIView+Extensions.h
//  pal
//
//  Created by feel on 2017/11/25.
//  Copyright © 2017年 aihuoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)
/** x轴水平位置 */
@property (nonatomic,assign) CGFloat x;
/** y轴垂直位置 */
@property (nonatomic,assign) CGFloat y;
/** 宽 */
@property (nonatomic,assign) CGFloat width;
/** 高 */
@property (nonatomic,assign) CGFloat height;
/** 中心点 - x */
@property (nonatomic,assign) CGFloat centerX;
/** 中心点 - y */
@property (nonatomic,assign) CGFloat centerY;
/** 大小 - size */
@property (nonatomic,assign) CGSize size;
/** x轴的最大值
    (width + x)
 */
@property (nonatomic,assign) CGFloat maxX;
/** y轴的最大值
    (height + y)
 */
@property (nonatomic,assign) CGFloat maxY;
/** x轴的最小值
 x
 */
@property (nonatomic,assign) CGFloat minX;
/** y轴的最小值
 y
 */
@property (nonatomic,assign) CGFloat minY;
/** 中心点 x
 */
@property (nonatomic,assign) CGFloat midX;
/** 中心点 y
 */
@property (nonatomic,assign) CGFloat midY;
@end
