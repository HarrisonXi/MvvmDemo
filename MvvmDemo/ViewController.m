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
    
    self.loginButton.rac_command = self.viewModel.loginCommand;
    [self.viewModel.loginCommand.executionSignals subscribeNext:^(RACSignal<id> * executionSignal) {
        NSLog(@"get signal: %@", executionSignal);
        [executionSignal subscribeNext:^(NSString *step) {
            NSLog(@"get step: %@", step);
        } completed:^{
            NSLog(@"get completed.");
        }];
    }];
    [self.viewModel.loginCommand.errors subscribeNext:^(NSError * error) {
        NSLog(@"get error.");
    }];
}

@end
