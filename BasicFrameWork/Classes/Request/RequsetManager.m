//
//  RequsetManager.m
//  breathPatientApp
//
//  Created by ifly on 2018/7/10.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "RequsetManager.h"
#import "HttpRequestManager.h"
#import "UrlBuilder.h"
#import "UserInfo.h"
@implementation RequsetManager

+ (void)getLoginAuthCodeRequestWithUserName:(NSString *)userName withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    NSDictionary *query = nil;
    NSDictionary *params = @{@"username":userName};
    NSString *resourceUrl = GetLoginAuthCodeUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    [httpRequest PostWithUrl:resourceUrl withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];

}


+ (void)getLoginRequestWithUserName:(NSString *)userName withCode:(NSString *)code withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    NSDictionary *query = nil;
    NSDictionary *params = @{@"username":userName,@"code":code};
    NSString *resourceUrl = LoginUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
//    httpRequest.hubString = @"登录中";
    [httpRequest PostWithUrl:resourceUrl withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)PostPatientInformationRequestWith:(UIImage *)image Withparams:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    NSDictionary *query = nil;
    NSString *resourceUrl = CreatPatientInformationUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest PostImage:image withURL:resourceUrl withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

+ (void)GetPatientInformationRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    NSDictionary *query = nil;
    NSString *resourceUrl = GetPatientInformationUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 更新个人信息

+ (void)UpdatePatientInformationRequestWith:(UIImage *)image Withparams:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    NSDictionary *query = nil;
    NSString *resourceUrl = UpdatePatientInformationUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest PostImage:image withURL:resourceUrl withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)getHospitalRequestWithProvinceName:(NSString *)provinceName withCityName:(NSString *)cityName withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"province__icontains":provinceName,@"city__icontains":cityName,@"limit":@"0"};
    NSString *resourceUrl = RequestHospitalUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

+ (void)getHospitalDoctorsRequestWithHospitalId:(NSString *)hospitalId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"hospital__id":hospitalId,@"limit":@"0"};
    NSString *resourceUrl = RequestDoctorsUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
  
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

//+ (void)getHospitalDoctorDetailRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
//    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
//    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
//    [httpRequest GetWithUrl:resourceUri withQuery:nil withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
//}

+ (void)PostaddDoctorRequesWithparams:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    httpRequest.requestSerializer = JSONRequestSerializer;
    [httpRequest PostWithUrl:AddDoctorUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

+ (void)GetAllApplyRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"limit":@"0"};
    NSString *resourceUrl = GetAllApply;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];

}

+ (void)getArticalListRequestWithLimit:(NSString *)limit withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"limit":limit};
    NSString *resourceUrl = GetArtcleListUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)getArticalDetailsRequestWithHospitalId:(NSString *)hospitalId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = nil;
    NSString *resourceUrl = RequestDoctorsUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)getArticalDetailslRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUri withQuery:nil withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)GetVideoListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"limit":@"0"};
    NSString *resourceUrl = GetVideoListUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)GetVideoDetailsRequestwithid:(NSString *)isId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"limit":@"0"};
    NSString *resourceUrl = [NSString stringWithFormat:@"%@%@/",GetVideoListUrl,isId];
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];

}



+ (void)UploadVideoRequestwithFileUrl:(NSURL *)fileurl withParameters:(NSDictionary *)params withwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = nil;
    NSString *resourceUrl = UploadVideotUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest PostFileDataWithFileURl:fileurl withname:@"my_video" withmimeType:@"video/mpeg4" withURL:resourceUrl withQuery:query withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}



+ (void)GetUploadVideoListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"limit":@"0"};
    NSString *resourceUrl = GetUploadVideoListUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

+ (void)PostArticalLikelRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest PostWithUrl:[NSString stringWithFormat:@"%@%@",articalLikeUrl,resourceUri] withQuery:nil withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)PostVideoLikelRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
 
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest PostWithUrl:[NSString stringWithFormat:@"%@%@",videoLikeUrl,resourceUri] withQuery:nil withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 文章查看多久

+ (void)PostArticalSeeTimeRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest PostWithUrl:resourceUri withQuery:nil withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)PostACTScoreRequestWithResourceUri:(NSString *)resourceUri withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    httpRequest.requestSerializer = JSONRequestSerializer;
    
    [httpRequest PostWithUrl:resourceUri withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)GetlastScoreRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = nil;
    NSString *resourceUrl = GetlastScore;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    httpRequest.isHiddenHub = true;
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 获取我的医生列表
+ (void)GetmyDoctorListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = nil;
    NSString *resourceUrl = GetMyDoctorListUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


