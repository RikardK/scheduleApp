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

-(BOOL)addStudent:(Student *)student onCompletion:(OnCompletion)callback;
-(NSDictionary *)getStudentWithId:(NSString *)studentId onCompletion:(OnCompletion)callback;
-(Schedule *)dailyScheduleFor:(NSString *)studentId documentId:(NSString *)documentId onCompletion:(OnCompletion)callback;
-(Schedule *)weeklyScheduleFor:(NSString *)studentId onCompletion:(OnCompletion)callback;
-(NSString *)whatToReadTodayFor:(NSString *)studentId onCompletion:(OnCompletion)callback;
-(NSString *)whatToReadThisWeekFor:(NSString *)studentId onCompletion:(OnCompletion)callback;

@end
