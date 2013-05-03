//
//  AdminService.h
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/30/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Schedule.h"

typedef void(^OnCompletion1)(NSURLResponse *response, NSData *data, NSError *error);

@interface AdminService : NSObject

-(void)addNewSchedule:(Schedule *)schedule onCompletion:(OnCompletion1)callback;
-(void)updateScheduleWithId:(NSString *)scheduleId andRev:(NSString *)scheduleRev withValue:(NSString *)value forKey:(NSString *)key onCompletion:(OnCompletion1)callback;
-(BOOL)sendMessage:(NSString *)message toStudentWithId:(NSString *)studentId onCompletion:(OnCompletion1)callback;
-(BOOL)sendMessage:(NSString *)message toAllStudents:(NSArray *)documentIds onCompletion:(OnCompletion1)callback;

@end
