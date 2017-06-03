//
//  KDActionSheet.m
//  ceshi
//
//  Created by mac  on 14-12-25.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import "KDActionSheet.h"
#import "KDButtonView.h"
#import "ColorMacro.h"
#import "FontMacro.h"
#import "UIView+zb_ViewCategory.h"


#define HEIGHT 44
#define GAP 10
#define ZB_animationDuration 0.3

@interface KDActionSheet ()<ZBActionProtocol, CAAnimationDelegate>


@property (nonatomic, strong) UIImageView *contentView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, weak) UIButton *coverBtn;
@property (nonatomic, strong) KDButtonView *buttonView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *labelView;

@property (nonatomic, strong) NSMutableArray *lineArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;


@end

@implementation KDActionSheet

UIWindow *_showWindow;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super init];
    if (self) {
        self.backgroundColor = ClearColor;
        
        UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coverBtn.userInteractionEnabled = YES;
        [coverBtn addTarget:self action:@selector(dismissKdActionSheet) forControlEvents:UIControlEventTouchUpInside];
        coverBtn.backgroundColor = RGBACOLORWithAlpha(0, 0, 0, 0.2);
        self.coverBtn = coverBtn;
        [self addSubview:coverBtn];
        
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.labelView];
        [self.contentView addSubview:self.buttonView];
        
        if (title != nil) {
            self.titleLable = [self labelWithTitle:title font:BoldSystemFontOfSize(18.0)];
            [self.labelView addSubview:self.titleLable];
        }
        
        if (message != nil) {
        
            self.messageLabel = [self labelWithTitle:message font:Font14];
            [self.labelView addSubview:self.messageLabel];
        
        }
        NSInteger count = self.labelView.subviews.count;
        for (int i = 0; i < count; i ++) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = RGBACOLORWithAlpha(128, 128, 128, 0.5);
            [self.labelView addSubview:lineView];
            [self.lineArray addObject:lineView];
        }
    }
    return self;
}

- (UILabel *)labelWithTitle:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.backgroundColor = ClearColor;
    return label;
}

#pragma mark 懒加载

- (NSMutableArray *)lineArray
{
    if (_lineArray == nil) {
        _lineArray = @[].mutableCopy;
    }
    return _lineArray;
}

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = @[].mutableCopy;
    }
    return _buttonArray;
}
- (KDButtonView *)buttonView
{
    if (_buttonView == nil) {
        _buttonView = [[KDButtonView alloc] init];
        _buttonView.backgroundColor = ClearColor;
        _buttonView.buttonViewDelegate = self;
    }
    return _buttonView;
}

- (UIView *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UIView alloc] init];
        _labelView.backgroundColor = ClearColor;
    }
    return _labelView;
}

- (UIImageView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIImageView alloc] init];
        _contentView.userInteractionEnabled = YES;
        _contentView.layer.cornerRadius = 5.0f;
        _contentView.layer.masksToBounds = YES;
        _contentView.backgroundColor = WhiteColor;
    }
    return _contentView;
}

- (UIWindow *)showWindow
{
    if (!_showWindow) {
        _showWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _showWindow.hidden = NO;
        _showWindow.windowLevel = UIWindowLevelAlert;
        _showWindow.backgroundColor = ClearColor;
    }
    return _showWindow;
}

#pragma mark 设置各控件的属性
- (void)setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    self.contentView.backgroundColor = backColor;
}

- (void)setTitleClolor:(UIColor *)titleClolor
{
    _titleClolor = titleClolor;
    self.titleLable.textColor = titleClolor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLable.font = titleFont;
}


- (void)setButtonTitleColor:(UIColor *)buttonTitleColor
{
    _buttonTitleColor = buttonTitleColor;
    for (UIView *view in self.buttonView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        }
    }
    
}

