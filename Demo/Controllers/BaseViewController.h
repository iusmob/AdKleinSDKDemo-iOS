//
//  BaseViewController.h
//  Demo
//
//  Created by mac on 2020/8/12.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantsHeader.h"
#import <AdKleinSDK/AdKleinSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (strong, nonatomic)  UILabel *tipsLabel;
@property (strong, nonatomic)  UIButton *loadBtn;
@property (strong, nonatomic)  UIButton *showBtn;


- (void)showString:(NSString *)message;

- (void)showError:(NSError *)error;


@end

NS_ASSUME_NONNULL_END
