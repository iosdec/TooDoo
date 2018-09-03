//
//  CDatePicker.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "CDatePicker.h"

#define kCDatePickerHeight 198

@implementation CDatePicker {
    UITextField *textField;         //  store text field
    UIViewController *controller;   //  store controller
}

/*
 *      Name: Present with text field
 *      Desc: Class method for easy presentation
 */

+ (void)presentWithTextField:(UITextField *)textField controller:(UIViewController *)controller {
    
    CDatePicker *picker             =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    picker.frame                    =   CGRectMake(0, controller.view.frame.size.height, controller.view.frame.size.width, kCDatePickerHeight);
    [picker.datepicker addTarget:picker action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
    [controller.view addSubview:picker];
    
    //  store textfield and controller:
    picker->controller              =   controller;
    picker->textField               =   textField;
    
    //  check for existing date in the textfield:
    [picker checkForExistingDate];
    
    //  present:
    [UIView animateWithDuration:0.3 animations:^{
        picker.frame                =   CGRectMake(0, picker->controller.view.frame.size.height - kCDatePickerHeight, picker.frame.size.width, kCDatePickerHeight);
    }];
    
}

- (void)checkForExistingDate {
    
    if (self->textField.text.length != 0) {
        
        NSDate *date = [self stringToDate:self->textField.text];
        if (date) {
            [self.datepicker setDate:date animated:YES];
        }
        
    }
    
}

/*
 *      Name: Animate out and remove:
 */

- (void)animateOutAndRemove {
    
    //  animate off the screen:
    [UIView animateWithDuration:0.3 animations:^{
        self.frame                =   CGRectMake(0, self->controller.view.frame.size.height, self.frame.size.width, kCDatePickerHeight);
    } completion:^(BOOL finished) {
        
        //  once the animation is finished.. remove from the superview:
        [self removeFromSuperview];
        
    }];
    
}

- (IBAction)actionCancel:(UIButton *)sender {
    
    //  reset the value of the text field:
    textField.text      =   nil;
    
    //  animate out and remove:
    [self animateOutAndRemove];
    
}

- (IBAction)actionDone:(UIButton *)sender {
    
    //  animate out and remove:
    [self animateOutAndRemove];
    
}

#pragma mark    -   UIDatePicker Action:

- (void)datePickerAction:(UIDatePicker *)picker {
    
    //  convert the picked date into text format:
    NSString *date_string       =   [self dateToString:picker.date];
    
    //  update the text field value:
    [self->textField setText:date_string];
    
}

- (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy - HH:mm";
    return [formatter stringFromDate:date];
}

- (NSDate *)stringToDate:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy - HH:mm";
    return [formatter dateFromString:string];
}

@end
