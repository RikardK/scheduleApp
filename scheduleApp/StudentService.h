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

@interface StudentService : NSObject

-(NSDictionary *)addStudent:(Student *)student;
-(NSDictionary *)getStudentWithId:(NSString *)studentId;
-(Schedule *)dailyScheduleFor:(Student *)studentId;
-(Schedule *)weeklyScheduleFor:(Student *)studentId;
-(NSString *)whatToReadTodayFor:(Student *)studentId;
-(NSString *)whatToReadThisWeekFor:(Student *)studentId;


// Services only and admin can use.

-(BOOL)sendMessageToAllStudents:(NSString *)message;
-(BOOL)sendMessageToStudentWithId:(NSString *)student;

@end
