//
//  AdminServiceTest.m
//  AdminServiceTest
//
//  Created by Rikard Karlsson on 5/3/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "AdminServiceTest.h"

@implementation AdminServiceTest
{
    AdminService *adminService;
    Schedule *schedule;
}

- (void)setUp
{
    adminService = [[AdminService alloc] init];
    schedule = [[Schedule alloc] initWithRoom:1001
                                      teacher:@"Anders Carlsson"
                                       course:@"App developement"
                                         date:@"2013-05-10"
                                         time:@"09:15"
                                   whatToRead:@"Read chapter 15"
                                      message:@"Come prepared, please"];
    _isDone = NO;
}

- (void)tearDown
{
    adminService = nil;
}

- (void)testAddNewSchedule
{
    __block NSData *dataForTesting;
    NSError *error;
    
    [adminService addNewSchedule:schedule
                    onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
        dataForTesting = [[NSData alloc] initWithData:data];
        _isDone = YES;
    }];
    
    while (!_isDone) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        NSLog(@"Waiting...");
    }
    
    NSDictionary *returnData = [NSJSONSerialization JSONObjectWithData:dataForTesting options:0 error:&error];
    NSString *testString = [NSString stringWithFormat:@"%@", [returnData valueForKey:@"ok"]];
    STAssertEqualObjects(testString, @"1", @"The value for key 'ok' should be 1(true)");
    
}


@end
