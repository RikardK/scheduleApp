//
//  main.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Schedule.h"
#import "StudentService.h"
#import "ScheduleService.h"
#import "Admin.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        StudentService *studentService = [[StudentService alloc] init];
        //ScheduleService *scheduleService = [[ScheduleService alloc] init];
       
        Admin *admin = [[Admin alloc]
                        initWithFirstName:@"Admin"
                        lastName:@"Master"
                        email:@"master@admin.com"];
        
        NSLog(@"%@", admin);
        
        Student *student1 = [[Student alloc] init];
        NSLog(@"Student: %@", student1);
        
        Student *student2 = [[Student alloc]
                             initWithFirstName:@"Rikard"
                             lastName:@"Karlsson"
                             age:24
                             email:@"rikard88karlsson@gmail.com"
                             address:@"Tackjärnsvägen 13, 168 68 Bromma"];
        
        NSLog(@"%@", student2);
        
        Schedule *schedule = [[Schedule alloc] init];
        NSLog(@"%@", schedule);
        
        Schedule *schedule2 = [[Schedule alloc] initWithRoom:142 teacher:@"Anders Carlsson" course:@"App development" time:@"2013-04-24 09:15:00 +0000" whatToRead:@"Chapter 12 and 13 (Objective-C)" message:@"Important, read chapter 12 twice."];
        NSLog(@"%@", schedule2);
        
        
        // ----------Testing----------
        
        // adding student
        [studentService addStudent:student2 onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            NSMutableDictionary *studentData = [[NSMutableDictionary alloc] init];
            studentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSString *studentId = [studentData objectForKey:@"id"];
            
            // getting student
            [studentService getStudentWithId:studentId onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                NSMutableDictionary *studentData2 = [[NSMutableDictionary alloc] init];
                studentData2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                NSLog(@"%@", [studentData2 objectForKey:@"Courses"]);
            }];
            
        }];
    }
    
    [[NSRunLoop currentRunLoop] run];
    return 0;
}

