//
//  main.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Student *student1 = [[Student alloc] init];
        NSLog(@"Student: %@", student1);
        Student *student2 = [[Student alloc] initWithFirstName:@"Rikard" lastName:@"Karlsson" age:24 email:@"rikard88karlsson@gmail.com" address:@"Tackjärnsvägen 13, 168 68 Bromma"];
        NSLog(@"%@", student2);
    }
    return 0;
}

