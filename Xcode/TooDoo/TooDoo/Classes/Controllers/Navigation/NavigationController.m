//
//  NavigationController.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController () {}
@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaults];
}

#pragma mark    -   Setup Defaults:

- (void)setupDefaults {
    self.navigationBar.hidden = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

/*  enable gesture recogniser for swiping back: */

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
