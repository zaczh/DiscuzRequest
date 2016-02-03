//
//  S1NetworkManager.m
//  Stage1st
//
//  Created by Zheng Li on 10/3/14.
//  Copyright (c) 2014 Renaissance. All rights reserved.
//

#import "S1NetworkManager.h"

@interface S1NetworkManager ()

@end

static NSString *baseURL = @"http://bbs.saraba1st.com/2b";

@implementation S1NetworkManager
#pragma mark - Topic List
+ (void)requestTopicListForKey:(NSString *)keyID
                      withPage:(NSNumber *)page
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"forum.php?&mod=%@&mobile=%@&fid=%@", @"forumdisplay", @"no", keyID];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

+ (void)requestTopicListAPIForKey:(NSString *)keyID
                         withPage:(NSNumber *)page
                          success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"api/mobile/index.php?&module=%@&version=%@&tpp=%@&submodule=%@&mobile=%@&fid=%@&orderby=%@", @"forumdisplay", @1, @50, @"checkpost", @"no", keyID, @"dblastpost"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

#pragma mark - Content
+ (void)requestTopicContentForID:(NSNumber *)topicID
                      withPage:(NSNumber *)page
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"api/mobile/index.php?&mod=%@&mobile=%@&tid=%@&page=%@", @"viewthread", @"no", topicID, page];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}


+ (void)requestTopicContentAPIForID:(NSNumber *)topicID
                           withPage:(NSNumber *)page
                            success:(void (^)(NSURLSessionDataTask *, id))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"api/mobile/index.php?&module=%@&version=%@&ppp=%@&submodule=%@&mobile=%@&tid=%@&page=%@", @"forumdisplay", @1, @30, @"checkpost", @"no", topicID, page];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

#pragma mark - Check Login State

+ (void)checkLoginStateAPIwithSuccessBlock:(void (^)(NSURLSessionDataTask *, id))success
                              failureBlock:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"api/mobile/?module=%@", @"login"];//is it a typo?
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

#pragma mark - Login

+ (void)postLoginForUsername:(NSString *)username
                 andPassword:(NSString *)password
                     success:(void (^)(NSURLSessionDataTask *, id))success
                     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *url = @"member.php?mod=logging&action=login&loginsubmit=yes&infloat=yes&lssubmit=yes&inajax=1";
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSString *bodyData = [NSString stringWithFormat:@"fastloginfield=%@&username=%@&password=%@&handlekey=%@&quickforward=%@&cookietime=%@", @"username",
                          [username stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],
                          [password stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]], @"ls", @"yes", @"2592000"];
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

+ (void)requestLogoutCurrentAccountWithFormhash:(NSString *)formhash
                                        success:(void (^)(NSURLSessionDataTask *, id))success
                                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    NSString *url = [NSString stringWithFormat:@"member.php?mod=%@&action=%@&formhash=%@", @"logging", @"logout", formhash];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}


#pragma mark - Reply

+ (void)requestReplyRefereanceContentForTopicID:(NSNumber *)topicID
                                       withPage:(NSNumber *)page
                                        floorID:(NSNumber *)floorID
                                        forumID:(NSNumber *)forumID
                                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"mod": @"post",
                             @"action": @"reply",
                             @"fid": forumID,
                             @"tid": topicID,
                             @"repquote": floorID,
                             @"extra": @"",
                             @"page": page,
                             @"infloat": @"yes",
                             @"handlekey": @"reply",
                             @"inajax": @1,
                             @"ajaxtarget": @"fwin_content_reply"};
    
    NSMutableArray *queries = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = obj;
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }
        else {
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *query = [queries componentsJoinedByString:@"&"];
    NSString *url = [NSString stringWithFormat:@"member.php?%@", query];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

+ (void)postReplyForTopicID:(NSNumber *)topicID
                   withPage:(NSNumber *)page
                    forumID:(NSNumber *)forumID
                  andParams:(NSDictionary *)params
                    success:(void (^)(NSURLSessionDataTask *, id))success
                    failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"forum.php?mod=post&infloat=yes&action=reply&fid=%@&extra=page%%3D%@&tid=%@&replysubmit=yes&inajax=1", forumID, page, topicID];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSMutableArray *queries = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = obj;
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }
        else {
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *bodyData = [queries componentsJoinedByString:@"&"];
    
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

+ (void)postReplyForTopicID:(NSNumber *)topicID
                    forumID:(NSNumber *)forumID
                  andParams:(NSDictionary *)params
                    success:(void (^)(NSURLSessionDataTask *, id))success
                    failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"forum.php?mod=post&action=reply&fid=%@&tid=%@&extra=page%%3D1&replysubmit=yes&infloat=yes&handlekey=fastpost&inajax=1", forumID, topicID];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableArray *queries = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = obj;
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }
        else {
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *bodyData = [queries componentsJoinedByString:@"&"];
    
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}


