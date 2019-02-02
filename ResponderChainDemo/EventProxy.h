//
//  EventProxy.h
//  ResponderChainDemo
//
//  Created by fashion on 2019/2/2.
//  Copyright © 2019年 shangZhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventProxy : NSObject

- (void)handleEventWithName:(NSString *)eventName parameter:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
