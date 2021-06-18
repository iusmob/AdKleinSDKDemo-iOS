//
//  FeedVC.m
//  Demo
//
//  Created by mac on 2020/8/13.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "NativeExpressAdVC.h"
#import <AdKleinSDK/AdKleinSDKNativeExpressAd.h>

@interface NativeExpressAdVC () <AdKleinSDKNativeExpressAdDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) AdKleinSDKNativeExpressAd *adLoader;
@property(nonatomic, strong) UIView *showAdView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGSize adSize;

@end

@implementation NativeExpressAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.dataArray = [NSMutableArray new];

    self.showBtn.hidden = YES;
    CGSize size = self.view.frame.size;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, size.width, size.height-100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
}

- (void)loadClick {
    if (!self.adLoader) {
        self.adSize = CGSizeMake(self.view.frame.size.width, 0);

        self.adLoader = [[AdKleinSDKNativeExpressAd alloc] initWithPlacementId:CONST_FEED_EXPRESS_ID viewController:self];
        self.adLoader.delegate = self;
        self.adLoader.adSize = self.adSize;
        self.adLoader.videoMuted = NO;
        self.adLoader.adCount = 3;
    }

    [self.adLoader load];
}

- (void)ak_nativeExpressAdDidLoad:(AdKleinSDKNativeExpressAd *)nativeAd withAdViews:(NSArray<__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *> *)adViews {
    // 将获取到的广告视图进行模板渲染
    [adViews enumerateObjectsUsingBlock:^(UIView<AdKleinSDKNativeExpressAdViewDelegate> *adView, NSUInteger idx, BOOL * _Nonnull stop) {
        [adView render];
    }];

    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}

- (void)ak_nativeExpressAdDidFail:(AdKleinSDKNativeExpressAd *)nativeAd withError:(NSError *)error {
    [self showError:error];
}
- (void)ak_nativeExpressAdDidRenderSuccess:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
    // 渲染成功才能拿到真实的高度
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i ++) {
            [self.dataArray addObject:[NSNull null]];
        }
        [self.dataArray addObject:adView];
        [self.tableView reloadData];
    });

    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_nativeExpressAdDidRenderFail:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_nativeExpressAdDidShow:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_nativeExpressAdDidClick:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_nativeExpressAdDidClose:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
    [adView removeFromSuperview];
    [self.dataArray removeObject:adView];
    [self.tableView reloadData];

    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];

    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @"";

    if ([self.dataArray[indexPath.row] conformsToProtocol:@protocol(AdKleinSDKNativeExpressAdViewDelegate)]) {
        UIView<AdKleinSDKNativeExpressAdViewDelegate> *view = (UIView<AdKleinSDKNativeExpressAdViewDelegate> *)self.dataArray[indexPath.row];
        [cell.contentView addSubview:view];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell.backgroundColor = [UIColor grayColor];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataArray[indexPath.row] conformsToProtocol:@protocol(AdKleinSDKNativeExpressAdViewDelegate)]) {
        UIView<AdKleinSDKNativeExpressAdViewDelegate> *view = (UIView<AdKleinSDKNativeExpressAdViewDelegate> *)self.dataArray[indexPath.row];
        NSLog(@"rowHeight = %f", view.frame.size.height);
        return view.frame.size.height;
    } else {
        return 50;
    }
}


@end