#pragma mark - Redirect (Not Finish)
+ (void)findTopicFloor:(NSNumber *)floorID
             inTopicID:(NSNumber *)topicID
               success:(void (^)(NSURLSessionDataTask *, id))success
               failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSDictionary *params = @{@"mod" : @"redirect",
                             @"goto" : @"findpost",
                             @"pid" : floorID,
                             @"ptid" : topicID};
    
    NSMutableArray *queries = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = obj;
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }
        else {
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *query = [queries componentsJoinedByString:@"&"];
    NSString *url = [NSString stringWithFormat:@"forum.php?%@", query];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}


#pragma mark - Search

+ (void)postSearchForKeyword:(NSString *)keyword
                 andFormhash:(NSString *)formhash
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if (formhash == nil) { return; }
    
    NSString *url = @"search.php?searchsubmit=yes";
    NSDictionary *params = @{@"mod" : @"forum",
                             @"formhash" : formhash,
                             @"srchtype" : @"title",
                             @"srhfid" : @"",
                             @"srhlocality" : @"forum::index",
                             @"srchtxt" : keyword,
                             @"searchsubmit" : @"true"};
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableArray *queries = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = obj;
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }
        else {
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *bodyData = [queries componentsJoinedByString:@"&"];
    
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}
//http://bbs.saraba1st.com/2b/search.php?mod=forum&searchid=706&orderby=lastpost&ascdesc=desc&searchsubmit=yes&page=2
+ (void)requestSearchResultPageForSearchID:(NSString *)searchID
                                  withPage:(NSNumber *)page
                                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"mod" : @"forum",
                             @"searchid" : searchID,
                             @"orderby" : @"lastpost",
                             @"ascdesc" : @"desc",
                             @"page" : page,
                             @"searchsubmit" : @"yes"};
    
    NSMutableArray *queries = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = obj;
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }
        else {
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *query = [queries componentsJoinedByString:@"&"];
    NSString *url = [NSString stringWithFormat:@"search.php?%@", query];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}
#pragma mark - User Info

+ (void)requestThreadListForID:(NSNumber *)userID
                       andPage:(NSNumber *)page
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"mod" : @"space",
                             @"uid" : userID,
                             @"do" : @"thread",
                             @"view" : @"me",
                             @"from" : @"space",
                             @"type" : @"thread",
                             @"page" : page,
                             @"order" : @"dateline"};
    
    NSMutableArray *queries = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = obj;
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }
        else {
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *query = [queries componentsJoinedByString:@"&"];
    NSString *url = [NSString stringWithFormat:@"home.php?%@", query];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

+ (void)requestReplyListForID:(NSNumber *)userID
                      andPage:(NSNumber *)page
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"mod" : @"space",
                             @"uid" : userID,
                             @"do" : @"thread",
                             @"view" : @"me",
                             @"from" : @"space",
                             @"type" : @"reply",
                             @"page" : page,
                             @"order" : @"dateline"};
    
    NSMutableArray *queries = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = obj;
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }
        else {
            [queries addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *query = [queries componentsJoinedByString:@"&"];
    NSString *url = [NSString stringWithFormat:@"home.php?%@", query];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:baseURL]]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (success != nil) {
                success(task, data);
            }
        }
        else {
            if (failure != nil) {
                failure(task, error);
            }
        }
    }];
    [task resume];
}

#pragma mark - Cancel
+ (void) cancelRequest
{
    [[NSURLSession sharedSession] getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        // NSLog(@"%lu,%lu,%lu",(unsigned long)dataTasks.count, (unsigned long)uploadTasks.count, (unsigned long)downloadTasks.count);
        for (NSURLSessionDataTask* task in downloadTasks) {
            [task cancel];
        }
        for (NSURLSessionDataTask* task in dataTasks) {
            [task cancel];
        }
    }];
    
    [[NSURLSession sharedSession] getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        // NSLog(@"%lu,%lu,%lu",(unsigned long)dataTasks.count, (unsigned long)uploadTasks.count, (unsigned long)downloadTasks.count);
        for (NSURLSessionDataTask* task in downloadTasks) {
            [task cancel];
        }
        for (NSURLSessionDataTask* task in dataTasks) {
            [task cancel];
        }
    }];
}

@end
