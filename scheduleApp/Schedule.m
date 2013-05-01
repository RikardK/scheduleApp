//
//  Schedule.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

-(id)init
{
    return [self initWithRoom:0 teacher:@"" course:@"" date:@"" time:@"" whatToRead:@"" message:@""];
}

-(id)initWithRoom:(NSUInteger)room teacher:(NSString *)teacher course:(NSString *)course date:(NSString *)date time:(NSString *)time whatToRead:(NSString *)whatToRead message:(NSString *)message
{
    self = [super init];
    
    if (self) {
        self.room = room;
        self.teacher = teacher;
        self.course = course;
        self.date = date;
        self.time = time;
        self.whatToRead = whatToRead;
        self.message = message;
        self.type = @"Schedule";
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\n\nRoom: %lu\nTeacher: %@\nCourse: %@\nDate: %@\nTime: %@\nWhat to read: %@\nMessage: %@", self.room, self.teacher, self.course, self.date, self.time, self.whatToRead, self.message];
}

@end
