//
//  KDActionSheet.h
//  ceshi
//
//  Created by mac  on 14-12-25.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KDActionSheet;

@protocol KDActionSheetDelegate <NSObject>


@end

@interface KDActionSheet : UIView

@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIFont *messageFont;
@property (nonatomic, strong) UIColor *buttonTitleColor;
@property (nonatomic, strong) UIFont *buttonTitleFont;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) UIColor *titleClolor;
@property (nonatomic, assign) NSTextAlignment messageLabelAlignment;


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (void)show;
- (void)addActionButtonArray:(NSArray *)actionButtonArray;
- (void)addActionButton:(id)actionButton;
@end
