//
//  KDActionButton.m
//  actionSheet
//
//  Created by mac  on 14-12-24.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import "KDActionButton.h"
#import "ColorMacro.h"
#import "FontMacro.h"

@implementation KDActionButton

- (void)setHighlighted:(BOOL)highlighted
{
    
}

+ (instancetype)kdActionButtonWithButtonType:(ZB_buttonType)buttonType action:(buttonAction)action
{
    ZB_ButtonItem *item = [ZB_ButtonItem zb_buttonItemWithButtonType:buttonType];
    KDActionButton *btn = [KDActionButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:item.titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = item.titleFont;
    btn.adjustsImageWhenHighlighted = NO;
    [btn setExclusiveTouch:YES];/*禁用按钮同时点击*/
    btn.backgroundColor = ClearColor;
    btn.action = action;


    return btn;
}
- (instancetype)init
{
    if (self = [super init]) {
        ZB_ButtonItem *item = [ZB_ButtonItem zb_buttonItemWithButtonType:ZB_buttonDefault];
        [self setTitleColor:item.titleColor forState:UIControlStateNormal];
        self.titleLabel.font = item.titleFont;
         self.backgroundColor = ClearColor;
        self.adjustsImageWhenHighlighted = NO;
        [self setExclusiveTouch:YES];/*禁用按钮同时点击*/

    }
    return self;
}

@end

@implementation ZB_ButtonItem

+ (instancetype)zb_buttonItemWithButtonType:(ZB_buttonType)buttonType
{
    ZB_ButtonItem *item = [[ZB_ButtonItem alloc] init];
    switch (buttonType) {
        case ZB_buttonOK:
        {
            item.titleColor = BlueColor;
            item.titleFont = Font14;
        }
            break;
        case ZB_buttonCancel:
        {
            item.titleColor = BlackColor;
            item.titleFont = Font14;
        }
            break;
        case ZB_buttonDestroy:
        {
            item.titleColor = RedColor;
            item.titleFont = Font14;
        }
            break;

        case ZB_buttonDefault:
        {
            item.titleColor = RGBCOLORWITH16COLOR(0x2f93e7);
            item.titleFont = Font14;
        }

            break;
    }
    return item;
}

@end
