//
//  HeyWatch.m
//  HeyWatch
//
//  Created by Bruno Celeste on 22/10/14.
//  Copyright (c) 2014 HeyWatch. All rights reserved.
//

#import "HeyWatch.h"

@implementation HeyWatch

@synthesize responseData = _responseData;
@synthesize completionBlock = _completionBlock;

+ (void)submit:(NSString *)configContent
    withApiKey:(NSString *)apiKey
      complete:(void (^)(id responseObject, NSError *error))block {

    (void)[[HeyWatch alloc] initWithConfigContent:configContent apiKey:apiKey complete:block];
}

- (id) initWithConfigContent:(NSString *)configContent
                      apiKey:(NSString *)apiKey
                    complete:(void (^)(id responseObject, NSError *error))block {

    self.completionBlock = block;
    self.responseData = [NSMutableData data];

    NSString *url = [NSString stringWithFormat:@"%@/api/v1/job", kHeyWatchURL];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[configContent length]] forHTTPHeaderField:@"Content-Length"];

    NSString *basicAuthString = [NSString stringWithFormat:@"%@:", apiKey];
    NSString *encodedAuthData = [[basicAuthString dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    NSString *base64AuthData = [NSString stringWithFormat:@"Basic %@", encodedAuthData];
    [request setValue:base64AuthData forHTTPHeaderField:@"Authorization"];

    [request setHTTPBody:[configContent dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.completionBlock(nil, error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    self.completionBlock(res, nil);
}

@end
