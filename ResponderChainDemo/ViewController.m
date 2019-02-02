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
#import "EventProxy.h"

@interface ViewController ()<CustomViewDelegate>

@property (strong, nonatomic) EventProxy *eventProxy;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventProxy = [[EventProxy alloc] init];
    CustomView *customV = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil].firstObject;
    customV.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-10, 250);
    [self.view addSubview:customV];
    customV.delegate = self;
}

#pragma mark - Event Response
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"controller---eventName=%@,userInfo=%@",eventName,userInfo);
    // 处理事件
    [self.eventProxy handleEventWithName:eventName parameter:userInfo];
    // 把响应链继续传递下去 和super 一样效果
   // [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
    // [super routerEventWithName:eventName userInfo:userInfo];
}

// 实现代理方法
- (void)btnClick:(nonnull UIButton *)btn {
    NSLog(@"%s,parameter=%@",__func__,btn);
}



@end
