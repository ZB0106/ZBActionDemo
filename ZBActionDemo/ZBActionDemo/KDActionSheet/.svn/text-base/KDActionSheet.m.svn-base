//
//  KDActionSheet.m
//  ceshi
//
//  Created by mac  on 14-12-25.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import "KDActionSheet.h"
#import "KDButtonView.h"


#define HEIGHT 44
#define GAP 10

@interface KDActionSheet ()

@property (nonatomic, strong) NSMutableArray *buttonTitles;
//@property (nonatomic, strong) NSMutableArray *labelTitles;
@property (nonatomic, strong) UIImageView *contentView;
//@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UIButton *coverBtn;
@property (nonatomic, strong) KDButtonView *buttonView;
@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, strong) UIView *labelView;

@end

@implementation KDActionSheet

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle buttonTitles:(NSArray *)otherButtonTitles delegate:(id<KDActionSheetDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.backgroundColor = ClearColor;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonDidClick:) name:@"KDActionButtonDidClick" object:nil];
        
        self.delegate = delegate;
        
        UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coverBtn.userInteractionEnabled = NO;
        [coverBtn addTarget:self action:@selector(dismissKdActionSheet) forControlEvents:UIControlEventTouchUpInside];
        coverBtn.backgroundColor = [UIColor blackColor];
        coverBtn.alpha = 0.5;
        self.coverBtn = coverBtn;
        [self addSubview:coverBtn];
        
        if (title != nil) {

            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont boldSystemFontOfSize:18.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title;
            label.backgroundColor = [UIColor clearColor];
            self.titleLable = label;
            [self.labelView addSubview:label];

        }
        
        if (message != nil) {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:15.0];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = message;
            label.backgroundColor = [UIColor clearColor];

            self.messageLabel = label;
            [self.labelView addSubview:label];
        
        }
        if (message != nil || title != nil) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor colorWithRed:128 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
            self.lineView = lineView;
            [self.labelView addSubview:lineView];
        }
        if (cancelButtonTitle != nil) {
            
            [self.buttonTitles addObject:cancelButtonTitle];
        }
        if (otherButtonTitles.count > 0) {
            
            for (int i = 0; i < otherButtonTitles.count; i ++) {
                NSString *title = otherButtonTitles[i];
                [self.buttonTitles insertObject:title atIndex:i];
            }
        }
        if (self.buttonTitles.count > 0) {
            self.buttonView.buttonTitles = self.buttonTitles;
        }
    }
    return self;
}



#pragma mark 懒加载
- (NSMutableArray *)buttonTitles
{
    if (_buttonTitles == nil) {
        _buttonTitles = [NSMutableArray array];
    }
    return _buttonTitles;
}

- (KDButtonView *)buttonView
{
    if (_buttonView == nil) {
        _buttonView = [[KDButtonView alloc] init];
        _buttonView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_buttonView];
    }
    return _buttonView;
}

