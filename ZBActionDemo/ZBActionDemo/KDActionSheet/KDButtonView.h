//
//  KDButtonView.h
//  ceshi
//
//  Created by mac  on 14-12-25.
//  Copyright (c) 2014年 kdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBActionProtocol.h"

@interface KDButtonView : UIView<ZBActionProtocol>

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, weak) id<ZBActionProtocol> buttonViewDelegate;

@end
