//
//  ViewModel.m
//  MvvmDemo
//
//  Created by HarrisonXi on 2018/11/28.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import "ViewModel.h"

#define GreenBgColor [UIColor colorWithRed:0.8 green:1.0 blue:0.8 alpha:1]
#define RedBgColor   [UIColor colorWithRed:1.0 green:0.8 blue:0.8 alpha:1]
#define WhiteBgColor [UIColor whiteColor]

@implementation InputStateToColorConverter

+ (EZRMutableNode *)convert:(EZRNode *)node
{
    return [node map:^id _Nullable(NSNumber * _Nullable inputStateNumber) {
        InputState inputState = [inputStateNumber unsignedIntegerValue];
        switch (inputState) {
            case InputStateValid:
                return GreenBgColor;
            case InputStateInvalid:
                return RedBgColor;
            default:
                return WhiteBgColor;
        }
    }].mutablify;
}

@end

@interface ViewModel ()

@property (nonatomic, assign, readwrite) InputState usernameInputState;
@property (nonatomic, assign, readwrite) InputState passwordInputState;
@property (nonatomic, assign, readwrite) BOOL loginEnabled;

@end

@implementation ViewModel

- (instancetype)init
{
    if (self = [super init]) {
        EZR_PATH(self, usernameInputState) = [EZR_PATH(self, username) map:^id _Nullable(NSString * _Nullable username) {
            if ([username length] >= 4 && [username length] <= 16) {
                return @(InputStateValid);
            } else {
                if ([username length] == 0) {
                    return @(InputStateEmpty);
                } else {
                    return @(InputStateInvalid);
                }
            }
        }].mutablify;
        
        EZR_PATH(self, passwordInputState) = [EZR_PATH(self, password) map:^id _Nullable(NSString * _Nullable password) {
            if ([password length] >= 8 && [password length] <= 16) {
                return @(InputStateValid);
            } else {
                if ([password length] == 0) {
                    return @(InputStateEmpty);
                } else {
                    return @(InputStateInvalid);
                }
            }
        }].mutablify;
        
        EZR_PATH(self, loginEnabled) = [EZRCombine(EZR_PATH(self, usernameInputState),
                                                   EZR_PATH(self, passwordInputState))
                                        mapEach:^id _Nonnull(NSNumber * _Nonnull usernameInputStateValue,
                                                             NSNumber * _Nonnull passwordInputStateValue) {
                                            if ([usernameInputStateValue unsignedIntegerValue] == InputStateValid &&
                                                [passwordInputStateValue unsignedIntegerValue] == InputStateValid) {
                                                return @(YES);
                                            } else {
                                                return @(NO);
                                            }
                                        }].mutablify;
    }
    return self;
}

@end
