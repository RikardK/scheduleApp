//
//  AdminService.h
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/30/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Schedule.h"

typedef void(^OnCompletion)(NSURLResponse *response, NSData *data, NSError *error);

@interface AdminService : NSObject

-(void)getScheduleWithId:(NSString *)scheduleId onCompletion:(OnCompletion)callback;
-(void)addNewSchedule:(Schedule *)schedule onCompletion:(OnCompletion)callback;
-(void)updateScheduleWithId:(NSString *)scheduleId andRev:(NSString *)scheduleRev withValue:(NSString *)value forKey:(NSString *)key onCompletion:(OnCompletion)callback;

@end
