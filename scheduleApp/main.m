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
#import "AdminService.h"

int main(int argc, const char * argv[])
{
    // hämta alla och loopa igenom för att hitta datum och rätt kurs. samma sak för what to read.

    @autoreleasepool {
        NSMutableArray *documentIds = [[NSMutableArray alloc] init];
        
        StudentService *studentService = [[StudentService alloc] init];
        
        AdminService *adminService = [[AdminService alloc] init];
       
        /*Admin *admin = [[Admin alloc]
                        initWithFirstName:@"Admin"
                        lastName:@"Master"
                        email:@"master@admin.com"];*/
        
        Student *student2 = [[Student alloc]
                             initWithFirstName:@"Rikard"
                             lastName:@"Karlsson"
                             age:24
                             email:@"rikard88@karlssongmail.com"
                             address:@"Tackjarnsvagen 13, 16868 Bromma"];
        
        Schedule *schedule2 = [[Schedule alloc] initWithRoom:142
                                                     teacher:@"Anders Carlsson"
                                                      course:@"App development"
                                                        date:@"2013-05-02"
                                                        time:@"09.15"
                                                  whatToRead:@"Chapter 12 and 13 (Objective-C)"
                                                     message:@"Important, read chapter 12 twice."];
        
        Schedule *schedule3 = [[Schedule alloc] initWithRoom:110
                                                     teacher:@"Anders Carlsson"
                                                      course:@"C Programming"
                                                        date:@"2013-05-03"
                                                        time:@"09.15"
                                                  whatToRead:@"Chapter 12"
                                                     message:@"Be prepared and read the chapter carefully."];
        
        Schedule *schedule4 = [[Schedule alloc] initWithRoom:122
                                                     teacher:@"Anders Carlsson"
                                                      course:@"App development"
                                                        date:@"2013-05-04"
                                                        time:@"09.15"
                                                  whatToRead:@"Chapter 14 and 15 (Objective-C)"
                                                     message:@"Do the challenge for chapter 15"];
        
        Schedule *schedule5 = [[Schedule alloc] initWithRoom:142
                                                     teacher:@"Anders Carlsson"
                                                      course:@"App development"
                                                        date:@"2013-05-07"
                                                        time:@"09.15"
                                                  whatToRead:@"Chapter 18 (Objective-C)"
                                                     message:@"Read at least twice."];
        
        // ----------Testing----------
        
        // adding student
        [studentService addStudent:student2
                      onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
            
                          NSMutableDictionary *studentData = [[NSMutableDictionary alloc] init];
                          studentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                          NSString *studentId = [studentData objectForKey:@"id"];
                          NSLog(@"\n\nResponse data from adding a student:\n %@", studentData);
                          
                          [documentIds addObject:studentId];
            
            // getting student
            [studentService getStudentWithId:studentId
                                onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                    NSMutableDictionary *studentData2 = [[NSMutableDictionary alloc] init];
                                    studentData2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                    NSLog(@"\n\nResponse data from getting a student:\n%@\n\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                
                // adding new schedule
                [adminService addNewSchedule:schedule2
                                   onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                       NSMutableDictionary *scheduleData = [[NSMutableDictionary alloc] init];
                                       scheduleData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                       NSLog(@"\n\nResponse from adding new schedule:\n%@\n\n", scheduleData);
                    
                                       NSString *scheduleId = [scheduleData objectForKey:@"id"];
                                       NSString *scheduleRev = [scheduleData objectForKey:@"rev"];
                                       
                                       [documentIds addObject:scheduleId];
                        [adminService addNewSchedule:schedule3 onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                            NSMutableDictionary *scheduleData2 = [[NSMutableDictionary alloc] init];
                            scheduleData2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                            NSString *scheduleId2 = [scheduleData2 objectForKey:@"id"];
                            [documentIds addObject:scheduleId2];
                        
                        [adminService addNewSchedule:schedule4 onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                            NSMutableDictionary *scheduleData3 = [[NSMutableDictionary alloc] init];
                            scheduleData3 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                            NSString *scheduleId3 = [scheduleData3 objectForKey:@"id"];
                            [documentIds addObject:scheduleId3];
                            
                            [adminService addNewSchedule:schedule5 onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                NSMutableDictionary *scheduleData4 = [[NSMutableDictionary alloc] init];
                                scheduleData4 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                NSString *scheduleId4 = [scheduleData4 objectForKey:@"id"];
                                [documentIds addObject:scheduleId4];


                    
                    // update schedule
                    [adminService updateScheduleWithId:scheduleId
                                                   andRev:scheduleRev
                                                withValue:@"READ READ READ"
                                                   forKey:@"Message"
                                             onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                 
                                                NSMutableDictionary *scheduleIdAndRev = [[NSMutableDictionary alloc] init];
                                                scheduleIdAndRev = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                NSString *newRev = [scheduleIdAndRev objectForKey:@"rev"];
                                                 NSLog(@"\n\nResponse from updating schedule:\n %@",scheduleIdAndRev);
                                                 
                        // updating schedule once again
                        [adminService updateScheduleWithId:scheduleId
                                                       andRev:newRev
                                                    withValue:@"Read chapter 23 twice"
                                                       forKey:@"What to read"
                                                 onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                     NSLog(@"\n\nResponse from updating schedule again:\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
                            
                            // sending message to student
                            [adminService sendMessage:@"Hello! Just a message for you."
                                        toStudentWithId:studentId
                                        onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                            NSLog(@"\n\nMessage sent to student! Response:\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
                                            
                                
                                            for (int i = 0; i < [documentIds count]; i++) {
                                                [studentService dailyScheduleFor:studentId documentId:[documentIds objectAtIndex:i] onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                    NSDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                    
                                                    NSLog(@"\n\nSchedule returned: \n\n%@", documentData);
                                                }];
                                            }
                             
                                        }];
                                    }];
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }
    
    [[NSRunLoop currentRunLoop] run];
    return 0;
}

