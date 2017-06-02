//
//  KDActionButton.h
//  actionSheet
//
//  Created by mac  on 14-12-24.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum NSInteger {
    ZB_buttonOK = 0,
    ZB_buttonCancel,
    ZB_buttonDestroy,
    ZB_buttonDefault
}ZB_buttonType;

@interface ZB_ButtonItem : NSObject

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
+ (instancetype)zb_buttonItemWithButtonType:(ZB_buttonType)buttonType;
@end



@interface KDActionButton : UIButton

typedef void(^buttonAction)(KDActionButton *button);

@property (nonatomic, copy) buttonAction action;
+ (instancetype)kdActionButtonWithButtonType:(ZB_buttonType)buttonType title:(NSString *)title action:(buttonAction)action;
@end
