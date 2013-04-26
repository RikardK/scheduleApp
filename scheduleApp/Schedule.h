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
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *course;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *whatToRead;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *type;

-(id)initWithRoom:(NSUInteger) room teacher:(NSString *)teacher course:(NSString *)course time:(NSString *)time whatToRead:(NSString *)whatToRead message:(NSString *)message;
@end
