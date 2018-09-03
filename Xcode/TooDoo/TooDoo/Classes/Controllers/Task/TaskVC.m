//
//  TaskVC.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "TaskVC.h"
#import "CDatePicker.h"

@implementation TaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScroller];
    [self setupFields];
    [self checkForTask];
}

#pragma mark    -   Setup Fields:

- (void)setupFields {
    [self.titleField setPadding:12];
    [self.subtitleField setPadding:12];
    [self.reminderField setPadding:12];
}

- (void)setupScroller {
    [self.mainScroller setContentSize:CGSizeMake(0, 667)];
}

#pragma mark    -   Check For Task:

- (void)checkForTask {
    
    if (!self.task) {
        return;
    }
    
    if (self.task.name) {
        self.titleField.text    =   self.task.name;
    }
    
    if (self.task.subtitle) {
        self.subtitleField.text =   self.task.subtitle;
    }
    
    if (self.task.remindDate) {
        NSString *date_string   =   [self dateToString:self.task.remindDate];
        self.reminderField.text =   date_string;
    }
    
    [self.completedSwitch setOn:self.task.completed];
    
    //  update ammend button:
    [self.actionButton setTitle:@"Update Task" forState:UIControlStateNormal];
    
}

#pragma mark    -   Text Field Delegate:

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.reminderField) {
        [CDatePicker presentWithTextField:textField controller:self];
        return NO;
    } else {
        return YES;
    }
}

/*
 *
 *      Name: Ammend Action:
 *      Desc: This action will be called when we create a task..
 *      or.. when we update a task
 *
 */

- (IBAction)ammendAction:(UIButton *)sender {
    
    //  check text fields:
    
    if (self.titleField.text.length == 0) {
        return;
    }
    
    if (self.subtitleField.text.length == 0) {
        return;
    }
    
    //  now create a task..
    
    TDTask *task                =   [[TDTask alloc] init];
    
    //  check if we have an existing task..
    
    if (self.task) {
        task                    =   self.task;
    }
    
    //  add items to task:
    
    task.name                   =   self.titleField.text;
    task.subtitle               =   self.subtitleField.text;
    task.completed              =   self.completedSwitch.isOn;
    
    //  check for date:
    
    if (self.reminderField.text.length != 0) {
        
        NSDateFormatter *fm     =   [[NSDateFormatter alloc] init];
        [fm setDateFormat:@"dd/MM/yyyy - HH:mm"];
        NSDate *date            =   [fm dateFromString:self.reminderField.text];
        
        if (date) {
            task.remindDate     =   date;
        }
        
    }
    
    //  save the task:
    
    BOOL saved                  =   [task save];
    
    if (saved) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showTaskNotSavedAlert];
    }
    
}

- (void)showTaskNotSavedAlert {
    
    UIAlertController *alert    =   [UIAlertController alertControllerWithTitle:@"Error" message:@"There was an error saving your task." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

/*
 *
 *      Name: Remove Task
 *      Desc: This action will be called when we want to delete the task
 *
 */

- (IBAction)actionRemove:(UIButton *)sender {
    
    if (!self.task) {
        return;
    }
    
    UIAlertController *alert    =   [UIAlertController alertControllerWithTitle:@"Remove Task" message:@"Are you sure you want to remove this task?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self.task remove];
        [self.navigationController popViewControllerAnimated:YES];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

/*
 *      Name: Dismiss
 *      Desc: Dismisses the current controller
 */

- (IBAction)actionDismiss:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 *      Name: Date to string
 *      Desc: Converts an NSDate object to a string
 */

- (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy - HH:mm";
    return [formatter stringFromDate:date];
}

/*
 *      Name: String to Date
 *      Desc: Converts an NSString to an NSDate object
 */

- (NSDate *)stringToDate:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy - HH:mm";
    return [formatter dateFromString:string];
}

@end
