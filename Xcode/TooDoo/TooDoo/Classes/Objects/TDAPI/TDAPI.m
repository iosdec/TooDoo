//
//  TDAPI.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "TDAPI.h"

@implementation TDAPI

/*
 *      Name: All Items
 *      Desc: Returns an array of all TDTask objects
 */

+ (NSArray *)allItems {
    
    //  here.. we will create a file manager, and for all
    //  files, we will initialise them into TDTasks and
    //  return them if they're valid:
    
    NSMutableArray *tasks           =   [[NSMutableArray alloc] init];
    NSFileManager *manager          =   [NSFileManager defaultManager];
    NSString *documents             =   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *tasks_path            =   [documents stringByAppendingPathComponent:@"Tasks"];
    
    //  if tasks doesn't exist.. there will be no tasks in it,
    //  so return an empty array (we will use the count):
    
    if (![manager fileExistsAtPath:tasks_path]) {
        return tasks;
    }
    
    //  let's get the contents of the tasks path:
    //  if the contents are empty.. return blank array again:
    
    NSArray *tasks_contents         =   [manager contentsOfDirectoryAtPath:tasks_path error:nil];
    
    if (tasks_contents.count == 0) {
        return tasks;
    }
    
    //  now.. tasks_contents contains file names..
    //  we need to run a for loop and initialise these into TDTasks
    //  and add them to our tasks array if they are valid..
    
    for (NSString *file_name in tasks_contents) {
        
        NSString *file_path         =   [tasks_path stringByAppendingPathComponent:file_name];
        NSData *task_data           =   [NSKeyedUnarchiver unarchiveObjectWithFile:file_path];
        TDTask *task                =   (TDTask *)task_data;
        
        if (task) {
            [tasks addObject:task];
        }
        
    }
    
    return tasks;
    
}

/*
 *      Name: Completed Items:
 *      Desc: Returns an array (TDTask objects) that are completed
 */

+ (NSArray *)completedItems {
    
    NSMutableArray *tasks           =   [[NSMutableArray alloc] init];
    
    //  first.. we can use our previous function (allItems) to get
    //  all of our tasks into an array:
    
    NSArray *all_items              =   [self allItems];
    
    //  now check the count and return an empty array if there's
    //  nothing in it:
    
    if (all_items.count == 0) {
        return tasks;
    }
    
    //  now.. let's create a for loop, and check if the task is completed
    //  then add to our tasks array:
    
    for (TDTask *task in all_items) {
        if (task.completed) {
            [tasks addObject:task];
        }
    }
    
    return tasks;
    
}

/*
 *      Name: Uncompleted Items:
 *      Desc: Returns an array (TDTask objects) that are uncompleted
 */

+ (NSArray *)uncompletedItems {
    
    //  we will use the same structure as before.. but do it
    //  for uncompleted items:
    
    NSMutableArray *tasks           =   [[NSMutableArray alloc] init];
    NSArray *all_items              =   [self allItems];
    
    if (all_items.count == 0) {
        return tasks;
    }
    
    for (TDTask *task in all_items) {
        if (!task.completed) {
            [tasks addObject:task];
        }
    }
    
    return tasks;
    
}

@end
