//
//  ViewModel.h
//  MvvmDemo
//
//  Created by HarrisonXi on 2018/11/28.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef enum : NSUInteger {
    InputStateEmpty,
    InputStateValid,
    InputStateInvalid
} InputState;

#define ConvertInputStateToColor(signal) [InputStateToColorConverter convert:signal]

@interface InputStateToColorConverter : NSObject

+ (RACSignal *)convert:(RACSignal *)signal;

@end

@interface ViewModel : NSObject

@property (nonatomic, assign, readonly) InputState usernameInputState;
@property (nonatomic, assign, readonly) InputState passwordInputState;
@property (nonatomic, assign, readonly) BOOL loginEnabled;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end
