//
//  ViewController.m
//  MvvmDemo
//
//  Created by HarrisonXi on 2018/11/27.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import "ViewController.h"
#import "Presenter.h"

@interface ViewController () <UITextViewDelegate, PresenterDelegate>

@property (nonatomic, strong) Presenter *presenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.enabled = NO;
    self.presenter = [Presenter new];
    self.presenter.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string
{
    if (textField == self.usernameTextField) {
        [self.presenter updateUsername:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    } else {
        [self.presenter updatePassword:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    }
    return YES;
}

- (void)updateUsernameBgColor:(UIColor *)color
{
    self.usernameTextField.backgroundColor = color;
}

- (void)updatePasswordBgColor:(UIColor *)color
{
    self.passwordTextField.backgroundColor = color;
}

- (void)updateLoginEnabled:(BOOL)enabled
{
    self.loginButton.enabled = enabled;
}

@end
