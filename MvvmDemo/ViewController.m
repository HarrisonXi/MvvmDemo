//
//  ViewController.m
//  MvvmDemo
//
//  Created by HarrisonXi on 2018/11/27.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController () <UITextViewDelegate>

@property (nonatomic, strong) ViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [ViewModel new];
    // bind input signals
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    // bind output signals
    RAC(self.usernameTextField, backgroundColor) = ConvertInputStateToColor(RACObserve(self.viewModel, usernameInputState));
    RAC(self.passwordTextField, backgroundColor) = ConvertInputStateToColor(RACObserve(self.viewModel, passwordInputState));
    RAC(self.loginButton, enabled) = RACObserve(self.viewModel, loginEnabled);
}

@end
