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
    EZR_PATH(self.viewModel, username) = EZR_PATH(self.usernameTextField, text);
    EZR_PATH(self.viewModel, password) = EZR_PATH(self.passwordTextField, text);
    // bind output signals
    EZR_PATH(self.usernameTextField, backgroundColor) = ConvertInputStateToColor(EZR_PATH(self.viewModel, usernameInputState));
    EZR_PATH(self.passwordTextField, backgroundColor) = ConvertInputStateToColor(EZR_PATH(self.viewModel, passwordInputState));
    EZR_PATH(self.loginButton, enabled) = EZR_PATH(self.viewModel, loginEnabled);
}

@end
