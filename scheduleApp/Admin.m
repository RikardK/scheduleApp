//
//  Admin.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "Admin.h"

@implementation Admin

-(id)init
{
    return [self initWithFirstName:@"" lastName:@"" email:@""];
}

-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email
{
    self = [super init];
    
    if (self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
        self.type = @"Admin";
    }
    
    return self;
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"\nFirst name: %@\nLast name: %@\nE-mail: %@\nType: %@", self.firstName, self.lastName, self.email, self.type];
}
@end
