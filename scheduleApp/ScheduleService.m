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
    NSMutableDictionary *scheduleData;
    NSOperationQueue *queue;
}

-(void)addNewSchedule:(Schedule *)schedule onCompletion:(OnCompletion)callback
{    
    NSError *error;
    queue = [[NSOperationQueue alloc] init];
    scheduleData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
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
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:callback];
}

-(void)getScheduleWithId:(NSString *)scheduleId onCompletion:(OnCompletion)callback
{
    
}

-(void)updateScheduleWithId:(NSString *)scheduleId andRev:(NSString *)scheduleRev withValue:(NSString *)value forKey:(NSString *)key onCompletion:(OnCompletion)callback
{
    queue = [[NSOperationQueue alloc] init];
    NSURL *getUrl = [NSURL URLWithString:[@"http://vibbe747.iriscouch.com/test/" stringByAppendingString:scheduleId]];
    NSMutableURLRequest *getRequest = [[NSMutableURLRequest alloc] initWithURL:getUrl];
    [getRequest setHTTPMethod:@"GET"];
    [getRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [NSURLConnection sendAsynchronousRequest:getRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSString *courseIdString = [scheduleId stringByAppendingString:@"?rev="];
        NSString *idAndRev = [courseIdString stringByAppendingString:scheduleRev];
        NSURL *putUrl = [NSURL URLWithString:[@"http://vibbe747.iriscouch.com/test/" stringByAppendingString:idAndRev]];
        
        NSMutableDictionary *dataToUpdate = [[NSMutableDictionary alloc] init];
        dataToUpdate = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [dataToUpdate setValue:value forKey:key];
        NSData *updatedData = [NSJSONSerialization dataWithJSONObject:dataToUpdate options:0 error:&error];
        
        NSMutableURLRequest *putRequest = [[NSMutableURLRequest alloc] initWithURL:putUrl];
        [putRequest setHTTPMethod:@"PUT"];
        [putRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [putRequest setHTTPBody:updatedData];
        
        [NSURLConnection sendAsynchronousRequest:putRequest queue:queue completionHandler:callback];
    }];
}

@end
