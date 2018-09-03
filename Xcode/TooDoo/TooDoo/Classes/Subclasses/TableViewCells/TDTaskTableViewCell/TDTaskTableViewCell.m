//
//  TDTaskTableViewCell.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "TDTaskTableViewCell.h"

@implementation TDTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupWithTask:(TDTask *)task {
    
    if (!task) { return; }
    
    self.task = task;
    
    if (task.name) {
        self.titleLabel.text = task.name;
    }
    if (task.subtitle) {
        self.subtitleLabel.text = task.subtitle;
    }
    
    //  check completion:
    if (task.completed) {
        self.checkedImage.image = [UIImage imageNamed:@"misc_checked.png"];
    } else {
        self.checkedImage.image = [UIImage imageNamed:@"misc_unchecked.png"];
    }
    
}

@end
