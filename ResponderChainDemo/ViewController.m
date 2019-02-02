//
//  ViewController.m
//  ResponderChainDemo
//
//  Created by fashion on 2019/2/2.
//  Copyright © 2019年 shangZhu. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "UIResponder+Router.h"

@interface ViewController ()

/// 事件策略字典 key:事件名 value:事件的invocation对象
@property (strong, nonatomic) NSDictionary *eventStrategyDictionary;

@end

NSString *const kEventMyButtonName = @"CustomButtonEvent";
NSString *const kEventMySwitchName = @"CustomSwitchEvent";
NSString *const kEventMyImageViewName = @"CustomImageViewEvent";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomView *customV = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil].firstObject;
    customV.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-10, 250);
    [self.view addSubview:customV];
}

#pragma mark - Getter
- (NSDictionary <NSString *, NSInvocation *>*)eventStrategyDictionary {
    if (!_eventStrategyDictionary) {
        NSInvocation *btnInvocation = [self createInvocationWithSelector:@selector(customViewButtonClickWithParameter:)];
        NSInvocation *switchInvocation = [self createInvocationWithSelector:@selector(customViewSwitchValueChangeWithParameter:)];
        NSInvocation *imgInvocation = [self createInvocationWithSelector:@selector(customViewImageViewTapWithParameter:)];
        
        _eventStrategyDictionary = @{ kEventMyButtonName: btnInvocation,
                                      kEventMySwitchName: switchInvocation,
                                      kEventMyImageViewName: imgInvocation
                                    };

    }
    return _eventStrategyDictionary;
}

#pragma mark - Event Response
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"controller---eventName=%@,userInfo=%@",eventName,userInfo);
    // 处理事件
    [self handleEventWithName:eventName parameter:userInfo];
    // 把响应链继续传递下去 和super 一样效果
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
    // [super routerEventWithName:eventName userInfo:userInfo];
}

- (void)handleEventWithName:(NSString *)eventName parameter:(NSDictionary *)parameter{
    
    // 获取invocation对象
    NSInvocation *invocation = self.eventStrategyDictionary[eventName];

    // 设置invocation参数
    // 因为有两个隐藏参数self和_cmd,所有index从2开始
    [invocation setArgument:&parameter atIndex:2];

    // 调用方法
    [invocation invoke];
}

- (void)customViewButtonClickWithParameter:(NSDictionary *)parameter{
    
    NSLog(@"%s,parameter=%@",__func__,parameter);
}
- (void)customViewSwitchValueChangeWithParameter:(NSDictionary *)parameter{
    
    NSLog(@"%s,parameter=%@",__func__,parameter);
}
- (void)customViewImageViewTapWithParameter:(NSDictionary *)parameter{
    
    NSLog(@"%s,parameter=%@",__func__,parameter);
}

@end
