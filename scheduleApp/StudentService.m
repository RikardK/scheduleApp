//
//  StudentService.m
//  scheduleApp
//
//  Created by Rikard Karlsson on 4/8/13.
//  Copyright (c) 2013 Rikard. All rights reserved.
//

#import "StudentService.h"

NSString * const db = @"http://vibbe747.iriscouch.com/test/";

@implementation StudentService
{
    NSDictionary *testjson;
    NSData *testdata;
}

-(NSDictionary *)addStudent:(Student *)student
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSDictionary *studentData = [[NSDictionary alloc]
                         initWithObjectsAndKeys:
                         student.firstName, @"First name",
                         student.lastName, @"Last name",
                         nil];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:studentData options:0 error:&error];
    
    NSURL *url = [NSURL URLWithString:db];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        testjson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"%@", testjson);
        testdata = [NSJSONSerialization dataWithJSONObject:testjson options:NSJSONWritingPrettyPrinted error:NULL];
        [testdata writeToFile:@"/users/vibbe747/desktop/test.json" atomically:YES];
    }];
    return nil;
}

-(void)getStudentWithId:(NSString *)studentId
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURL *url = [NSURL URLWithString: [db stringByAppendingString:studentId]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
}
@end
