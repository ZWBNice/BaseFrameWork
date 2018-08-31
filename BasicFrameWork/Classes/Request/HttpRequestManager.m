//
//  HttpRequestManager.m
//  ProjectFramework
//
//  Created by zwb on 2018/1/24.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "HttpRequestManager.h"
#import "WBFileManager.h"

#if DEBUG
NSString *const hostUrl = @"https://obreathdev.obreathing.com";
#else
NSString *const hostUrl = @"https://obreathdev.obreathing.com";
#endif

@interface HttpRequestManager ()
@property (nonatomic, strong) WBFileManager *fileManager;

@end

@implementation HttpRequestManager

- (WBFileManager *)fileManager{
    if(!_fileManager){
        _fileManager = [[WBFileManager alloc] init];
    }
    return _fileManager;
}



- (instancetype)init{
    if (self = [super init]) {
        self.netWorkStatus = kNetworkStatusReachableViaWiFi;
        self.hubString = LocalizableText(@"loading");
        [self checkNetworkStatus];
    }
    return self;
}

- (void)GetWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    [self requestWithHttpMethodType:KHttpRequstTypeGet withURL:urlString withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

- (void)PostWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    [self requestWithHttpMethodType:KHttpRequstTypePost withURL:urlString withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
    
}

- (void)PutWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    [self requestWithHttpMethodType:KHttpRequstTypePut withURL:urlString withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
    
}

- (void)DeleteWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    [self requestWithHttpMethodType:KHttpRequstTypeDelete withURL:urlString withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

- (void)PATCHWithUrl:(NSString *)urlString withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    [self requestWithHttpMethodType:KHttpRequstTypePatch withURL:urlString withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - private method
- (void)requestWithHttpMethodType:(HttpRequestType)requsetType withURL:(NSString *)urlString
                        withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    if (!self.isHiddenHub) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [GSKAlertViewController showSVProgressWithStatus:self.hubString];
        });
    }
    switch (requsetType) {
        case KHttpRequstTypeGet:{
            AFHTTPSessionManager *manager = [self getSessionManager];
            [manager GET:[self checkUrl:urlString withQuery:query] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                if (downloadBlock) {
                    downloadBlock(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
                }
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [GSKAlertViewController dismissSVprogress];
                id data = [self tryToParseData:responseObject];
                if (successBlock) {
                    successBlock(data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failBlock) {
                    failBlock(error);
                }
                [GSKAlertViewController dismissSVprogress];
                if (error.code == -1009) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [GSKAlertViewController showErrorText:LocalizableText(@"noInternet")];
                    });
                }
            }];
            break;
        }
        case KHttpRequstTypePost:{
            AFHTTPSessionManager *manager = [self getSessionManager];
            [manager POST:[self checkUrl:urlString withQuery:query] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                if (downloadBlock) {
                    downloadBlock(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [GSKAlertViewController dismissSVprogress];
                
                id data = [self tryToParseData:responseObject];
                if (successBlock) {
                    successBlock(data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failBlock) {
                    failBlock(error);
                }
                [GSKAlertViewController dismissSVprogress];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [GSKAlertViewController showErrorText:LocalizableText(@"noInternet")];
                });
            }];
            break;
        }
        case KHttpRequstTypePut:{
            AFHTTPSessionManager *manager = [self getSessionManager];
            [manager PUT:[self checkUrl:urlString withQuery:query] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [GSKAlertViewController dismissSVprogress];
                id data = [self tryToParseData:responseObject];
                if (successBlock) {
                    successBlock(data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failBlock) {
                    failBlock(error);
                }
                [GSKAlertViewController dismissSVprogress];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [GSKAlertViewController showErrorText:LocalizableText(@"noInternet")];
                });
            }];
            break;
        }
        case KHttpRequstTypeDelete:{
            
            AFHTTPSessionManager *manager = [self getSessionManager];
            [manager DELETE:[self checkUrl:urlString withQuery:query] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [GSKAlertViewController dismissSVprogress];
                id data = [self tryToParseData:responseObject];
                if (successBlock) {
                    successBlock(data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failBlock) {
                    failBlock(error);
                }
                [GSKAlertViewController dismissSVprogress];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [GSKAlertViewController showErrorText:LocalizableText(@"noInternet")];
                });
            }];
            break;
        }
        case KHttpRequstTypePatch:{
            
            AFHTTPSessionManager *manager = [self getSessionManager];
            [manager PATCH:[self checkUrl:urlString withQuery:query] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [GSKAlertViewController dismissSVprogress];
                id data = [self tryToParseData:responseObject];
                if (successBlock) {
                    successBlock(data);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failBlock) {
                    failBlock(error);
                }
                [GSKAlertViewController dismissSVprogress];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [GSKAlertViewController showErrorText:LocalizableText(@"noInternet")];
                });
            }];
            break;
        }
        default:
            break;
    }
}


- (AFHTTPSessionManager *)getSessionManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = AFtimeoutInterval;
    if (self.requestSerializer == HTTPRequestSerializer) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    }else if (self.requestSerializer == JSONRequestSerializer){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    // 设置请求头
    
    for (id key in self.headDic) {
        [manager.requestSerializer setValue:self.headDic[key] forHTTPHeaderField:key];
    }
    return manager;
}

- (NSString *)checkUrl:(NSString *)url withQuery:(NSDictionary *)query{
    NSString *urlString = @"";
    url = [url stringByAppendingString:@"?"];
    if([url hasPrefix:@"http://"]){
        urlString =  [url stringByAppendingString:[self queryToString:query]];
        //        DELog(@"%@",urlString);
        return [urlString wb_urEncode];
    }else{
        urlString = [[hostUrl stringByAppendingString:url] stringByAppendingString:[self queryToString:query]];
        //        DELog(@"%@",urlString);
        return [urlString wb_urEncode];
    }
}

