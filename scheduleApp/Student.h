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
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray *courses;


-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age courses:(NSString *)courses email:(NSString *)email address:(NSString *)address;



@end
