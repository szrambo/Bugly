//
//  ViewController.m
//  BuglySDKDemo
//
//  Created by mqq on 14/11/25.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "ViewController.h"

#import "BuglySDKHelper.h"

#import <string>
using namespace std;

#define std_string(_cs_) ((_cs_ == NULL) ? std::string() : std::string(_cs_))

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 250, 60)];
    [btn1 setBackgroundColor:[UIColor grayColor]];
    [btn1 setTitle:@"触发ObjC异常-崩溃" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onNSExceptionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn2 = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 250, 60)];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    [btn2 setTitle:@"触发Signal错误－崩溃" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onSignalButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn3 = [[UIButton alloc] initWithFrame:CGRectMake(20, 220, 250, 60)];
    [btn3 setBackgroundColor:[UIColor grayColor]];
    [btn3 setTitle:@"触发Caught异常－不崩溃" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(onCaughtExceptionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];

}

- (void)onNSExceptionButtonClick {
    [self testNSException];
}

- (void)onSignalButtonClick {
    [self testSignalException];
}

- (void)onCaughtExceptionButtonClick {
    @try {
        NSArray * array = @[@"1", @"2"];
        
        NSLog(@"print %@", [array objectAtIndex:2]);
    }
    @catch (NSException *exception) {
        NSLog(@"catch a exception");
        [BuglySDKHelper reportException:exception withMessage:@"Caught an exception"];
    }
    @finally {
        
    }
}

- (void)testNSException {
    NSLog(@"it will throw an NSException ");
    NSArray * array = @[];
    NSLog(@"the element is %@", array[1]);
}

- (void)testSignalException {
    NSLog(@"test signal exception");
    NSString * null = nil;
    NSLog(@"print the nil string %s", [null UTF8String]);
    NSLog(@"print the nil string to c string: %s", std::string([null UTF8String]).c_str());
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
