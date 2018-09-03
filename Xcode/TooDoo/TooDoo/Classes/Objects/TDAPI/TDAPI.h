//
//  TDAPI.h
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TDTask.h"
#import "UITextField+Extensions.h"
#import "storyboard_ids.h"

@interface TDAPI : NSObject

+ (NSArray *)allItems;
+ (NSArray *)completedItems;
+ (NSArray *)uncompletedItems;

@end
