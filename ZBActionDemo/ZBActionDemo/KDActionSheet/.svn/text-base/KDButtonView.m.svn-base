//
//  KDButtonView.m
//  ceshi
//
//  Created by mac  on 14-12-25.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import "KDButtonView.h"
#import "KDActionButton.h"

//#define HEIGHT 44


@interface KDButtonView ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *lineArray;

@property (nonatomic, strong) UIView *otherButtonView;
@end

@implementation KDButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (UIView *)otherButtonView
{
    if (_otherButtonView == nil) {
        _otherButtonView = [[UIView alloc] init];
        _otherButtonView.backgroundColor = WhiteColor;
        _otherButtonView.layer.cornerRadius = 3.0f;
        _otherButtonView.layer.masksToBounds = YES;
        [self addSubview:_otherButtonView];
    }
    return _otherButtonView;
}

- (void)setButtonTitles:(NSArray *)buttonTitles
{
    _buttonTitles = buttonTitles;
    
    if (buttonTitles.count > 2) {
        for (int i = 0; i < buttonTitles.count; i ++) {
            NSString *title = buttonTitles[i];
            KDActionButton *btn = [KDActionButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLORWITH16COLOR(0x2f93e7) forState:UIControlStateNormal];
            btn.backgroundColor = ClearColor;
            [btn addTarget:self action:@selector(actionButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.adjustsImageWhenHighlighted = NO;
            btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            btn.tag = i;
            [btn setExclusiveTouch:YES];/*禁用按钮同时点击*/
            [self.buttonArray addObject:btn];
            
            if (self.buttonTitles.count - 1 == i) {
                [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
                btn.backgroundColor = RGBCOLORWITH16COLOR(0x2f93e7);
                btn.layer.cornerRadius = 3.0f;
                btn.layer.masksToBounds = YES;
                [self addSubview:btn];
            } else {
                [self.otherButtonView addSubview:btn];
                if (self.buttonTitles.count - 2 != i) {
                    UIView *lineView = [[UIView alloc] init];
                    lineView.backgroundColor = RGBCOLORWITH16COLOR(0xaaaaaa);
                    //        lineView.tag = i;
                    [self.otherButtonView addSubview:lineView];
                    [self.lineArray addObject:lineView];
                }
            }
        }

    } else {
        for (int i = 0; i < buttonTitles.count; i ++) {
            NSString *title = buttonTitles[i];
            KDActionButton *btn = [KDActionButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLORWITH16COLOR(0x2f93e7) forState:UIControlStateNormal];
            btn.backgroundColor = WhiteColor;
            [btn addTarget:self action:@selector(actionButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.adjustsImageWhenHighlighted = NO;
            btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            btn.tag = i;
            [btn setExclusiveTouch:YES];/*禁用按钮同时点击*/
            [self.buttonArray addObject:btn];
            [self addSubview:btn];
            
        }
        
        if (buttonTitles.count == 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = RGBCOLORWITH16COLOR(0xaaaaaa);
            //        lineView.tag = i;
            [self addSubview:lineView];
            [self.lineArray addObject:lineView];
            
        } else {
            
        }
    }
}

- (void)setButtonSize:(CGSize)buttonSize
{
    _buttonSize = buttonSize;
    
    
    if (self.buttonTitles.count <= 2) {
        for (int i = 0; i < self.buttonTitles.count; i ++) {
            UIButton *btn = self.buttonArray[i];
            CGFloat X = i * self.frame.size.width / 2;
            btn.frame = CGRectMake(X, 0, buttonSize.width / 2, buttonSize.height);
        }
        
        
        for (int i = 0; i < self.lineArray.count; i ++) {
            
            UIView *view = self.lineArray[i];
            view.frame = CGRectMake(buttonSize.width / 2.0, 0, 0.5, buttonSize.height);
        }
        
    } else {
        
        CGFloat btnHeight = (buttonSize.height - OppositeHeightRate(16)) / self.buttonArray.count;
        self.otherButtonView.frame = CGRectMake(0, 0, buttonSize.width, (self.buttonTitles.count - 1) * btnHeight);
        for (int i = 0; i < self.lineArray.count; i ++) {
            
            UIView *view = self.lineArray[i];
             CGFloat Y = (i + 1) * btnHeight;
           view.frame = CGRectMake(OppositeWidthRate(8), Y, buttonSize.width, 0.5f);
        }

        for (int i = 0; i < self.buttonTitles.count; i ++) {
            UIButton *btn = self.buttonArray[i];
            CGFloat Y = i * (buttonSize.height - OppositeHeightRate(16)) / self.buttonArray.count;
            if (i == self.buttonTitles.count - 1) {
                btn.frame = CGRectMake(0, Y + OppositeHeightRate(16), buttonSize.width, btnHeight);
            } else {
                btn.frame = CGRectMake(0, Y, buttonSize.width, btnHeight);
                
            }
            
        }
    }
    
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
