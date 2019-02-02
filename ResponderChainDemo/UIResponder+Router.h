//
//  UIResponder+Router.h
//  ResponderChainDemo
//
//  Created by fashion on 2019/2/2.
//  Copyright © 2019年 shangZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Router)


/**
 凡是继承UIResponder的控件,都可以通过事件响应链条传递事件

 @param eventName 事件名
 @param userInfo 附加参数,nullable可以为空
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(nullable NSDictionary *)userInfo;


/**
 通过方法SEL生成NSInvocation

 @param selector 方法
 @return Invocation对象
 */
- (NSInvocation *)createInvocationWithSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
