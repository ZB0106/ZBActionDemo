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

- (void)kdActionSheet:(KDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

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


@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, weak) id<KDActionSheetDelegate> delegate;


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle buttonTitles:(NSArray *)otherButtonTitles delegate:(id<KDActionSheetDelegate>)delegate;
- (void)show;
- (void)showInView:(UIView *)view;
@end