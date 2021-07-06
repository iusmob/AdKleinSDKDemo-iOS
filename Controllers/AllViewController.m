//
//  AllViewController.m
//  Demo
//
//  Created by mac on 2020/8/11.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "AllViewController.h"

@interface AllViewController ()
@property(nonatomic, strong) NSArray *buttonArray;

@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self createButtons];
    self.title = @"AdKleinSDK Demo";
}
- (void)createButtons {

    self.buttonArray = @[@{
                             @"title":@"开屏(SplashAd)",
                             @"vc":@"SplashAdVC",
    },@{
                             @"title":@"插屏(InterstitialAd)",
                             @"vc":@"InterstitialVC",
    },@{
                             @"title":@"横幅(BannerAd)",
                             @"vc":@"BannerViewVC",
    },@{
                             @"title":@"信息流-模版(NativeExpressAd)",
                             @"vc":@"NativeExpressAdVC",
    },@{
                             @"title":@"信息流-自渲染(NativeAd)",
                             @"vc":@"NativeAdVC",
    },@{
                             @"title":@"激励视频(RewardVideoAd)",
                             @"vc":@"RewardVideoVC",
    },@{
                             @"title":@"全屏视频(FullScreenVideoAd)",
                             @"vc":@"FullScreenVideoVC",
    }];

    CGFloat y = (self.view.frame.size.height  -70*self.buttonArray.count) / 2;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;

    for (int i=0; i<self.buttonArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(screen_width/2 -150, y + 70*i, 300, 50)];
        [button setTitle:self.buttonArray[i][@"title"] forState:UIControlStateNormal];
        button.tag = i;
        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)button {
    NSString *name =self.buttonArray[button.tag][@"vc"];
    Class cls = NSClassFromString(name);
    UIViewController *vc = [[cls alloc] init];
    vc.title = self.buttonArray[button.tag][@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
