//
//  AdminService.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/30/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "AdminService.h"

NSString * const dataBaseURL1 = @"http://vibbe747.iriscouch.com/test/";

@implementation AdminService
{
    NSMutableDictionary *scheduleData;
    NSOperationQueue *queue;
}

-(void)addNewSchedule:(Schedule *)schedule onCompletion:(OnCompletion1)callback
{
    NSError *error;
    queue = [[NSOperationQueue alloc] init];
    scheduleData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                    [NSString stringWithFormat:@"%lu", schedule.room], @"Room",
                    schedule.teacher, @"Teacher",
                    schedule.course, @"Course",
                    schedule.date, @"Date",
                    schedule.time, @"Time",
                    schedule.whatToRead, @"What to read",
                    schedule.message, @"Message",
                    schedule.type, @"Type",
                    nil];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:scheduleData options:0 error:&error];
    NSURL *url = [NSURL URLWithString:dataBaseURL1];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:callback];
}

-(void)updateScheduleWithId:(NSString *)scheduleId andRev:(NSString *)scheduleRev withValue:(NSString *)value forKey:(NSString *)key onCompletion:(OnCompletion1)callback
{
    queue = [[NSOperationQueue alloc] init];
    NSURL *getUrl = [NSURL URLWithString:[dataBaseURL1 stringByAppendingString:scheduleId]];
    NSMutableURLRequest *getRequest = [[NSMutableURLRequest alloc] initWithURL:getUrl];
    [getRequest setHTTPMethod:@"GET"];
    [getRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [NSURLConnection sendAsynchronousRequest:getRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSString *courseIdString = [scheduleId stringByAppendingString:@"?rev="];
        NSString *idAndRev = [courseIdString stringByAppendingString:scheduleRev];
        NSURL *putUrl = [NSURL URLWithString:[dataBaseURL1 stringByAppendingString:idAndRev]];
        
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

-(BOOL)sendMessage:(NSString *)message toStudentWithId:(NSString *)studentId onCompletion:(OnCompletion1)callback
{
    // get request med studentId.
    queue = [[NSOperationQueue alloc] init];
    NSURL *getStudentUrl = [NSURL URLWithString:[dataBaseURL1 stringByAppendingString:studentId]];
    NSMutableURLRequest *getStudentRequest = [[NSMutableURLRequest alloc] initWithURL:getStudentUrl];
    [getStudentRequest setHTTPMethod:@"GET"];
    [getStudentRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    // on completion så skickar jag en put request med uppdaterad message key.
    [NSURLConnection sendAsynchronousRequest:getStudentRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSMutableDictionary *studentData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [studentData setValue:message forKey:@"Message"];
        NSData *updatedMessageData = [NSJSONSerialization dataWithJSONObject:studentData options:0 error:&error];
        
        // put url
        NSString *studentIdString = [studentId stringByAppendingString:@"?rev="];
        NSString *rev = [studentData valueForKey:@"_rev"];
        NSString *idAndRevForStudent = [studentIdString stringByAppendingString:rev];
        NSURL *putStudentUrl = [NSURL URLWithString:[dataBaseURL1 stringByAppendingString:idAndRevForStudent]];
        
        NSMutableURLRequest *putRequest = [[NSMutableURLRequest alloc] initWithURL:putStudentUrl];
        [putRequest setHTTPMethod:@"PUT"];
        [putRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [putRequest setHTTPBody:updatedMessageData];
        [NSURLConnection sendAsynchronousRequest:putRequest queue:queue completionHandler:callback];
    }];
    return true;
}

-(BOOL)sendMessage:(NSString *)message toAllStudents:(NSArray *)documentIds onCompletion:(OnCompletion1)callback
{
    for (int i = 0; i < [documentIds count]; i++) {
        
        NSString *documentId = [documentIds objectAtIndex:i];
        
        queue = [[NSOperationQueue alloc] init];
        NSURL *getStudentUrl = [NSURL URLWithString:[dataBaseURL1 stringByAppendingString:documentId]];
        NSMutableURLRequest *getStudentRequest = [[NSMutableURLRequest alloc] initWithURL:getStudentUrl];
        [getStudentRequest setHTTPMethod:@"GET"];
        [getStudentRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        
        // on completion så skickar jag en put request med uppdaterad message key.
        [NSURLConnection sendAsynchronousRequest:getStudentRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            NSMutableDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if ([[documentData valueForKey:@"Type"] isEqualToString:@"Student"]) {
            
                [documentData setValue:message forKey:@"Message"];
                NSData *updatedMessageData = [NSJSONSerialization dataWithJSONObject:documentData options:0 error:&error];
                
                // put url
                NSString *studentIdString = [documentId stringByAppendingString:@"?rev="];
                NSString *rev = [documentData valueForKey:@"_rev"];
                NSString *idAndRevForStudent = [studentIdString stringByAppendingString:rev];
                NSURL *putStudentUrl = [NSURL URLWithString:[dataBaseURL1 stringByAppendingString:idAndRevForStudent]];
                
                NSMutableURLRequest *putRequest = [[NSMutableURLRequest alloc] initWithURL:putStudentUrl];
                [putRequest setHTTPMethod:@"PUT"];
                [putRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
                [putRequest setHTTPBody:updatedMessageData];
                [NSURLConnection sendAsynchronousRequest:putRequest queue:queue completionHandler:callback];
            }
        }];
    }
    
    return TRUE;
}

@end
