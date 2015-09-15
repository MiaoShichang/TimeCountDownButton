//
//  UIButton+ExCountDown.h
//  MSCTimeCountDeom
//
//  Created by MiaoShichang on 15/9/12.
//  Copyright (c) 2015年 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 类功能：按钮倒计时功能
 */

@interface UIButton (ExCountDown)

/**
 *@brief 设置倒计时的时间
 */
@property (nonatomic, assign) NSInteger duration;

/**
 *@brief 每次时间更新时间时要显示的title
 */
@property (nonatomic, copy) NSString *(^timeChangedTitle)(UIButton *button, NSInteger second);

/**
 *@brief 倒计时结束时要显示的title
 */
@property (nonatomic, copy) NSString *(^timeStopTitle)(UIButton *button);

/**
 *@brief 倒计时将要开始
 *
 *@return 返回值为YES时，计时器开始执行；返回NO时，计时器不执行；
 *
 *@note 注意：不要给倒计时按钮添加 UIControlEventTouchUpInside 事件 
 *
 *在此block中，用户可以检测手机号是否正确时，来决定是否启动倒计时
 *
 */
@property (nonatomic, copy) BOOL (^timeWillStart)(UIButton *button);

@end
