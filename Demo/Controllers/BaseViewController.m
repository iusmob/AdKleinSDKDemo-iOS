//
//  BaseViewController.m
//  Demo
//
//  Created by mac on 2020/8/12.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "BaseViewController.h"
#import "ConstantsHeader.h"

@interface BaseViewController ()

@property(nonatomic, weak)UIWindow *window;

@end

@implementation BaseViewController

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onChangeSlotId:(NSNotification *)notification
{
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    
    self.slotIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, screen_width - 40, 40)];
    self.slotIdTextField.backgroundColor = [UIColor whiteColor];
    self.slotIdTextField.textColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(onChangeSlotId:)
                                             name:UITextFieldTextDidChangeNotification
                                           object:self.slotIdTextField];
    [self.view addSubview:self.slotIdTextField];

    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, screen_width - 40, 80)];
    self.tipsLabel.numberOfLines = 3;
    self.tipsLabel.font = [UIFont systemFontOfSize:15];
    self.tipsLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:self.tipsLabel];

    self.loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 260, screen_width - 40, 40)];
    [self.loadBtn setTitle:@"load" forState:UIControlStateNormal];
    [self.loadBtn addTarget:self action:@selector(loadClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loadBtn];

    self.showBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 320, screen_width - 40, 40)];
    [self.showBtn setTitle:@"show" forState:UIControlStateNormal];
    [self.showBtn addTarget:self action:@selector(showClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showBtn];
    self.loadBtn.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3];
    self.showBtn.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3];


    self.tipsLabel.text = @"...";
    self.window = [[UIApplication sharedApplication].windows lastObject];
}

- (void)loadClick {

}

- (void)showClick {

}

- (void)setLabelHeight {
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGSize size = [self.tipsLabel.text sizeWithFont:self.tipsLabel.font constrainedToSize:CGSizeMake(screen_width - 100, 500)];
    self.tipsLabel.frame = CGRectMake(50, 100, screen_width - 100, size.height);
}

- (void)showString:(NSString *)message {
    NSLog(@"%@", message);
    self.tipsLabel.text = message;
}

- (void)showError:(NSError *)error {
    NSString *message =[NSString stringWithFormat:@" error code= %ld  \n%@",(long)error.code,error.userInfo[@"NSLocalizedDescription"]];
    [self showString:message];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
