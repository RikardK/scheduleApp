//
//  StudentService.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "StudentService.h"

@implementation StudentService
{
    NSOperationQueue *queue;
    NSDictionary *studentData;
}

-(BOOL)addStudent:(Student *)student onCompletion:(OnCompletion)callback
{
    queue = [[NSOperationQueue alloc] init];
    NSError *error;
    
    
    // Take care of elsewhere?
    NSString *courses = [[NSString alloc] init];
    
    for (NSUInteger i=0; i < [student.courses count]; i++) {
        NSString *course = [student.courses objectAtIndex:i];
        if (i == 0) {
            courses = [courses stringByAppendingString:course];
        } else {
            courses = [courses stringByAppendingString: [@", " stringByAppendingString:course]];
        }
        
    }
    
    studentData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 student.firstName, @"First name",
                                 student.lastName, @"Last name",
                                 student.email, @"E-mail",
                                 student.address, @"Address",
                                 student.type, @"Type",
                                 [NSString stringWithFormat:@"%lu", student.age], @"Age",
                                 courses, @"Courses",
                                 nil
                                 ];
    //
    

    NSData *data = [NSJSONSerialization dataWithJSONObject:studentData options:0 error:&error];
    
    NSURL *url = [NSURL URLWithString:dataBaseURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:callback];
    
    return true;
}

-(NSDictionary *)getStudentWithId:(NSString *)studentId onCompletion:(OnCompletion)callback
{
    queue = [[NSOperationQueue alloc] init];
    
    NSURL *url = [NSURL URLWithString: [dataBaseURL stringByAppendingString:studentId]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:callback];
    
    return nil; //return id, rev. or return bool.
}



-(Schedule *)dailyScheduleFor:(NSString *)studentId documentId:(NSString *)documentId onCompletion:(OnCompletion)callback
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:now];
    
    queue = [[NSOperationQueue alloc] init];
    NSURL *getStudentUrl = [NSURL URLWithString:[dataBaseURL stringByAppendingString:studentId]];
    NSMutableURLRequest *getStudentRequest = [[NSMutableURLRequest alloc] initWithURL:getStudentUrl];
    [getStudentRequest setHTTPMethod:@"GET"];
    [getStudentRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
 
    [NSURLConnection sendAsynchronousRequest:getStudentRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        studentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSString *coursesString = [studentData objectForKey:@"Courses"];
        NSArray *courses = [coursesString componentsSeparatedByString:@", "];
        
        
        for (int i = 0; i < [courses count]; i++) {
    
            NSURL *getDocumentUrl = [NSURL URLWithString:[dataBaseURL stringByAppendingString:documentId]];
            NSMutableURLRequest *getDocumentRequest = [[NSMutableURLRequest alloc] initWithURL:getDocumentUrl];
            [getDocumentRequest setHTTPMethod:@"GET"];
            [getDocumentRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
            
            [NSURLConnection sendAsynchronousRequest:getDocumentRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                NSDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if ([dateString isEqualToString:[documentData objectForKey:@"Date"]]) {
                    if ([[courses objectAtIndex:i] isEqualToString:[documentData objectForKey:@"Course"]]) {
                        callback(response, data, nil);
                    }
                }
            }];
        }
    }];
    return nil; //return the schedule for today.
}

-(Schedule *)weeklyScheduleFor:(NSString *)studentId onCompletion:(OnCompletion)callback
{
    
    return nil;
}

-(NSString *)whatToReadTodayFor:(NSString *)studentId documentId:(NSString *)documentId onCompletion:(OnCompletion)callback
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:now];
    
    queue = [[NSOperationQueue alloc] init];
    NSURL *getStudentUrl = [NSURL URLWithString:[dataBaseURL stringByAppendingString:studentId]];
    NSMutableURLRequest *getStudentRequest = [[NSMutableURLRequest alloc] initWithURL:getStudentUrl];
    [getStudentRequest setHTTPMethod:@"GET"];
    [getStudentRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [NSURLConnection sendAsynchronousRequest:getStudentRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        studentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSString *coursesString = [studentData objectForKey:@"Courses"];
        NSArray *courses = [coursesString componentsSeparatedByString:@", "];
        
        
        for (int i = 0; i < [courses count]; i++) {
            
            NSURL *getDocumentUrl = [NSURL URLWithString:[dataBaseURL stringByAppendingString:documentId]];
            NSMutableURLRequest *getDocumentRequest = [[NSMutableURLRequest alloc] initWithURL:getDocumentUrl];
            [getDocumentRequest setHTTPMethod:@"GET"];
            [getDocumentRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
            
            [NSURLConnection sendAsynchronousRequest:getDocumentRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                NSDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if ([dateString isEqualToString:[documentData objectForKey:@"Date"]]) {
                    if ([[courses objectAtIndex:i] isEqualToString:[documentData objectForKey:@"Course"]]) {
                        NSString *whatToRead = [documentData objectForKey:@"What to read"];
                        NSDictionary *test = [[NSDictionary alloc] initWithObjectsAndKeys:whatToRead, @"What to read", nil];
                        NSData *data2 = [NSJSONSerialization dataWithJSONObject:test options:0 error:&error];
                        callback(response, data2, nil);
                    }
                }
            }];
        }
    }];
    return nil;
}

-(NSString *)whatToReadThisWeekFor:(NSString *)studentId  onCompletion:(OnCompletion)callback
{
    return @"What to read"; //return what to read for the week.
}

@end
