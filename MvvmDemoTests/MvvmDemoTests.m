//
//  MvvmDemoTests.m
//  MvvmDemoTests
//
//  Created by HarrisonXi on 2018/11/28.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewModel.h"

@interface MvvmDemoTests : XCTestCase

@end

@implementation MvvmDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTextToInputStateConvert {
    NSAssert(InputStateValid == [TextToInputStateConverter inputStateForText:@"aaa" minimum:3 maximum:3], @"Error");
    NSAssert(InputStateInvalid == [TextToInputStateConverter inputStateForText:@"aaa" minimum:4 maximum:5], @"Error");
    NSAssert(InputStateEmpty == [TextToInputStateConverter inputStateForText:nil minimum:3 maximum:3], @"Error");
    NSAssert(InputStateEmpty == [TextToInputStateConverter inputStateForText:@"" minimum:3 maximum:3], @"Error");
}

- (void)testLoginEnabled {
    ViewModel *viewModel = [ViewModel new];
    viewModel.username = @"aaaa";
    NSAssert(viewModel.usernameInputState == InputStateValid, @"Error");
    NSAssert(viewModel.passwordInputState == InputStateEmpty, @"Error");
    NSAssert(viewModel.loginEnabled == NO, @"Error");
    viewModel.password = @"aaaaaaaa";
    NSAssert(viewModel.usernameInputState == InputStateValid, @"Error");
    NSAssert(viewModel.passwordInputState == InputStateValid, @"Error");
    NSAssert(viewModel.loginEnabled == YES, @"Error");
    viewModel.username = @"aaa";
    NSAssert(viewModel.usernameInputState == InputStateInvalid, @"Error");
    NSAssert(viewModel.passwordInputState == InputStateValid, @"Error");
    NSAssert(viewModel.loginEnabled == NO, @"Error");
}

@end
