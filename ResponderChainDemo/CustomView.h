//
//  CustomView.h
//  ResponderChainDemo
//
//  Created by fashion on 2019/2/2.
//  Copyright © 2019年 shangZhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomViewDelegate <NSObject>

- (void)btnClick:(UIButton *)btn;

@end

@interface CustomView : UIView

@property (nonatomic, weak) id<CustomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
