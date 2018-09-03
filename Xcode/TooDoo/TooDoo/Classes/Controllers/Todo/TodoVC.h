//
//  TodoVC.h
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDAPI.h"
#import "TDListTable.h"

@interface TodoVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet TDListTable *tableview;

@end
