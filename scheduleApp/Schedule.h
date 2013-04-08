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
@property (nonatomic) NSUInteger durationInMin;
@property (nonatomic, copy) NSString *whatToRead;
@property (nonatomic, copy) NSString *message;

-(id)initWithRoom:(NSUInteger) room teacher:(NSString *)teacher course:(NSString *)course durationInMin:(NSUInteger)durationInMIn whatToRead:(NSString *)whatToRead message:(NSString *)message;

@end
