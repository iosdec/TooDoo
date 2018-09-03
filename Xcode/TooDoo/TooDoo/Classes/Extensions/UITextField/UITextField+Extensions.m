//
//  UITextField+Extensions.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "UITextField+Extensions.h"

@implementation UITextField (UITextField_Extensions)

- (void)setPadding:(CGFloat)amount {
    
    UIView *view        =   [UIView new];
    view.frame          =   CGRectMake(0, 0, amount, self.frame.size.height);
    self.leftView       =   view;
    self.leftViewMode   =   UITextFieldViewModeAlways;
    
}

@end
