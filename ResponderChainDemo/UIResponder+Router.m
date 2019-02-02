//
//  UIResponder+Router.m
//  ResponderChainDemo
//
//  Created by fashion on 2019/2/2.
//  Copyright © 2019年 shangZhu. All rights reserved.
// 参考了https://github.com/qingfengiOS/MutableCellTableView
// https://casatwy.com/responder_chain_communication.html

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(nullable NSDictionary *)userInfo{
    
    NSLog(@"UIResponder---eventName=%@,userInfo=%@",eventName,userInfo);
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

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

@end
