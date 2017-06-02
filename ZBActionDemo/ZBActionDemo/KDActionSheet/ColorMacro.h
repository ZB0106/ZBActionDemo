//
//  ColorMacro.h
//  CBExtension
//
//  Created by  ly on 13-5-28.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h

//颜色宏
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLORWithAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 \
alpha:(a)]
#define RGBCOLORWITH16COLOR(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define WhiteColor  [UIColor whiteColor]
#define RedColor    [UIColor redColor]
#define GreenColor  [UIColor greenColor]
#define BlackColor  [UIColor blackColor]
#define ClearColor  [UIColor clearColor]
#define BlueColor  [UIColor blueColor]
#define GrayColor  [UIColor grayColor]

#define PromptTextColor RGBCOLOR(5 ,85, 155)
//95 110 135
#define PlaceHolderTextColor RGBCOLOR(141, 157, 190)
#define DisableTextColor RGBCOLOR(14, 61, 127)


#define SpecialGrayColor        [UIUtil colorWithHexString:@"#595757" withAlpha:1]      //界面所用大字号所用字体颜色
#define ContentLightGrayColor   [UIColor lightGrayColor]        //界面所用小字号所用字体颜色
#define ContentDarkGrayColor    [UIColor grayColor]             //界面所用中字号所用字体颜色
#define CommonColor              WhiteColor//界面背景颜色


#endif