- (UIView *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UIView alloc] init];
        _labelView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_labelView];
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
        _contentView.backgroundColor = ClearColor;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIImageView *)bigImageView
{
    if (_bigImageView == nil) {
        _bigImageView = [[UIImageView alloc] init];
        [self addSubview:_bigImageView];
    }
    return _bigImageView;
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





- (void)showInView:(UIView *)view
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.frame = keyWindow.bounds;
    self.coverBtn.frame = self.bounds;
    
    
    if (self.bigImageView) {
        self.bigImageView.frame = CGRectMake((HARDWARE_SCREEN_WIDTH - OppositeWidthRate(200)) / 2.0f, OppositeHeightRate(50) + 64, OppositeWidthRate(200), OppositeWidthRate(200));
        self.bigImageView.layer.cornerRadius = self.bigImageView.width / 2.0f;
        self.bigImageView.layer.masksToBounds = YES;
    }
    
    CGFloat contentX = GAP;
    CGFloat contentY = self.frame.size.height;
    CGFloat contentW = self.frame.size.width - GAP * 2;
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
        CGSize messageSize = [self sizeWithFont:self.messageLabel.font text:self.messageLabel.text];
        self.messageLabel.frame = CGRectMake(3 * GAP, CGRectGetMaxY(self.titleLable.frame), contentW - 6 * GAP, messageSize.height + GAP);
        labelH = labelH + self.messageLabel.frame.size.height + GAP;
    }
    
    if (self.lineView != nil) {
        self.lineView.frame = CGRectMake(0, HEIGHT, contentW, 0.5);
    }

    self.labelView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    if (self.buttonTitles.count > 0) {
        
        if (self.buttonTitles.count == 2) {
            self.buttonView.frame = CGRectMake(0, CGRectGetMaxY(self.labelView.frame), contentW, HEIGHT);
            self.buttonView.buttonSize = self.buttonView.frame.size;
        } else {
            self.buttonView.frame = CGRectMake(0, CGRectGetMaxY(self.labelView.frame), contentW, HEIGHT * self.buttonTitles.count + OppositeHeightRate(16));
            self.buttonView.buttonSize = self.buttonView.frame.size;
        }
        
    }
    contentH = self.labelView.frame.size.height + self.buttonView.frame.size.height;
    
    self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    if (HARDWARE_SCREEN_HEIGHT > 480.0f) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect rect = self.contentView.frame;
            rect.origin.y = self.frame.size.height - contentH - OppositeHeightRate(40);
            self.contentView.frame = rect;
        } completion:nil];
    } else {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect rect = self.contentView.frame;
            rect.origin.y = self.frame.size.height - contentH - GAP;
            self.contentView.frame = rect;
        } completion:nil];

    }
   
    
}


- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.frame = keyWindow.bounds;
    self.coverBtn.frame = self.bounds;
    
    
    CGFloat contentCenterX = 0;
    CGFloat contentCenterY = 0;
    CGFloat contentW = self.frame.size.width - GAP * 2;
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
        CGSize messageSize = [self sizeWithFont:self.messageLabel.font text:self.messageLabel.text];
        self.messageLabel.frame = CGRectMake(3 * GAP, CGRectGetMaxY(self.titleLable.frame), contentW - 6 * GAP, messageSize.height + GAP);
        labelH = labelH + self.messageLabel.frame.size.height + GAP;
    }
    
        if (self.lineView != nil) {
            self.lineView.frame = CGRectMake(0, HEIGHT, contentW, 0.5);
        }
    
    self.labelView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    if (self.buttonTitles.count > 0) {
        
        if (self.buttonTitles.count == 2) {
            self.buttonView.frame = CGRectMake(0, CGRectGetMaxY(self.labelView.frame), contentW, HEIGHT);
            self.buttonView.buttonSize = self.buttonView.frame.size;
        } else {
            self.buttonView.frame = CGRectMake(0, CGRectGetMaxY(self.labelView.frame), contentW, HEIGHT * self.buttonTitles.count);
            self.buttonView.buttonSize = self.buttonView.frame.size;
        }
        
    }
    contentH = self.labelView.frame.size.height + self.buttonView.frame.size.height;
    contentCenterX = self.center.x;
    contentCenterY = self.center.y;
    
    self.contentView.frame = CGRectMake(0, 0, contentW, contentH);
    
    self.contentView.center = CGPointMake(contentCenterX, contentCenterY);
    
}

- (void)buttonDidClick:(NSNotification *)notice
{
    UIButton *button = notice.userInfo[@"button"];
    if ([self.delegate respondsToSelector:@selector(kdActionSheet:clickedButtonAtIndex:)]) {
        [self.delegate kdActionSheet:self clickedButtonAtIndex:button.tag];
    }
    
    [self dismissKdActionSheet];
}


- (void)dismissKdActionSheet
{
    [self removeFromSuperview];
}

- (CGSize)sizeWithFont:(UIFont *)font text:(NSString *)text
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat maxW = keyWindow.frame.size.width - 8 * GAP;
    return [text boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
