//
//  Schedule.h
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Schedule : NSObject

@property (nonatomic) NSUInteger room;
@property (nonatomic) NSString *teacher;
@property (nonatomic) NSString *course;
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *time;
@property (nonatomic) NSString *whatToRead;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *type;

-(id)initWithRoom:(NSUInteger) room teacher:(NSString *)teacher course:(NSString *)course date:(NSString *)date time:(NSString *)time whatToRead:(NSString *)whatToRead message:(NSString *)message;
@end
