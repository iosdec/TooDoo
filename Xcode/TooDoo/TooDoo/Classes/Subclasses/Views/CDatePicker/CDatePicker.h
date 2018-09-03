//
//  CDatePicker.h
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDatePicker : UIView

+ (void)presentWithTextField:(UITextField *)textField controller:(UIViewController *)controller;
- (void)datePickerAction:(UIDatePicker *)picker;

@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;

@end
