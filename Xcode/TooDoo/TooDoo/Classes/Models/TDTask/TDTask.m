//
//  TDTask.m
//  TooDoo
//
//  Created by R3V0 on 30/08/2018.
//  Copyright © 2018 iosdec. All rights reserved.
//

#import "TDTask.h"
#import <UserNotifications/UserNotifications.h>

@implementation TDTask

#pragma mark    -   NSCoding:

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.objectId forKey:@"objectId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.subtitle forKey:@"subtitle"];
    [aCoder encodeBool:self.completed forKey:@"completed"];
    [aCoder encodeObject:self.remindDate forKey:@"remindDate"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.objectId = [aDecoder decodeObjectForKey:@"objectId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
        self.completed = [aDecoder decodeBoolForKey:@"completed"];
        self.remindDate = [aDecoder decodeObjectForKey:@"remindDate"];
    } return self;
}

#pragma mark    -   Functions:

/*
 *      Name: Save
 *      Desc: Saves the task to the documents directory
 *      Note: the reason we're saving to the documents directory,
 *      is that we can encrypt the file.
 */

- (BOOL)save {
    
    //  first, let's check if the task has an objectId
    //  this will be unique to each task and will be used
    //  as the file name.. if it doesn't exist.. generate it
    
    if (!self.objectId) {
        [self generateRandomObjectId:10];
    }
    
    //  update notification settings:
    [self updateNotificationSettings];
    
    //  instead of saving directly in the documents directory
    //  we'll create a folder called "Tasks"
    //  only if it don't exist..
    
    NSString *documents             =   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *tasks                 =   [documents stringByAppendingPathComponent:@"Tasks"];
    NSFileManager *manager          =   [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:tasks]) {
        [manager createDirectoryAtPath:tasks withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //  now let's save the task object into the tasks directory:
    NSString *file_name             =   [NSString stringWithFormat:@"%@.task", self.objectId];
    NSString *file_path             =   [tasks stringByAppendingPathComponent:file_name];
    BOOL saved                      =   [NSKeyedArchiver archiveRootObject:self toFile:file_path];
    [self taskUpdated];
    return saved;
    
}

/*
 *      Name: Generate Random Object Id:
 *      Desc: Generates a random string with a given length
 *      and sets ths objectId to this value.
 */

- (void)generateRandomObjectId:(int)length {
    NSMutableString *string = [NSMutableString stringWithCapacity:length];
    for (int i = 0; i < length; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(26))];
    } self.objectId = string;
}

/*
 *
 *      Name: Check
 *      Desc: Sets the current task as completed
 *      Note: We've created a function for this because now we can save the task
 *      in the same function
 *
 */

- (void)check {
    self.completed = YES;
    [self save];
}

/*
 *
 *      Name: Uncheck
 *      Desc: Sets the current task as uncompleted
 *      Note: We've created a function for this because now we can save the task
 *      in the same function
 *
 */

- (void)uncheck {
    self.completed = NO;
    [self save];
}

/*
 *
 *      Name: Remove
 *      Desc: Deletes the current task from the task list
 *
 */

- (BOOL)remove {
    
    //  check if we have an objectId .. if not we can't remove it
    //  because it doesn't exist
    
    if (!self.objectId) { return NO; }
    
    //  remove pending notifications:
    [self checkForNotificationAndRemove];
    
    //  create the path:
    NSString *documents     =   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *tasks         =   [documents stringByAppendingPathComponent:@"Tasks"];
    NSString *file_name     =   [NSString stringWithFormat:@"%@.task", self.objectId];
    NSString *file_path     =   [tasks stringByAppendingPathComponent:file_name];
    NSFileManager *manager  =   [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:file_path]) {
        BOOL removed        =   [manager removeItemAtPath:file_path error:nil];
        [self taskUpdated];
        return removed;
    } else {
        return NO;
    }
    
}

/*
 *
 *      Name: Task Updated:
 *      Desc: Send task updated notification
 *
 */

- (void)taskUpdated {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNO_TaskChanged object:self];
}

/*
 *      Name: Update Notification settings
 *      Desc: Checks the local notification system for a scheduled date
 */

- (void)updateNotificationSettings {
    
    //  if the date is set.. then let's request user notification access:
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    if (self.remindDate) {
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
        
    }
    
    //  get pending notifications, and if the date is not set.. then remove
    //  the pending notification
    
    [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        
        for (UNNotificationRequest *request in requests) {
            if ([request.identifier isEqualToString:self.objectId]) {
                if (!self.remindDate) {
                    [center removePendingNotificationRequestsWithIdentifiers:@[self.objectId]];
                }
            }
        }
        
    }];
    
    //  if the date is set.. then let's create a notification:
    
    if (self.remindDate) {
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        
        //  check the information that we have..
        
        if (self.name && self.subtitle) {
            [content setTitle:self.name];
            [content setBody:self.subtitle];
        }
        
        if (self.name && !self.subtitle) {
            [content setTitle:@"TooDoo - Reminder"];
            [content setBody:self.name];
        }
        
        //  set sound:
        [content setSound:[UNNotificationSound defaultSound]];
        
        //  get components from the trigger date
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:self.remindDate];
        
        //  create a trigger:
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
        
        //  create a request:
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:self.objectId content:content trigger:trigger];
        
        //  add to center:
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"error adding notification : %@", error);
            } else {
                NSLog(@"notification added");
            }
            
        }];
        
    }
    
}

/*
 *      Name: Check for notification and remove
 *      Desc: Called when the user deletes a task .. we must then
 *      check for local notifications and remove if it exists..
 */

- (void)checkForNotificationAndRemove {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        for (UNNotificationRequest *request in requests) {
            if ([request.identifier isEqualToString:self.objectId]) {
                [center removePendingNotificationRequestsWithIdentifiers:@[self.objectId]];
            }
        }
    }];
    
}

@end
