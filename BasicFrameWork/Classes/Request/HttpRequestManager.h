//
//  HttpRequestManager.h
//  ProjectFramework
//
//  Created by zwb on 2018/1/24.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

static CGFloat AFtimeoutInterval = 30.0f;

extern NSString *const hostUrl;


typedef enum : NSUInteger {
    KHttpRequstTypeGet,
    KHttpRequstTypePost,
    KHttpRequstTypePut,
    KHttpRequstTypeDelete,
    KHttpRequstTypePatch,

} HttpRequestType;


typedef enum : NSUInteger {
    KNetworkStatusNotReachable,
    kNetworkStatusReachableViaWiFi,
    kNetworkStatusReachableViaWWAN,
    kNetworkStatusUnknown,
} kNetWorkStatus;

typedef enum : NSUInteger {
    HTTPRequestSerializer,
    JSONRequestSerializer,
} AFrequestSerializer;

// MARK: - 下载进度block
typedef void (^DownloadProgress)(int64_t bytesRead,
                                 int64_t totalBytesRead);
// MARK: - 请求成功block
typedef void(^HTTPResponseSuccess)(id response);
// MARK: - 请求失败block
typedef void(^HTTPResponseFail)(NSError *error);

@interface HttpRequestManager : NSObject

@property(nonatomic, assign) kNetWorkStatus netWorkStatus;


/**
 请求头参数
 */
@property (nonatomic, strong) NSDictionary *headDic;

@property(nonatomic, assign) AFrequestSerializer requestSerializer;

@property(nonatomic, assign) BOOL isHiddenHub;

@property(nonatomic, copy) NSString *hubString;

/**
 Get请求

 @param urlString url
 @param query url上的参数
 @param params params
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param downloadBlock 下载进度回调
 */
- (void)GetWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

/**
 Post请求
 
 @param urlString url
 @param query url上的参数
 @param params params
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param downloadBlock 下载进度回调
 */
- (void)PostWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

/**
 Put请求
 
 @param urlString url
 @param query url上的参数
 @param params params
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param downloadBlock 下载进度回调
 */
- (void)PutWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

/**
 Delete请求
 
 @param urlString url
 @param query url上的参数
 @param params params
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param downloadBlock 下载进度回调
 */
- (void)DeleteWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

/**
 PATHCH请求
 
 @param urlString url
 @param query url上的参数
 @param params params
 @param successBlock 成功回调
 @param failBlock 失败回调
 @param downloadBlock 下载进度回调
 */

- (void)PATCHWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;



/**
 上传单张图片

 @param image 要上传的image
 @param urlString url
 @param query url上的参数
 @param params params
 @param successBlock  成功回调
 @param failBlock 失败回调
 @param downloadBlock 下载进度回调
 */
- (void)PostImage:(UIImage *)image withURL:(NSString *)urlString
        withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;


- (void)PostFileDataWithFileURl:(NSURL *)fileUrl withname:(NSString *)name withmimeType:(NSString *)mimeType withURL:(NSString *)urlString
                      withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;




- (void)PostImages:(NSArray *)images withURL:(NSString *)urlString withname:(NSString *)name withmimeType:(NSString *)mimeType
         withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

- (void)downloadWithUrl:(NSString *)url withSuccessBlock:(void (^)(NSURL * filePath))successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

@end
