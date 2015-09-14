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
 *@brief UIControlEventTouchUpInside 事件 block 
 *
 *@return 返回值为YES时，计时器开始执行；返回NO时，计时器不执行；
 *
 *在检测手机号不正确时， 返回值的作用是给用户一次是否开始倒计时的机会，
 *
 *@note 注意：不要给倒计时按钮添加 UIControlEventTouchUpInside 事件 
 */
@property (nonatomic, copy) BOOL (^touchUpInsideEvent)(UIButton *button);

@end
