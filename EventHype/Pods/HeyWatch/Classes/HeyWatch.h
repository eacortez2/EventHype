//
//  HeyWatch.h
//  HeyWatch
//
//  Created by Bruno Celeste on 22/10/14.
//  Copyright (c) 2014 HeyWatch. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHeyWatchURL @"https://heywatch.com"

/**
 `HeyWatch` is a class that communicates with the HeyWatch Encoding API
 */
@interface HeyWatch : NSObject

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic,copy)void (^completionBlock) (id responseObject, NSError *error);

/**
 Create a new Job

 @param configContent The config content in INI format
 @param apiKey The API Key to use
 @param apiVersion The API version to use
 @param complete A block object to be executed when the task is complete. This block has no return value and takes two arguments: the response object and the error if any
 */
+ (void)submit:(NSString *)configContent
    withApiKey:(NSString *)apiKey
      complete:(void (^)(id responseObject, NSError *error))block;

- (id) initWithConfigContent:(NSString *)configContent
                      apiKey:(NSString *)apiKey
                    complete:(void (^)(id responseObject, NSError *error))block;


@end
