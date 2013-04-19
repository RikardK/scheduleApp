//
//  scheduleServices.h
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/17/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Schedule.h"

@class Schedule;

@interface ScheduleService : NSObject

-(void)addNewSchedule:(Schedule *)schedule;
-(void)updateSchedule:(NSString *)course withValue:(NSString *)value forKey:(NSString *)key;

@end
