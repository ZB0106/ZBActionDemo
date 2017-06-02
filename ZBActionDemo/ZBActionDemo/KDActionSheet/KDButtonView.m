//
//  KDButtonView.m
//  ceshi
//
//  Created by mac  on 14-12-25.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import "KDButtonView.h"
#import "KDActionButton.h"
#import "ColorMacro.h"
#import "UIView+zb_ViewCategory.h"


@interface KDButtonView ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *lineArray;

@end

@implementation KDButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _buttonHeight = 44.0f;
    }
    return self;
}

- (void)setButtonTitles:(NSArray *)buttonTitles
{
    _buttonTitles = buttonTitles;
    NSInteger buttonCount = buttonTitles.count;
    self.height = buttonCount * self.buttonHeight;
    for (int i = 0; i < buttonCount; i ++) {
        NSString *title = buttonTitles[i];
        KDActionButton *btn = [[KDActionButton alloc] init];
        [btn setTitle:title forState:UIControlStateNormal
         ];
        [btn addTarget:self action:@selector(actionButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:btn];
        
        if (i != buttonCount - 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = RGBCOLORWITH16COLOR(0xaaaaaa);
            [self.lineArray addObject:lineView];
        }
    }
}

- (void)didClickForAction:(KDActionButton *)button
{
    if (self.didClick) {
        self.didClick();
    }
    __weak typeof(button) weakBtn = button;
    if (button.action) {
        __strong typeof(weakBtn) strongBtn = weakBtn;
        button.action(strongBtn);
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.width;
    
    NSInteger buttonCount = self.buttonArray.count;
    BOOL isCountEqaulTwo = buttonCount == 2;
    for (int i = 0; i < buttonCount; i ++) {
        UIButton *btn = self.buttonArray[i];
        btn.top = isCountEqaulTwo ? 0 : i * self.height;
        btn.left = isCountEqaulTwo ? i * width : 0;
        btn.width = isCountEqaulTwo ? width / 2.0 : width;
        btn.height = self.buttonHeight;
        if (i != buttonCount - 1) {
            UIView *line = self.lineArray[i];
            line.top = isCountEqaulTwo ? 0 : (i + 1) * self.height;
            line.left = isCountEqaulTwo ? i * width : 0;
            line.width = isCountEqaulTwo ? 0.5 : width;
            line.height = isCountEqaulTwo ? self.height : 0.5;
        }
        
    }
}

- (void)setButtonHeight:(CGFloat)buttonHeight
{
    _buttonHeight = buttonHeight;
    [self layoutIfNeeded];
}


#pragma mark 懒加载
- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)lineArray
{
    if (_lineArray == nil) {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}
- (void)actionButtonDidClick:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KDActionButtonDidClick" object:nil userInfo:@{@"button":button}];
}

@end
