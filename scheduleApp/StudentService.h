//
//  StudentService.h
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@class Schedule;

typedef void(^OnCompletion)(NSURLResponse *response, NSData *data, NSError *error);

@interface StudentService : NSObject

-(NSDictionary *)addStudent:(Student *)student onCompletion:(OnCompletion)callback;
-(NSDictionary *)getStudentWithId:(NSString *)studentId onCompletion:(OnCompletion)callback;
-(Schedule *)dailyScheduleFor:(Student *)studentId;
-(Schedule *)weeklyScheduleFor:(Student *)studentId;
-(NSString *)whatToReadTodayFor:(Student *)studentId;
-(NSString *)whatToReadThisWeekFor:(Student *)studentId;


// Services only and admin can use.

-(BOOL)sendMessageToAllStudents:(NSString *)message;
-(BOOL)sendMessageToStudentWithId:(NSString *)student;

@end
