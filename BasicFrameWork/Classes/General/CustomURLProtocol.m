//
//  CustomURLProtocol.m
//  breathPatientApp
//
//  Created by ifly on 2018/8/20.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "CustomURLProtocol.h"

static NSString * const CustomURLProtocolHandledKey = @"CustomURLProtocolHandledKey";

@interface CustomURLProtocol()<NSURLSessionDelegate>

@property (atomic,strong,readwrite) NSURLSessionDataTask *task;
@property (nonatomic,strong) NSURLSession *session;

@end

@implementation CustomURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    NSString *scheme = [[request URL] scheme];
    // 只处理http 和 https 请求
    if (([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
         [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame)) {
        // 判断是否已经处理过了，防止无限循环
        if ([NSURLProtocol propertyForKey:CustomURLProtocolHandledKey inRequest:request]) {
            return NO;
        }
        return true;
    }
    return true;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    // 可以在此处添加头信息
    [mutableRequest addValue:@"" forHTTPHeaderField:@""];
    return mutableRequest;
}

- (void)startLoading{
    NSMutableURLRequest *mutableRequest = [[self request] mutableCopy];
    // 打上标签，防止无限循环
    [NSURLProtocol setProperty:@YES forKey:CustomURLProtocolHandledKey inRequest:mutableRequest];
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    self.session = [NSURLSession sessionWithConfiguration:configure delegate:self delegateQueue:queue];
    self.task = [self.session dataTaskWithRequest:mutableRequest];
    [self.task resume];

}

- (void)stopLoading{
    [self.session invalidateAndCancel];
    self.session = nil;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error != nil) {
        [self.client URLProtocol:self didFailWithError:error];
    }else
    {
        [self.client URLProtocolDidFinishLoading:self];
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler
{
    completionHandler(proposedResponse);
}



@end
