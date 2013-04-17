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
-(void)getStudentWithId:(NSString *)studentId;


-(void)addNewScheduleForCourse:(Schedule *)schedule;
-(void)updateSchedule:(Schedule *)schedule;
-(void)sendMessageToAllStudents;
-(void)sendMessageToStudentWithId:(NSString *)student;

@end
