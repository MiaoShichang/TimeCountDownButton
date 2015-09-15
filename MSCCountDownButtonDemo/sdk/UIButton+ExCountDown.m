//
//  UIButton+ExCountDown.m
//  MSCTimeCountDeom
//
//  Created by MiaoShichang on 15/9/12.
//  Copyright (c) 2015年 MiaoShichang. All rights reserved.
//

#import "UIButton+ExCountDown.h"
#import <objc/runtime.h>

char *const kEXButtonAssociatedObject = "kEXButtonAssociatedObject";


/************************************************************************/
@interface EXButtonAssociatedObject : NSObject

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger countDown;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, copy) NSString *(^timeChangedTitle)(UIButton *button, NSInteger second);
@property (nonatomic, copy) NSString *(^timeStopTitle)(UIButton *button);
@property (nonatomic, copy) BOOL (^timeWillStart)(UIButton *button);

@end

@implementation EXButtonAssociatedObject

@end

/************************************************************************/
@implementation UIButton (ExCountDown)

- (EXButtonAssociatedObject *)buttonAssociatedObject
{
    EXButtonAssociatedObject *associatedObject = objc_getAssociatedObject(self, kEXButtonAssociatedObject);
    
    if (!associatedObject) {
        associatedObject = [[EXButtonAssociatedObject alloc]init];
        objc_setAssociatedObject(self, kEXButtonAssociatedObject, associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return associatedObject;
}

//
- (void)setDuration:(NSInteger)duration
{
    if (duration < 0) {
        duration = 0;
    }
    
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    associatedObject.duration = duration;
    
    [self addTarget:self action:@selector(exp_clicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)duration
{
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    
    return associatedObject.duration;
}

- (void)setTimeChangedTitle:(NSString *(^)(UIButton *, NSInteger))timeChangedTitle
{
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    associatedObject.timeChangedTitle = timeChangedTitle;
}

- (NSString *(^)(UIButton *, NSInteger))timeChangedTitle
{
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    
    return associatedObject.timeChangedTitle;
}

- (void)setTimeStopTitle:(NSString *(^)(UIButton *))timeStopTitle
{
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    associatedObject.timeStopTitle = timeStopTitle;
}

- (NSString *(^)(UIButton *))timeStopTitle
{
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    
    return associatedObject.timeStopTitle;
}

- (void)setTimeWillStart:(BOOL (^)(UIButton *))timeWillStart
{
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    associatedObject.timeWillStart = timeWillStart;
}

- (BOOL (^)(UIButton *))timeWillStart
{
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    
    return associatedObject.timeWillStart;
}

#pragma mark -

- (void)exp_clicked:(UIButton *)btn
{
    if (self.timeWillStart)
    {
        if(self.timeWillStart(self))
        {
            [self exp_start];
        }
    }
    else
    {
        [self exp_start];
    }
}

- (void)exp_start
{
    self.enabled = NO;
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    associatedObject.countDown = associatedObject.duration;
    
    if (self.timeChangedTitle){
        NSString *title = self.timeChangedTitle(self, associatedObject.countDown);
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateDisabled];
    }
    else{
        NSString *title = [NSString stringWithFormat:@"%lds后重新获取", (long)associatedObject.countDown];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateDisabled];
    }
    
    associatedObject.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(exp_timerEvent:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:associatedObject.timer forMode:NSRunLoopCommonModes];
}

- (void)exp_timerEvent:(NSTimer *)timer
{
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    associatedObject.countDown--;
    
    if (associatedObject.countDown < 0){
        [self exp_stop];
    }
    else{
        if (self.timeChangedTitle){
            NSString *title = self.timeChangedTitle(self, associatedObject.countDown);
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
        }
        else{
            NSString *title = [NSString stringWithFormat:@"%lds后重新获取", (long)associatedObject.countDown];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
        }
        
        if(associatedObject.countDown == 0){
            [self exp_stop];
        }
    }
}

- (void)exp_stop
{
    self.enabled = YES;
    
    if (self.timeStopTitle){
        NSString *title = self.timeStopTitle(self);
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateDisabled];
    }
    else{
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        [self setTitle:@"重新获取" forState:UIControlStateDisabled];
    }
    
    EXButtonAssociatedObject *associatedObject = [self buttonAssociatedObject];
    NSTimer *timer = associatedObject.timer;
    
    if (timer && [timer isValid]) {
        [timer invalidate];
    }
}


@end
