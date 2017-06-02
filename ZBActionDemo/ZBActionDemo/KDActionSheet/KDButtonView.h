//
//  KDButtonView.h
//  ceshi
//
//  Created by mac  on 14-12-25.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonDidClick)();

@interface KDButtonView : UIView

@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, copy) buttonDidClick didClick;

@end
