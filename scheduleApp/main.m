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
//        StudentService *studentService = [[StudentService alloc] init];
//        ScheduleService *scheduleService = [[ScheduleService alloc] init];
       
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
        
        Schedule *schedule2 = [[Schedule alloc]
                               initWithRoom:142
                               teacher:@"Anders Carlsson"
                               course:@"App developement"
                               whatToRead:@"Chapter 12, 13, 15"
                               message:@"IMPORTANT! Read chapter 15 twice and complete the challenge"];
        NSLog(@"%@", schedule2);
        
        ScheduleService *scheduleService = [[ScheduleService alloc] init];
        [scheduleService updateSchedule:@"1e70dfed5e6d93ad4fb1e84602004459?rev=1-b5ca1b9511925e723d281d7287f58450" withValue:@"test" forKey:@"Message"];
        

//        [studentService addStudent:student2];
//        [scheduleService addNewSchedule:schedule2];
        
    }
    [[NSRunLoop currentRunLoop] run];
    return 0;
}

