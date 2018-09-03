//
//  TDTaskTableViewCell.h
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDTask.h"

@interface TDTaskTableViewCell : UITableViewCell

- (void)setupWithTask:(TDTask *)task;

@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkedImage;

@property (nonatomic, assign) BOOL isChecked;
@property (strong, nonatomic) TDTask *task;

@end
