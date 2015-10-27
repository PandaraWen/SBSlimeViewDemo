//
//  ViewController.m
//  SBSlimeViewDemo
//
//  Created by Pandara on 15/10/27.
//  Copyright © 2015年 Pandara. All rights reserved.
//

#import "ViewController.h"
#import "SBSlimeView.h"
#import "SBLayoutToolKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    SBSlimeView *slimeView = [SBSlimeView getInstance];
    slimeView.brokeDistance = 150;//px
    [SBLayoutToolKit setView:slimeView toOrigin:CGPointZero];
    [self.view addSubview:slimeView];
}



@end
