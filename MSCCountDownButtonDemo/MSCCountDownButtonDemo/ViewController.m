//
//  ViewController.m
//  MSCCountDownButtonDemo
//
//  Created by MiaoShichang on 15/9/12.
//  Copyright (c) 2015年 MiaoShichang. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+ExCountDown.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 单行显示
    UIButton *countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    countDownBtn.frame = CGRectMake(100, 100, 120, 44);
    countDownBtn.backgroundColor = [UIColor purpleColor];
    countDownBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    countDownBtn.duration = 20;
    countDownBtn.touchUpInsideEvent = ^(UIButton *btn){
        // 此函数就是 UIControlEventTouchUpInside 事件，不要给倒计时按钮添加 UIControlEventTouchUpInside 事件
        NSLog(@"单行显示文字");
        
        return YES;
    };
    
    [self.view addSubview:countDownBtn];
    
    
    // 两行及多行显示
    UIButton *countDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    countDownButton.frame = CGRectMake(100, 300, 120, 88);
    countDownButton.backgroundColor = [UIColor redColor];
    countDownButton.titleLabel.numberOfLines = 0; // 多行显示
    countDownButton.titleLabel.textAlignment = NSTextAlignmentCenter; // 居中显示
    
    countDownButton.duration = 20;
    
    countDownButton.timeChangedTitle = ^(UIButton *btn, NSInteger second){
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor orangeColor];
        
        return [NSString stringWithFormat:@"%lds\n重新发送", (long)second];
    };
    
    countDownButton.timeStopTitle = ^(UIButton *btn){
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        
        return @"重新发送";
    };
    
    countDownButton.touchUpInsideEvent = ^(UIButton *btn){
        // 此函数就是 UIControlEventTouchUpInside 事件，不要给倒计时按钮添加 UIControlEventTouchUpInside 事件
        NSLog(@"两行显示文字");
        
        return NO;
    };
    
    [self.view addSubview:countDownButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