// MARK: - 获取我的问诊列表
+ (void)GetmyPhysicianVisitsListRequestwithoffset:(NSInteger)offset withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"limit":@"10",@"offset":[NSString stringWithFormat:@"%ld",offset]};
    
    NSString *resourceUrl = GetMyPhysicianVisitsListUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: -  获取我的历史测试情况列表
+ (void)GetmyTestsHistoryListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = nil;
    NSString *resourceUrl = GetMyTestHistoryListUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - -对于医生的特定问诊进行答复
+ (void)PostPharmaryReplyRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    httpRequest.requestSerializer = JSONRequestSerializer;
    
    [httpRequest PostWithUrl:PostPharyReplyUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: -  获取医生列表医生的详情信息
+ (void)GetDoctorDetailsRequestwithDoctorId:(NSString *)doctorId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = nil;
    NSString *resourceUrl = [NSString stringWithFormat:@"%@%@/",GETDoctorDetailsUrl,doctorId];
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 发起文字问诊
+ (void)PostPharmaryReplyRequestwithTopicText:(NSString *)topic withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
//    httpRequest.requestSerializer = JSONRequestSerializer;
    NSDictionary *params = @{@"topic":topic};
    NSString *resourceUrl = SendTextPhramaryUrl;
    [httpRequest PostWithUrl:resourceUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

+ (void)PostImgaes:(NSArray *)images withTopicText:(NSString *)topic withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSDictionary *params = @{@"topic":topic};
    NSString *resourceUrl = SendPhramaryUrl;
    [httpRequest PostImages:images withURL:resourceUrl withname:@"images" withmimeType:@"" withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)PostLogoutRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest PostWithUrl:LogoutUrl withQuery:nil withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)GetPharaDetailsDetailsRequestwithPharaVisitId:(NSString *)pharaVisitId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = nil;
    NSString *resourceUrl = [NSString stringWithFormat:@"%@%@/",GetPhysicianDetailsUrl,pharaVisitId];
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 问诊详情回复
+ (void)SendPharmaryReplyRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
        httpRequest.requestSerializer = JSONRequestSerializer;
    NSString *resourceUrl = SendReplyPhysicianUrl;
    [httpRequest PostWithUrl:resourceUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

+ (void)PostMedicationRecordAdditionRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = MedicationrecordAddUrl;
    [httpRequest PostWithUrl:resourceUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


+ (void)PostBandDeviceRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = bandEquipmentUrl;
    [httpRequest PostWithUrl:resourceUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

+ (void)PostremoveBandDeviceRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = removeBandEquipmentUrl;
    [httpRequest PostWithUrl:resourceUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


// MARK: -  获取我的设备列表
+ (void)GetmyDeviceListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"limit":@"0"};
    NSString *resourceUrl = MyEquipmentListUrl;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 创建手工记录
+ (void)PostManualRcorederRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = CreateRecordUrl;
    httpRequest.requestSerializer = JSONRequestSerializer;
    httpRequest.isHiddenHub = true;
    [httpRequest PostWithUrl:resourceUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 获取手工记录
+ (void)GetManualRcorederRequestwithTime:(NSString *)timeString withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = @{@"limit":@"0",@"key_title":timeString};
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = GETRecordUrl;
    httpRequest.isHiddenHub = true;
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 修改手工记录
+ (void)PATCHManualRcorederRequestwithresourceUrl:(NSString *)resourceUri withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = resourceUri;
    httpRequest.requestSerializer = JSONRequestSerializer;
    httpRequest.isHiddenHub = true;
    [httpRequest PATCHWithUrl:resourceUrl withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 创建日记更新日记接口
+ (void)PostDairyImgaes:(NSArray *)images withparams:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = CreateDiaryUrl;
    [httpRequest PostImages:images withURL:resourceUrl withname:@"images" withmimeType:@"" withQuery:nil withParameters:params withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}

// MARK: - 删除日记图片资源
+ (void)DeleteDairyImgaeRequestwithresourceUrl:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = resourceUri;
    [httpRequest DeleteWithUrl:resourceUrl withQuery:nil withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}


// MARK: - 获取用药列表
+ (void)GetmedicationListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock{
    NSDictionary *query = nil;
    HttpRequestManager *httpRequest = [[HttpRequestManager alloc] init];
    httpRequest.headDic = @{@"Authorization":[UserInfo sharedInstance].userPassword};
    NSString *resourceUrl = GetMedicationUrl;
    [httpRequest GetWithUrl:resourceUrl withQuery:query withParameters:nil withSuccessBlock:successBlock WithFailBlock:failBlock withdownloadBlock:downloadBlock];
}



@end
