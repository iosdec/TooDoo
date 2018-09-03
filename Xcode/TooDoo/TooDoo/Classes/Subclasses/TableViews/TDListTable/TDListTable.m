//
//  TDListTable.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "TDListTable.h"
#import "TDTaskTableViewCell.h"
#import "TaskVC.h"

@implementation TDListTable

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.is_setup) {
        [self setupTableView];
        self.is_setup = YES;
    }
}

- (void)setupTableView {
    self.delegate               =   self;
    self.dataSource             =   self;
}

#pragma mark    -   UITableView Data Source:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[TDAPI allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tv_id      =   @"id_task";
    static NSString *tv_nib     =   @"TDTaskTableViewCell";
    
    TDTaskTableViewCell *cell   =   (TDTaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tv_id];
    if (!cell) {
        NSArray *nib_arr = [[NSBundle mainBundle] loadNibNamed:tv_nib owner:self options:nil];
        if (nib_arr.count != 0) {
            cell = [nib_arr objectAtIndex:0];
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(TDTaskTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *tasks              =   [TDAPI allItems];
    
    if (tasks.count == 0) {
        return;
    }
    
    [cell setupWithTask:tasks[indexPath.row]];
    
}

#pragma mark    -   UITableView Delegate:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TDTaskTableViewCell *cell       =   (TDTaskTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell.task) { return; }
    UIViewController *controller    =   [self viewController];
    if (!controller) { return; }
    
    TaskVC *vc                      =   [controller.storyboard instantiateViewControllerWithIdentifier:kSBID_Task];
    vc.task                         =   cell.task;
    [controller.navigationController pushViewController:vc animated:YES];
    
}

- (UIViewController *)viewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    } return (UIViewController *)responder;
}

@end
