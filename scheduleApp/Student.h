//
//  Student.h
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic) NSUInteger age;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *address;


-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age email:(NSString *)email address:(NSString *)address;



@end
