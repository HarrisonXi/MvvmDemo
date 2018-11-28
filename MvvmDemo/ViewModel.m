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

+ (RACSignal *)convert:(RACSignal *)signal
{
    return [signal map:^id(NSNumber *inputStateNumber) {
        InputState inputState = [inputStateNumber unsignedIntegerValue];
        switch (inputState) {
            case InputStateValid:
                return GreenBgColor;
            case InputStateInvalid:
                return RedBgColor;
            default:
                return WhiteBgColor;
        }
    }];
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
        RAC(self, usernameInputState) = [RACObserve(self, username) map:^id(NSString *username) {
            if ([username length] >= 4 && [username length] <= 16) {
                return @(InputStateValid);
            } else {
                if ([username length] == 0) {
                    return @(InputStateEmpty);
                } else {
                    return @(InputStateInvalid);
                }
            }
        }];
        
        RAC(self, passwordInputState) = [RACObserve(self, password) map:^id(NSString *password) {
            if ([password length] >= 8 && [password length] <= 16) {
                return @(InputStateValid);
            } else {
                if ([password length] == 0) {
                    return @(InputStateEmpty);
                } else {
                    return @(InputStateInvalid);
                }
            }
        }];
        
        RAC(self, loginEnabled) = [RACSignal combineLatest:@[RACObserve(self, usernameInputState),
                                                             RACObserve(self, passwordInputState)]
                                                    reduce:^id(NSNumber *usernameInputStateValue,
                                                               NSNumber *passwordInputStateValue){
                                                        if ([usernameInputStateValue unsignedIntegerValue] == InputStateValid &&
                                                            [passwordInputStateValue unsignedIntegerValue] == InputStateValid) {
                                                            return @(YES);
                                                        } else {
                                                            return @(NO);
                                                        }
                                                    }];
    }
    return self;
}

@end
