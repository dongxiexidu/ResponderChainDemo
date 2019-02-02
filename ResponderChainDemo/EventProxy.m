//
//  EventProxy.m
//  ResponderChainDemo
//
//  Created by fashion on 2019/2/2.
//  Copyright © 2019年 shangZhu. All rights reserved.
//

#import "EventProxy.h"
#import "UIResponder+Router.h"

NSString *const kEventMyButtonName = @"CustomButtonEvent";
NSString *const kEventMySwitchName = @"CustomSwitchEvent";
NSString *const kEventMyImageViewName = @"CustomImageViewEvent";

@interface EventProxy ()

// 使用Strategy模式，即可避免多事件处理场景下导致的冗长if-else语句
/// 事件策略字典 key:事件名 value:事件的invocation对象
@property (strong, nonatomic) NSDictionary *eventStrategyDictionary;

@end

@implementation EventProxy

- (NSInvocation *)createInvocationWithSelector:(SEL)selector{
    
    // 通过方法名创建方法签名 注意:不能使用 [[NSInvocation alloc] init]也不可以用下面这个方法
    // NSMethodSignature *signature = [NSInvocation instanceMethodSignatureForSelector:selector];
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    // 通过方法签名创建invocation
    // signature == nil 这里就会崩溃
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    return invocation;
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
    
    NSLog(@"具体方法实现,parameter=%@",parameter);
}
- (void)customViewSwitchValueChangeWithParameter:(NSDictionary *)parameter{
    
    NSLog(@"具体方法实现,parameter=%@",parameter);
}
- (void)customViewImageViewTapWithParameter:(NSDictionary *)parameter{
    
    NSLog(@"具体方法实现,parameter=%@",parameter);
}


@end
