//
//  StudentService.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "StudentService.h"

NSString * const db = @"http://vibbe747.iriscouch.com/test/";

@implementation StudentService
{
    NSDictionary *studentData;
    NSData *testdata;
    NSDate *today;
}

-(NSDictionary *)addStudent:(Student *)student onCompletion:(OnCompletion)callback
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
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
    
    NSURL *url = [NSURL URLWithString:db];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:callback];
    
    return nil; //return id, rev.
}

-(NSDictionary *)getStudentWithId:(NSString *)studentId onCompletion:(OnCompletion)callback
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSURL *url = [NSURL URLWithString: [db stringByAppendingString:studentId]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:callback];
    
    return nil; //return id, rev. or return bool.
}

-(Schedule *)dailyScheduleFor:(Student *)studentId
{
    today = [NSDate date];
    NSLog(@"%@", today);
    return nil; //return the schedule for today.
}

-(Schedule *)weeklyScheduleFor:(Student *)studentId
{
    return nil;
}

-(NSString *)whatToReadTodayFor:(Student *)studentId
{
    today = [NSDate date];
    NSLog(@"%@", today);
    return @"What to read"; //return what to read for today.
}

-(NSString *)whatToReadThisWeekFor:(Student *)studentId
{
    return @"What to read"; //return what to read for the week.
}

-(BOOL)sendMessage:(NSString *)message toStudentWithId:(NSString *)student
{
    // GET a student. Update the message key.
    return TRUE;
}

-(BOOL)sendMessageToAllStudents:(NSString *)message
{
    // Loop through all students and set the message.
    return TRUE;
}


@end
