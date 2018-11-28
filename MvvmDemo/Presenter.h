//
//  Presenter.h
//  MvvmDemo
//
//  Created by HarrisonXi on 2018/11/28.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PresenterDelegate <NSObject>

@optional
- (void)updateUsernameBgColor:(UIColor *)color;
- (void)updatePasswordBgColor:(UIColor *)color;
- (void)updateLoginEnabled:(BOOL)enabled;

@end

@interface Presenter : NSObject

@property (nonatomic, weak) id<PresenterDelegate> delegate;

- (void)updateUsername:(NSString *)username;
- (void)updatePassword:(NSString *)password;

@end
