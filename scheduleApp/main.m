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
        
        Student *student1 = [[Student alloc]
                             initWithFirstName:@"Rikard"
                             lastName:@"Karlsson"
                             age:24
                             courses:@"C Programming"
                             email:@"rikard88@karlssongmail.com"
                             address:@"Tackjarnsvagen 13, 16868 Bromma"];

        Student *student2 = [[Student alloc]
                             initWithFirstName:@"Fredrik"
                             lastName:@"Svensson"
                             age:33
                             courses:@"App developement, C Programming"
                             email:@"fredrikS@gmail.com"
                             address:@"Ryttarvagen 12, 17777 Jarfalla"];
        
        Schedule *schedule1 = [[Schedule alloc] initWithRoom:142
                                                     teacher:@"Anders Carlsson"
                                                      course:@"App development"
                                                        date:@"2013-05-03"
                                                        time:@"09.15"
                                                  whatToRead:@"Chapter 12 and 13 (Objective-C)"
                                                     message:@"Important, read chapter 12 twice."];
        
        Schedule *schedule2 = [[Schedule alloc] initWithRoom:110
                                                     teacher:@"Anders Carlsson"
                                                      course:@"C Programming"
                                                        date:@"2013-05-02"
                                                        time:@"09.15"
                                                  whatToRead:@"Chapter 12 (C Programming)"
                                                     message:@"Be prepared and read the chapter carefully."];
        
        Schedule *schedule3 = [[Schedule alloc] initWithRoom:122
                                                     teacher:@"Anders Carlsson"
                                                      course:@"C Programming"
                                                        date:@"2013-04-29"
                                                        time:@"09.15"
                                                  whatToRead:@"Chapter 14 and 15 (Objective-C)"
                                                     message:@"Do the challenge for chapter 15"];
        
        Schedule *schedule4 = [[Schedule alloc] initWithRoom:142
                                                     teacher:@"Anders Carlsson"
                                                      course:@"App development"
                                                        date:@"2013-04-30"
                                                        time:@"09.15"
                                                  whatToRead:@"Chapter 18 (Objective-C)"
                                                     message:@"Read at least twice."];
        
        // ----------Testing----------
        
        // adding student
        [studentService addStudent:student1
                      onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
            
                          NSMutableDictionary *studentData = [[NSMutableDictionary alloc] init];
                          studentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                          NSString *studentId = [studentData objectForKey:@"id"];
                          NSLog(@"\n\n---------- RESPONSE FROM ADDING A STUDENT ----------\n %@\n", studentData);
                          
                          // Lägger till i array
                          [documentIds addObject:studentId];
                          
                          
                [studentService addStudent:student2
                              onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                    NSMutableDictionary *studentData = [[NSMutableDictionary alloc] init];
                    studentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSString *studentId2 = [studentData objectForKey:@"id"];
                    NSLog(@"\n\n---------- RESPONSE FROM ADDING ANOTHER STUDENT ----------\n %@\n", studentData);
                    
                    [documentIds addObject:studentId2];

            // getting student
            [studentService getStudentWithId:studentId
                                onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                    NSMutableDictionary *studentData2 = [[NSMutableDictionary alloc] init];
                                    studentData2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                    NSLog(@"\n\n---------- RESPONSE FROM GETTING A STUDENT ----------\n%@\n\n", studentData2);

                // adding new schedule
                [adminService addNewSchedule:schedule1
                                   onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                       NSMutableDictionary *scheduleData = [[NSMutableDictionary alloc] init];
                                       scheduleData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                       NSLog(@"\n\n---------- RESPONSE FROM ADDING A NEW SCHEDULE ----------\n%@\n\n", scheduleData);
                    
                                       NSString *scheduleId = [scheduleData objectForKey:@"id"];
                                       NSString *scheduleRev = [scheduleData objectForKey:@"rev"];
                                       
                                       [documentIds addObject:scheduleId];

                                       
                        [adminService addNewSchedule:schedule2
                                        onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                            NSMutableDictionary *scheduleData2 = [[NSMutableDictionary alloc] init];
                            scheduleData2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                            NSString *scheduleId2 = [scheduleData2 objectForKey:@"id"];
                            
                            [documentIds addObject:scheduleId2];

                        [adminService addNewSchedule:schedule3
                                        onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                            NSMutableDictionary *scheduleData3 = [[NSMutableDictionary alloc] init];
                            scheduleData3 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                            NSString *scheduleId3 = [scheduleData3 objectForKey:@"id"];
                            
                            [documentIds addObject:scheduleId3];

                            [adminService addNewSchedule:schedule4
                                            onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                NSMutableDictionary *scheduleData4 = [[NSMutableDictionary alloc] init];
                                scheduleData4 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                NSString *scheduleId4 = [scheduleData4 objectForKey:@"id"];
                                
                                [documentIds addObject:scheduleId4];

                                sleep(2);
                    // update schedule
                    [adminService updateScheduleWithId:scheduleId
                                                   andRev:scheduleRev
                                                withValue:@"READ READ READ"
                                                   forKey:@"Message"
                                             onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                 
                                                NSMutableDictionary *scheduleIdAndRev = [[NSMutableDictionary alloc] init];
                                                scheduleIdAndRev = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                NSString *newRev = [scheduleIdAndRev objectForKey:@"rev"];
                                                 NSLog(@"\n\n---------- RESPONSE FROM UPDATING SCHEDULE ----------\n %@",scheduleIdAndRev);

                        // updating schedule once again
                        [adminService updateScheduleWithId:scheduleId
                                                       andRev:newRev
                                                    withValue:@"Read chapter 23 twice (Objective-C)"
                                                       forKey:@"What to read"
                                                 onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                     NSLog(@"\n\n---------- RESPONSE FROM UPDATING SCHEDULE AGAIN ----------\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
 
                            // sending message to student
                            [adminService sendMessage:@"Hello! Just a message for you."
                                        toStudentWithId:studentId
                                        onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                            NSLog(@"\n\n---------- RESPONSE FROM SENDING A MESSAGE TO A STUDENT ----------\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
                                            

                                                
                                            

                                            for (int i = 0; i < [documentIds count]; i++) {
                                                
                                                [studentService dailyScheduleFor:studentId
                                                                      documentId:[documentIds objectAtIndex:i]
                                                                    onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                    NSDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                    NSLog(@"\n\n\n\n---------- SCHEDULE FOR TODAY RETURNED ----------\n\n%@", documentData);
                                                }];
                                            }

                                            for (int i = 0; i < [documentIds count]; i++) {
                                                [studentService whatToReadTodayFor:studentId
                                                                        documentId:[documentIds objectAtIndex:i]
                                                                      onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                    NSDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                    NSLog(@"\n\n\n\n---------- WHAT TO READ FOR TODAY RETURNED ----------\n\n%@\n", documentData);
                                                }];
                                            }

                                                [studentService weeklyScheduleFor:studentId
                                                                       documentIds:documentIds
                                                                     onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                    NSDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                    NSLog(@"\n\n\n\n---------- SCHEDULES FOR THE WEEK RETURNED ----------\n\n%@\n", documentData);
                                                }];

                                            

                                                [studentService whatToReadThisWeekFor:studentId
                                                                           documentIds:documentIds
                                                                         onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                                             NSDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                                             NSLog(@"\n\n\n\n---------- WHAT TO READ FOR THE WEEK ----------\n\n%@\n", documentData);
                                                }];
                                            

                                            [adminService sendMessage:@"Just testing 1 2 3"
                                                        toAllStudents:documentIds
                                                         onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                             NSDictionary *documentData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                             NSLog(@"\n\n\n---------- RESPONSE FROM MESSAGE SENT TO ALL STUDENTS ----------\n\n%@", documentData);


                                        }];
                                        }];
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

