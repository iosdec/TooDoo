//
//  TDListTable.h
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDAPI.h"

@interface TDListTable : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL is_setup;

- (void)setupTableView;

@end
