//
//  Student.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "Student.h"

@implementation Student

-(id)init
{
    return [self initWithFirstName:@"" lastName:@"" age:0 email:@"" address:@""];
}

-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age email:(NSString *)email address:(NSString *)address
{
    self = [super init];

    if (self) {
        NSString *stringValidation = @"[a-z]*";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[C] %@", stringValidation];
        
        if ([predicate evaluateWithObject:firstName] && [predicate evaluateWithObject:lastName]) {
            self.firstName = firstName;
            self.lastName = lastName;
        } else {
            [NSException raise:@"Invalid format, may only contain letters a through z" format:@"First name: %@ or Last name: %@", firstName, lastName];
        }
        
        self.age = age;
        self.email = email;
        self.address = address;
        self.type = @"Student";
        self.courses = @[@"App development", @"C programming"];
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\n\nFirst name: %@\nLast name: %@\nAge: %lu\nE-mail: %@\nAddress: %@\nType: %@", self.firstName, self.lastName, self.age, self.email, self.address, self.type];
}

@end
