//
//  scheduleServices.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/17/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "ScheduleService.h"

@implementation ScheduleService
{
    NSDictionary *scheduleData;
    NSOperationQueue *queue;
    
    NSMutableDictionary *schedules;
}

-(void)addNewSchedule:(Schedule *)schedule
{
//    schedules = [[NSMutableDictionary alloc] init];
//    [schedules setObject:schedule forKey:schedule.course];
    
    NSError *error;
    queue = [[NSOperationQueue alloc] init];
    scheduleData = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSString stringWithFormat:@"%lu", schedule.room], @"Room",
                    schedule.teacher, @"Teacher",
                    schedule.course, @"Course",
                    schedule.time, @"Time",
                    schedule.whatToRead, @"What to read",
                    schedule.message, @"Message",
                    schedule.type, @"Type",
                    nil];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:scheduleData options:0 error:&error];
    NSURL *url = [NSURL URLWithString:@"http://vibbe747.iriscouch.com/test/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
    }];
}


// Need to replace what u send in and not remove everything else.
-(void)updateSchedule:(NSString *)course withValue:(NSString *)value forKey:(NSString *)key
{
    queue = [[NSOperationQueue alloc] init];
    NSError *error;
    NSDictionary *updateData = [[NSDictionary alloc] initWithObjectsAndKeys: value, key, nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:updateData options:0 error:&error];
    NSURL *url = [NSURL URLWithString:[@"http://vibbe747.iriscouch.com/test/" stringByAppendingString:course]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
    }];
    
}

@end
