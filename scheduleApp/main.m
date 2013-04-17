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
#import "Admin.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Admin *admin = [[Admin alloc] initWithFirstName:@"Rikard" lastName:@"Karlsson" email:@"rikard88karlsson@gmail.com"];
        NSLog(@"%@", admin);
        
        Student *student1 = [[Student alloc] init];
        NSLog(@"Student: %@", student1);
        
        Student *student2 = [[Student alloc] initWithFirstName:@"Rikard" lastName:@"Karlsson" age:24 email:@"rikard88karlsson@gmail.com" address:@"Tackjärnsvägen 13, 168 68 Bromma"];
        NSLog(@"%@", student2);
        
        Schedule *schedule = [[Schedule alloc] init];
        NSLog(@"%@", schedule);
        
        Schedule *schedule2 = [[Schedule alloc] initWithRoom:142 teacher:@"Anders Carlsson" course:@"App developement" durationInMin:90 whatToRead:@"Chapter 12, 13, 15" message:@"IMPORTANT, read chapter 15 twice and do the challenge"];
        NSLog(@"%@", schedule2);
        
        StudentService *studentService = [[StudentService alloc] init];
        [studentService addStudent:student2];
        //[studentService getStudentWithId:@"6106134d955678e5642fc5c3a7002c01"];
    }
    [[NSRunLoop currentRunLoop] run];
    return 0;
}

