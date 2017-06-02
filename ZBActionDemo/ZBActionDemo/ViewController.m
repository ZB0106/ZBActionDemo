//
//  ViewController.m
//  ZBActionDemo
//
//  Created by rongzebing on 2017/6/1.
//  Copyright © 2017年 rongzebing. All rights reserved.
//

#import "ViewController.h"
#import "ZB_ActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    KDActionSheet *sheet = [[KDActionSheet alloc] initWithTitle:@"dfaa" message:@"ceshi"];
    KDActionButton *button1 = [KDActionButton kdActionButtonWithButtonType:ZB_buttonOK title:@"ok" action:^(KDActionButton *button) {
        NSLog(@"11111");
    }];
    KDActionButton *button2 = [KDActionButton kdActionButtonWithButtonType:ZB_buttonOK title:@"ok" action:^(KDActionButton *button) {
        NSLog(@"2222");
    }];
    KDActionButton *button3 = [KDActionButton kdActionButtonWithButtonType:ZB_buttonOK title:@"ok" action:^(KDActionButton *button) {
        NSLog(@"3333");
    }];
    
    [sheet addActionButtonArray:@[button1]];
    [sheet show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
