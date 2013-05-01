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
        NSString *numberValidation = @"[0-9]{1,7}";
        NSString *emailValidation = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSString *ageValidation = @"[0-9]{2}";
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailValidation];
        NSPredicate *stringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[C] %@", stringValidation];
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberValidation];
        NSPredicate *agePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ageValidation];
        
        NSArray *addressArray = [address componentsSeparatedByString:@", "];
        NSArray *firstPartOfAddress = [[addressArray objectAtIndex:0] componentsSeparatedByString:@" "];
        NSArray *secondPartOfAddress = [[addressArray objectAtIndex:1] componentsSeparatedByString:@" "];
        
        
        if ([stringPredicate evaluateWithObject:firstName] && [stringPredicate evaluateWithObject:lastName]) {
            self.firstName = firstName;
            self.lastName = lastName;
        } else {
            [NSException raise:@"Invalid format, may only contain letters a through z" format:@"First name sent in: %@ or Last name sent in: %@", firstName, lastName];
        }
        
        if ([emailPredicate evaluateWithObject:email]) {
            self.email = email;
        } else {
            [NSException raise:@"Invalid e-mail address, format should be: XXXX@XXX.XX / XXXX@XXXX.XXX" format:@"E-mail address sent in: %@", email];
        }
        
        if ([stringPredicate evaluateWithObject:[firstPartOfAddress objectAtIndex:0]] &&
            [numberPredicate evaluateWithObject:[firstPartOfAddress objectAtIndex:1]] &&
            [numberPredicate evaluateWithObject:[secondPartOfAddress objectAtIndex:0]] &&
            [stringPredicate evaluateWithObject:[secondPartOfAddress objectAtIndex:1]]) {
            self.address = address;
        } else {
            [NSException raise:@"Invalid address, format should be: street name street number, zip code city/town" format:@"Address sent in: %@", address];
        }
        
        if ([agePredicate evaluateWithObject:[NSString stringWithFormat:@"%lu", age]]) {
            self.age = age;
        } else {
            [NSException raise:@"Invalid age!" format:@"Age sent in: %lu", age];
        }
        
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
