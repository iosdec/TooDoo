//
//  TodoVC.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "TodoVC.h"
#import "TaskVC.h"

@implementation TodoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addReloadHandler];
}

/*
 *      Name: Add Reload Handler
 *      Desc: Add NSNotificationCenter handler that will reload
 *      the table view data
 */

- (void)addReloadHandler {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableview) name:kNO_TaskChanged object:nil];
}

- (void)reloadTableview {
    [self.tableview reloadData];
}

/*
 *      Name: Add Task Action
 *      Desc: Action that's called when the add task button is clicked
 */

- (IBAction)actionAddTask:(UIButton *)sender {
    
    //  here.. we will initialise the AddTaskVC
    //  and push this controller inside the navigation controller:
    
    TaskVC *controller = [self.storyboard instantiateViewControllerWithIdentifier:kSBID_Task];
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