// MARK: - 拼接传入的query字典
- (NSString *)queryToString:(NSDictionary *)query{
    NSString *queryString = @"";
    for (id key in query) {
        queryString = [queryString stringByAppendingFormat:@"&%@=%@",key,query[key]];
        
    }
    if (query == nil) {
        return queryString;
    }
    return [queryString substringFromIndex:1];
}

// MARK: - 解析返回的responseObject
- (id)tryToParseData:(id)responseObject{
    if ([responseObject isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseObject == nil) {
            return responseObject;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject         options:NSJSONReadingMutableContainers error:&error];
            if (error != nil) {
                return [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            } else {
                return response;
            }
        }
    } else {
        return responseObject;
    }
}

// MARK: - 检查网络错误code
- (void)checkHttpRequestFailErrorMessage:(NSError *)error{
    
    if(error.code == -1009 ){
        NSLog(@"没有网络");
        
    }else if (error.code == -1001){
        NSLog(@"网络超时");
    }
}

// MARK: - 检查网络环境
- (void)checkNetworkStatus {
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable){
            self.netWorkStatus = KNetworkStatusNotReachable;
        } else if (status == AFNetworkReachabilityStatusUnknown){
            self.netWorkStatus = kNetworkStatusUnknown;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            self.netWorkStatus = kNetworkStatusReachableViaWWAN;
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            self.netWorkStatus = kNetworkStatusReachableViaWiFi;
        }
    }];
    
}



- (NSString *)getRequstTypeStringWithType:(HttpRequestType)type{
    NSString *typeStr = @"";
    switch (type) {
        case KHttpRequstTypeGet:
            typeStr = @"GET";
            break;
        case KHttpRequstTypePost:
            typeStr = @"POST";
            break;
        case KHttpRequstTypePut:
            typeStr = @"PUT";
            break;
        case KHttpRequstTypeDelete:
            typeStr = @"DELETE";
            break;
        default:
            break;
    }
    return typeStr;
}

- (void)PostImage:(UIImage *)image withURL:(NSString *)urlString
        withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    AFHTTPSessionManager *manager = [self getSessionManager];
    [manager POST:[self checkUrl:urlString withQuery:query] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //根据当前系统时间生成图片名称
        if (image != nil) {
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            NSString *dateStr = [formatter stringFromDate:date];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",dateStr];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:@"avatar" fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [self tryToParseData:responseObject];
        if (successBlock) {
            successBlock(data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
        
    }];
}

- (void)PostFileDataWithFileURl:(NSURL *)fileUrl withname:(NSString *)name withmimeType:(NSString *)mimeType withURL:(NSString *)urlString
                      withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    AFHTTPSessionManager *manager = [self getSessionManager];
    [manager POST:[self checkUrl:urlString withQuery:query] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *suffixString = @"mp4";
        if ([mimeType isEqualToString:@"video/mpeg4"]) {
            suffixString = @"mp4";
        }
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSString *dateStr = [formatter stringFromDate:date];
        NSString *fileName = [NSString stringWithFormat:@"%@.%@",dateStr,suffixString];
        NSError *error;
        [formData appendPartWithFileURL:fileUrl name:name fileName:fileName mimeType:mimeType error:&error];
        NSLog(@"%@",error);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [self tryToParseData:responseObject];
        if (successBlock) {
            successBlock(data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
        
    }];
    
}


- (void)PostImages:(NSArray *)images withURL:(NSString *)urlString withname:(NSString *)name withmimeType:(NSString *)mimeType
         withQuery:(NSDictionary *)query withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    AFHTTPSessionManager *manager = [self getSessionManager];
    [manager POST:[self checkUrl:urlString withQuery:query] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //根据当前系统时间生成图片名称
        int i = 0;
        for (UIImage *image in images) {
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            NSString *dateStr = [formatter stringFromDate:date];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpeg",dateStr,i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [self tryToParseData:responseObject];
        if (successBlock) {
            successBlock(data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
        
    }];
}



// --------------------当需要缓存的时候使用
- (void)cacheWithURLString:(NSString *)url WithRequestType:(HttpRequestType)type Withdata:(id)data {
    NSString *typeStr = [self getRequstTypeStringWithType:type];
    NSString *fileName = [self.fileManager createFileTodirectoryPath:self.fileManager.cachesPath WithFileName:[NSString stringWithFormat:@"%@.json",[[NSString stringWithFormat:@"%@%@",url,typeStr] stringFromMD5Capital]]];
    [self.fileManager writeDataTodirectoryPath:fileName WithData:data];
}

- (id)loadDataWithURLString:(NSString *)urlString WithRequestType:(HttpRequestType)type{
    NSString *typeStr = [self getRequstTypeStringWithType:type];
    id obj =  [self.fileManager loadDataWithPath:[self.fileManager.cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",[[NSString stringWithFormat:@"%@%@",urlString,typeStr] stringFromMD5Capital]]]];
    return obj;
}


- (void)downloadWithUrl:(NSString *)url withSuccessBlock:(void (^)(NSURL * filePath))successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    AFHTTPSessionManager *manager = [self getSessionManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadBlock) {
            downloadBlock(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        WBFileManager * filemanager = [[WBFileManager alloc] init];
        NSLog(@"%@",filemanager.documentPath);
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [downloadURL URLByAppendingPathComponent:@"zipFile.zip"];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            successBlock(filePath);
        }
    }];
    [task resume];
    
    
    
}



@end
