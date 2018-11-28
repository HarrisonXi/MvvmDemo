//
//  MvvmDemoTests.m
//  MvvmDemoTests
//
//  Created by HarrisonXi on 2018/11/28.
//  Copyright © 2018 harrisonxi.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Presenter.h"

@interface MvvmDemoTests : XCTestCase <PresenterDelegate>

@property (nonatomic, assign) BOOL loginEnabled;

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

- (void)testLoginEnabled {
    Presenter *presenter = [Presenter new];
    presenter.delegate = self;
    
    [presenter updateUsername:@"aaaa"];
    NSAssert(self.loginEnabled == NO, @"Error");
    [presenter updatePassword:@"aaaaaaaa"];
    NSAssert(self.loginEnabled == YES, @"Error");
}

- (void)updateLoginEnabled:(BOOL)enabled {
    self.loginEnabled = enabled;
}

@end
