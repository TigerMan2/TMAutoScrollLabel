//
//  YJAutoScrollLabel.h
//  YJAutoScrollLabel
//
//  Created by edward lannister on 2018/7/18.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YJScrollDirectionType) {
    YJScrollDirectionTypeTop = 0,//向上
    YJScrollDirectionTypeDown,//向下
};

@interface YJAutoScrollLabel : UIView


/**
 定时器轮询时间
 */
@property (nonatomic, assign) NSTimeInterval time;
/**
 滚动的方向 默认是YJScrollDirectionTypeTop
 */
@property (nonatomic, assign) YJScrollDirectionType directionType;
/**
 广告文字大小
 */
@property (nonatomic, assign) CGFloat adFontSize;
/**
 广告文字颜色
 */
@property (nonatomic, strong) UIColor *adColor;
/**
 广告的行数
 */
@property (nonatomic, assign) NSInteger adNumberOfLines;
/**
 广告文本设置
 */
@property (nonatomic, assign) NSTextAlignment adTextAlignment;
/**
 广告是否可以点击 默认是NO
 */
@property (nonatomic, assign) BOOL isHaveTouchEvent;
/**
 广告文字距离左边边距
 */
@property (nonatomic, assign) CGFloat margen;
/**
 广告点击
 */
@property (nonatomic, copy) void (^adActionBlock)(NSInteger index, NSString *adStr);

/**
 重写初始化方法

 @param frame frame
 @param titles 广告文字数组
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/**
 开始滚动
 */
- (void)beginScroll;

/**
 停止滚动
 */
- (void)closeScroll;

@end
