//
//  ViewController.m
//  MvvmDemo
//
//  Created by HarrisonXi on 2018/11/27.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import "ViewController.h"

#define GreenBgColor [UIColor colorWithRed:0.8 green:1.0 blue:0.8 alpha:1]
#define RedBgColor   [UIColor colorWithRed:1.0 green:0.8 blue:0.8 alpha:1]
#define WhiteBgColor [UIColor whiteColor]

@interface ViewController () <UITextViewDelegate>

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.enabled = NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string
{
    if (textField == self.usernameTextField) {
        self.username = [textField.text stringByReplacingCharactersInRange:range withString:string];
    } else {
        self.password = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    
    BOOL enableLogin = YES;
    if ([self.username length] >= 4 && [self.username length] <= 16) {
        self.usernameTextField.backgroundColor = GreenBgColor;
    } else {
        if ([self.username length] == 0) {
            self.usernameTextField.backgroundColor = WhiteBgColor;
        } else {
            self.usernameTextField.backgroundColor = RedBgColor;
        }
        enableLogin = NO;
    }
    if ([self.password length] >= 8 && [self.password length] <= 16) {
        self.passwordTextField.backgroundColor = GreenBgColor;
    } else {
        if ([self.password length] == 0) {
            self.passwordTextField.backgroundColor = WhiteBgColor;
        } else {
            self.passwordTextField.backgroundColor = RedBgColor;
        }
        enableLogin = NO;
    }
    self.loginButton.enabled = enableLogin;
    
    return YES;
}

@end
