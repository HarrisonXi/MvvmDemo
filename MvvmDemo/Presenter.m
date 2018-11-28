//
//  Presenter.m
//  MvvmDemo
//
//  Created by HarrisonXi on 2018/11/28.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import "Presenter.h"

#define GreenBgColor [UIColor colorWithRed:0.8 green:1.0 blue:0.8 alpha:1]
#define RedBgColor   [UIColor colorWithRed:1.0 green:0.8 blue:0.8 alpha:1]
#define WhiteBgColor [UIColor whiteColor]

@interface Presenter ()

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end

@implementation Presenter

- (void)refreshUI
{
    BOOL enableLogin = YES;
    UIColor *usernameBgColor = nil;
    UIColor *passwordBgColor = nil;
    if ([self.username length] >= 4 && [self.username length] <= 16) {
        usernameBgColor = GreenBgColor;
    } else {
        if ([self.username length] == 0) {
            usernameBgColor = WhiteBgColor;
        } else {
            usernameBgColor = RedBgColor;
        }
        enableLogin = NO;
    }
    if ([self.password length] >= 8 && [self.password length] <= 16) {
        passwordBgColor = GreenBgColor;
    } else {
        if ([self.password length] == 0) {
            passwordBgColor = WhiteBgColor;
        } else {
            passwordBgColor = RedBgColor;
        }
        enableLogin = NO;
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(updateUsernameBgColor:)]) {
            [self.delegate updateUsernameBgColor:usernameBgColor];
        }
        if ([self.delegate respondsToSelector:@selector(updatePasswordBgColor:)]) {
            [self.delegate updatePasswordBgColor:passwordBgColor];
        }
        if ([self.delegate respondsToSelector:@selector(updateLoginEnabled:)]) {
            [self.delegate updateLoginEnabled:enableLogin];
        }
    }
}

- (void)updateUsername:(NSString *)username
{
    self.username = username;
    [self refreshUI];
}

- (void)updatePassword:(NSString *)password
{
    self.password = password;
    [self refreshUI];
}

@end
