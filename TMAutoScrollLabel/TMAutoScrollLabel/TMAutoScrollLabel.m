//
//  TMAutoScrollLabel.m
//  TMAutoScrollLabel
//
//  Created by edward lannister on 2018/7/18.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import "TMAutoScrollLabel.h"

#define kWidth  self.bounds.size.width
#define kHeight  self.bounds.size.height

@interface TMAutoScrollLabel ()
{
    NSInteger index;
}
//广告titles
@property (nonatomic, strong) NSArray *adTitles;
//第一个label
@property (nonatomic, strong) UILabel *oneLabel;
//第二个label
@property (nonatomic, strong) UILabel *twoLabel;
 //定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TMAutoScrollLabel

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.adTitles = titles;
        self.clipsToBounds = YES;
        self.adFontSize = 16;
        self.adColor = [UIColor blackColor];
        self.time = 2.0f;
        self.adTextAlignment = NSTextAlignmentLeft;
        self.margen = 10;
        index = 0;
        
        //设置边距
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds  = YES;
        
        //第一个label
        if (!_oneLabel) {
            _oneLabel = [self createLabel];
            if (self.adTitles.count > 0) {
                _oneLabel.text = self.adTitles[0];
            }
            [self addSubview:_oneLabel];
        }
        //第二个label
        if (!_twoLabel) {
            _twoLabel = [self createLabel];
            [self addSubview:_twoLabel];
        }
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.oneLabel.frame = CGRectMake(_margen, 0, kWidth - _margen, kHeight);
    CGFloat labelY = self.directionType == TMScrollDirectionTypeTop ? kHeight : -kHeight;
    self.twoLabel.frame = CGRectMake(_margen, labelY, kWidth - _margen, kHeight);
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timeRepeat) userInfo:nil repeats:YES];
    }
    return _timer;
}
/**
 定时器循环方法
 */
- (void)timeRepeat {
    if (self.adTitles.count == 0) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    __block UILabel *currentLabel = nil;
    __block UILabel *hiddenLabel = nil;
    __weak typeof(self) weakSelf = self;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *label = obj;
            NSString *title = weakSelf.adTitles[index];
            if ([label.text isEqualToString:title]) {
                currentLabel = label;
            } else {
                hiddenLabel = label;
            }
        }
    }];
    
    if (index != self.adTitles.count - 1) {
        index ++;
    } else {
        index = 0;
    }
    hiddenLabel.text = self.adTitles[index];
    
    //动画切换
    CGFloat labelY = self.directionType == TMScrollDirectionTypeTop ? -kHeight : kHeight;
    [UIView animateWithDuration:1 animations:^{
        currentLabel.frame = CGRectMake(_margen, labelY, kWidth - _margen, kHeight);
        hiddenLabel.frame = CGRectMake(_margen, 0, kWidth - _margen, kHeight);
    } completion:^(BOOL finished) {
        currentLabel.frame = CGRectMake(_margen, -labelY, kWidth - _margen, kHeight);
    }];
}

//创建label的方法
- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = self.adNumberOfLines;
    label.textColor = self.adColor;
    label.textAlignment = self.adTextAlignment;
    label.font = [UIFont systemFontOfSize:self.adFontSize];
    return label;
}

- (void)beginScroll {
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)closeScroll {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark ------set get------
- (void)setTime:(CGFloat)time{
    _time = time;
    if (self.timer.isValid) {
        [self.timer isValid];
        self.timer = nil;
    }
}

- (void)setAdFontSize:(CGFloat)adFontSize {
    _adFontSize = adFontSize;
    self.oneLabel.font = [UIFont systemFontOfSize:_adFontSize];
    self.twoLabel.font = [UIFont systemFontOfSize:_adFontSize];
}

- (void)setAdColor:(UIColor *)adColor {
    _adColor = adColor;
    self.oneLabel.textColor = _adColor;
    self.twoLabel.textColor = _adColor;
}

- (void)setAdNumberOfLines:(NSInteger)adNumberOfLines {
    _adNumberOfLines = adNumberOfLines;
    self.oneLabel.numberOfLines = _adNumberOfLines;
    self.twoLabel.numberOfLines = _adNumberOfLines;
}

- (void)setAdTextAlignment:(NSTextAlignment)adTextAlignment {
    _adTextAlignment = adTextAlignment;
    
    self.oneLabel.textAlignment = _adTextAlignment;
    self.twoLabel.textAlignment = _adTextAlignment;
}

#pragma mark ------idHaveTouchEvent------
- (void)setIsHaveTouchEvent:(BOOL)isHaveTouchEvent {
    if (isHaveTouchEvent) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    } else {
        self.userInteractionEnabled = NO;
    }
}
- (void)clickEvent:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.adActionBlock) {
        NSString *str = self.adTitles[index];
        self.adActionBlock(index,str);
    }
}

@end
