//
//  ViewModel.h
//  MvvmDemo
//
//  Created by HarrisonXi on 2018/11/28.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <EasyReact/EasyReact.h>

typedef enum : NSUInteger {
    InputStateEmpty,
    InputStateValid,
    InputStateInvalid
} InputState;

#define ConvertInputStateToColor(node) [InputStateToColorConverter convert:node]

@interface InputStateToColorConverter : NSObject

+ (EZRMutableNode *)convert:(EZRNode *)node;

@end

@interface ViewModel : NSObject

@property (nonatomic, assign, readonly) InputState usernameInputState;
@property (nonatomic, assign, readonly) InputState passwordInputState;
@property (nonatomic, assign, readonly) BOOL loginEnabled;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@end
