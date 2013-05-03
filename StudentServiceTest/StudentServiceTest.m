//
//  StudentServiceTest.m
//  StudentServiceTest
//
//  Created by Rikard Karlsson on 5/3/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "StudentServiceTest.h"

@implementation StudentServiceTest
{
    StudentService *studentService;
}

- (void)setUp
{
    studentService = [[StudentService alloc] init];
    _isDone = NO;

}

- (void)tearDown
{
    studentService = nil;
}

- (void)testGetStudent
{
    __block NSData *test;
    NSError *error;
    
    
    // get a real id from the the iriscouch db.
    [studentService getStudentWithId:@"db7f4199c24a785e3912354e6500f73b"
                        onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                            test = [[NSData alloc] initWithData:data];
                            _isDone = YES;
                        }];
    
    while (!_isDone) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        NSLog(@"Waiting...");
    }
    
    NSDictionary *studentData = [NSJSONSerialization JSONObjectWithData:test options:0 error:&error];
    
    STAssertEqualObjects([studentData valueForKey:@"Type"], @"Student", @"If data was returned successfully, the Type key for the document should be equal to 'Student'");
}

@end
