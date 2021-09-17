//
//  ViewController.m
//  Demo
//
//  Created by mac on 2020/8/11.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "ViewController.h"
#import "AllViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];

    [self setViewControllers:@[[AllViewController new]]];
}

@end
