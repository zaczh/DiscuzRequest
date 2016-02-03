//
//  DiscuzRequestTests.m
//  DiscuzRequest
//
//  Created by zhang on 2/3/16.
//  Copyright © 2016 zaczh. All rights reserved.
//

#import "DiscuzRequestTests.h"
#import "S1NetworkManager.h"

static CGFloat APIRequestTimeoutInterval = 20.0;

@implementation DiscuzRequestTests
- (void)setUp {
    [S1NetworkManager cancelAllRequests];
}

- (void)test_requestTopicListAPIForKey_withPage_ {
    XCTestExpectation *expectation = [self expectationWithDescription:@"requestTopicListAPIForKey"];
    
    [S1NetworkManager requestTopicListAPIForKey:@"75" withPage:@1 success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"success responds: %@", responseObject);
        [expectation fulfill];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"fail");
        XCTFail(@"bad response from server, error info: %@", error);
        
    }];
    
    [self waitForExpectationsWithTimeout:APIRequestTimeoutInterval handler:^(NSError * _Nullable error) {
        
        if (error != nil) {
            XCTFail(@"timeout error: %@", error);
        }
        
    }];
}
@end
