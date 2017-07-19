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

@implementation TextToInputStateConverter

+ (RACSignal *)convert:(RACSignal *)signal minimum:(NSInteger)minimum maximum:(NSInteger)maximum
{
    NSAssert(minimum > 0, @"TextToInputStateConverter: minimum must be greater than zero");
    NSAssert(maximum >= minimum, @"TextToInputStateConverter: maximum must be greater than or equal to minimum");
    return [signal map:^id(NSString *text) {
        return @([TextToInputStateConverter inputStateForText:text minimum:minimum maximum:maximum]);
    }];
}

+ (InputState)inputStateForText:(NSString *)text minimum:(NSInteger)minimum maximum:(NSInteger)maximum
{
    if ([text length] >= minimum && [text length] <= maximum) {
        return InputStateValid;
    } else {
        if ([text length] == 0) {
            return InputStateEmpty;
        } else {
            return InputStateInvalid;
        }
    }
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
        RAC(self, usernameInputState) = ConvertTextToInputState(RACObserve(self, username), 4, 16);
        
        RAC(self, passwordInputState) = ConvertTextToInputState(RACObserve(self, password), 8, 16);;
        
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