- (void)setMessageLabelAlignment:(NSTextAlignment)messageLabelAlignment
{
    _messageLabelAlignment = messageLabelAlignment;
    self.messageLabel.textAlignment = messageLabelAlignment;
}

- (void)setButtonTitleFont:(UIFont *)buttonTitleFont
{
    _buttonTitleFont = buttonTitleFont;
    for (UIView *view in self.buttonView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.titleLabel.font = buttonTitleFont;
        }
    }
}

- (void)setMessageFont:(UIFont *)messageFont
{
    _messageFont = messageFont;
    self.messageLabel.font = messageFont;
}

- (void)setMessageColor:(UIColor *)messageColor
{
    _messageColor = messageColor;
    self.messageLabel.textColor = messageColor;
}


- (void)addActionButtonArray:(NSArray *)actionButtonArray
{
    [self.buttonArray addObjectsFromArray:actionButtonArray];
}

- (void)addActionButton:(id)actionButton
{
    [self.buttonArray addObject:actionButton];
}

- (void)show
{
    [[self showWindow] addSubview:self];
    self.frame = [self showWindow].bounds;
    self.coverBtn.frame = self.bounds;
    
    CGFloat contentW = self.width - GAP * 4;
    CGFloat contentH = 0;
    
    
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = contentW;
    CGFloat labelH = 0;
    if (self.titleLable != nil) {
        labelH = HEIGHT;
        self.titleLable.frame = CGRectMake(0, 0, contentW, HEIGHT);
    }
    
    if (self.messageLabel != nil) {
        CGSize messageSize = [self sizeWithFont:self.messageLabel.font text:self.messageLabel.text maxSize:CGSizeMake(contentW - 4 * GAP, MAXFLOAT)];
        self.messageLabel.frame = CGRectMake(2 * GAP, CGRectGetMaxY(self.titleLable.frame), contentW - 4 * GAP, messageSize.height + GAP);
        labelH = labelH + self.messageLabel.height + GAP;
    }
    
    for (int i = 0; i < self.lineArray.count; i ++) {
        UIView *line = self.lineArray[i];
        if (i == 1 || self.lineArray.count == 1) {
            line.frame = CGRectMake(0, labelH, contentW, 0.5f);
        } else {
            line.frame = CGRectMake(0, HEIGHT, contentW, 0.5f);
        }
        
    }
    self.labelView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    self.buttonView.buttonArray = self.buttonArray;
    self.buttonView.buttonHeight = HEIGHT;
    self.buttonView.top = labelH;
    self.buttonView.left = 0;
    self.buttonView.width = contentW;
    self.buttonView.height = self.buttonArray.count == 2 ? HEIGHT : self.buttonArray.count * HEIGHT;

    
    contentH = self.labelView.height + self.buttonView.height;
    
    self.contentView.size = CGSizeMake(contentW, contentH);
    //设置中心点之前必须设置size否则中心点会和预想的不一致
    self.contentView.centerX = self.centerX;
    self.contentView.centerY = self.centerY;
    
    [self animationWithValues:@[
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]
                               ] keytimes:@[@1.0f] delegate:nil];
}

- (void)animationWithValues:(NSArray *)values keytimes:(NSArray *)keyTimes delegate:(id)delegate
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = ZB_animationDuration;
    popAnimation.repeatCount = NO;
    popAnimation.removedOnCompletion = YES;
    if (delegate) {
        popAnimation.delegate = self;
    }
    popAnimation.values = values;
    popAnimation.keyTimes = keyTimes;
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];

}
- (void)buttonDidClick
{
    [self dismissKdActionSheet];
}

- (void)dismissKdActionSheet
{
    [self animationWithValues:@[
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)]
                               ] keytimes:@[@1.0f] delegate:self];
}


#pragma mark 动画代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [self removeFromSuperview];
        _showWindow = nil;
    }
}
- (CGSize)sizeWithFont:(UIFont *)font text:(NSString *)text maxSize:(CGSize)size
{
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
}

@end
