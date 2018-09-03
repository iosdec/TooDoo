//
//  TaskVC.h
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDAPI.h"

@interface TaskVC : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScroller;
@property (weak, nonatomic) IBOutlet UISwitch *completedSwitch;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *subtitleField;
@property (weak, nonatomic) IBOutlet UITextField *reminderField;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

@property (strong, nonatomic) TDTask *task;

@end
