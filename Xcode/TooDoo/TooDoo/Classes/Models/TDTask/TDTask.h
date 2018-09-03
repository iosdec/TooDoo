//
//  TDTask.h
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*  create gloabl notification name that will be called
 *  when the task is saved, removed */

#define kNO_TaskChanged             @"task_changed"

@interface TDTask : NSObject <NSCoding>

/*  randomly generated string */
@property (strong, nonatomic) NSString *objectId;

/*  name of the task */
@property (strong, nonatomic) NSString *name;

/*  description / named subtitle due to naming practices: */
@property (strong, nonatomic) NSString *subtitle;

/*  reminder date / time that the user will be reminded of the task if set: */
@property (strong, nonatomic) NSDate *remindDate;

/*  determine if the task is complete */
@property (nonatomic, assign) BOOL completed;

- (BOOL)save;
- (void)check;
- (void)uncheck;
- (BOOL)remove;

@end
