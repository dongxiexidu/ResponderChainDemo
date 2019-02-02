//
//  CustomView.m
//  ResponderChainDemo
//
//  Created by fashion on 2019/2/2.
//  Copyright © 2019年 shangZhu. All rights reserved.
//

#import "CustomView.h"
#import "UIResponder+Router.h"



@interface CustomView ()

@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;


@end

extern NSString *kEventMyButtonName;
extern NSString *kEventMySwitchName;
extern NSString *kEventMyImageViewName;



@implementation CustomView

- (void)awakeFromNib{
    [super awakeFromNib];
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction)];
    [self.myImageView addGestureRecognizer:tap];
}

- (void)imageViewTapAction {
    
    [self routerEventWithName:kEventMyImageViewName userInfo: nil];
}

- (IBAction)btnClick:(UIButton *)sender {
//    if ([_delegate respondsToSelector:@selector(btnClick:)]) {
//        [_delegate btnClick:sender];
//    }
    
    NSInteger num = sender.currentTitle.integerValue;
    num = num + 1;
    
    NSString *title = [NSString stringWithFormat:@"%zd",num];
    [sender setTitle:title forState:UIControlStateNormal];
    [self routerEventWithName:kEventMyButtonName userInfo: @{@"btnKey": sender.currentTitle}];
}

- (IBAction)mySwitchChangeAction:(UISwitch *)sender {
    
    [self routerEventWithName:kEventMySwitchName userInfo: @{@"mySwitchKey": sender.isOn == true ? @1 : @0}];
}



@end
