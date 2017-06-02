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

@interface KDActionSheet ()<ZBActionProtocol>


@property (nonatomic, strong) UIImageView *contentView;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UIButton *coverBtn;
@property (nonatomic, strong) KDButtonView *buttonView;
@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, strong) UIView *labelView;

@property (nonatomic, strong) NSMutableArray *lineArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation KDActionSheet

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super init];
    if (self) {
        self.backgroundColor = RedColor;
        
        UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coverBtn.userInteractionEnabled = NO;
        [coverBtn addTarget:self action:@selector(dismissKdActionSheet) forControlEvents:UIControlEventTouchUpInside];
        coverBtn.backgroundColor = BlackColor;
        coverBtn.alpha = 0.5;
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
        
            self.messageLabel = [self labelWithTitle:message font:SystemFontOfSize(16.0f)];
            [self.labelView addSubview:self.messageLabel];
        
        }
        NSInteger count = self.labelView.subviews.count;
        for (int i = 0; i < count; i ++) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor colorWithRed:128 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
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
        _contentView.layer.cornerRadius = 3.0f;
        _contentView.layer.masksToBounds = YES;
        _contentView.backgroundColor = WhiteColor;
    }
    return _contentView;
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


- (void)showInView:(UIView *)view
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.frame = keyWindow.bounds;
    self.coverBtn.frame = self.bounds;
    
    CGFloat contentX = GAP;
    CGFloat contentY = self.height;
    CGFloat contentW = self.width - GAP * 2;
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
        CGSize messageSize = [self sizeWithFont:self.messageLabel.font text:self.messageLabel.text maxSize:CGSizeMake(contentW - 6 * GAP, MAXFLOAT)];
        self.messageLabel.frame = CGRectMake(3 * GAP, CGRectGetMaxY(self.titleLable.frame), contentW - 6 * GAP, messageSize.height + GAP);
        labelH = labelH + self.messageLabel.height + GAP;
    }
    

    self.labelView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    self.buttonView.buttonArray = self.buttonArray;
    self.buttonView.buttonHeight = HEIGHT;
    
    contentH = self.labelView.height + self.buttonView.height;
    
    self.contentView.top = contentY;
    self.contentView.left = contentX;
    self.contentView.height = contentH;
    self.contentView.width = contentW;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.contentView.top = self.height - contentH - 2 * GAP;
        
    } completion:nil];

}


- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.frame = keyWindow.bounds;
    self.coverBtn.frame = self.bounds;
    
    
    CGFloat contentCenterX = 0;
    CGFloat contentCenterY = 0;
    CGFloat contentW = self.width - GAP * 2;
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
        CGSize messageSize = [self sizeWithFont:self.messageLabel.font text:self.messageLabel.text maxSize:CGSizeMake(contentW - 6 * GAP, MAXFLOAT)];
        self.messageLabel.frame = CGRectMake(3 * GAP, CGRectGetMaxY(self.titleLable.frame), contentW - 6 * GAP, messageSize.height + GAP);
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
    
    contentH = self.labelView.height + self.buttonView.height;
    contentCenterX = self.centerX;
    contentCenterY = self.centerY;
    
    self.contentView.centerX = contentCenterX;
    self.contentView.centerY = contentCenterY;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.contentView.size = CGSizeMake(contentW, contentH);
        
    } completion:nil];
}
- (void)buttonDidClick
{
    [self dismissKdActionSheet];
}

- (void)dismissKdActionSheet
{
    [self removeFromSuperview];
}

- (CGSize)sizeWithFont:(UIFont *)font text:(NSString *)text maxSize:(CGSize)size
{
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
}

@end
