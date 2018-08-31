//
//  RequsetManager.h
//  breathPatientApp
//
//  Created by ifly on 2018/7/10.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestManager.h"
@interface RequsetManager : NSObject

// MARK: - 获取验证码请求
+ (void)getLoginAuthCodeRequestWithUserName:(NSString *)userName withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 登陆请求
+ (void)getLoginRequestWithUserName:(NSString *)userName withCode:(NSString *)code withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 创建患者信息
+ (void)PostPatientInformationRequestWith:(UIImage *)image Withparams:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取患者个人信息
+ (void)GetPatientInformationRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 更新患者个人信息
+ (void)UpdatePatientInformationRequestWith:(UIImage *)image Withparams:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;


// MARK: - 请求医院
+ (void)getHospitalRequestWithProvinceName:(NSString *)provinceName withCityName:(NSString *)cityName withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取医院对应的医生信息
+ (void)getHospitalDoctorsRequestWithHospitalId:(NSString *)hospitalId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取医生详细信息
//+ (void)getHospitalDoctorDetailRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 添加医生
+ (void)PostaddDoctorRequesWithparams:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取所有的申请
+ (void)GetAllApplyRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取文章列表
+ (void)getArticalListRequestWithLimit:(NSString *)limit withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

+ (void)getArticalDetailslRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;
// MARK: - 获取用药视频列表
+ (void)GetVideoListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;
// MARK: - 获取用药视频详情
+ (void)GetVideoDetailsRequestwithid:(NSString *)isId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 上传用药视频
+ (void)UploadVideoRequestwithFileUrl:(NSURL *)fileurl withParameters:(NSDictionary *)params withwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取用药视频历史记录
+ (void)GetUploadVideoListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 文章点赞
+ (void)PostArticalLikelRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 视频点赞
+ (void)PostVideoLikelRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 文章查看多久
+ (void)PostArticalSeeTimeRequestWithResourceUri:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - ACT测试结果上传
+ (void)PostACTScoreRequestWithResourceUri:(NSString *)resourceUri withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取最后一次打分
+ (void)GetlastScoreRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取我的医生列表
+ (void)GetmyDoctorListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取我的问诊列表
+ (void)GetmyPhysicianVisitsListRequestwithoffset:(NSInteger)offset withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: -  获取我的历史测试情况列表
+ (void)GetmyTestsHistoryListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - -对于医生的特定问诊进行答复
+ (void)PostPharmaryReplyRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: -  获取医生列表医生的详情信息
+ (void)GetDoctorDetailsRequestwithDoctorId:(NSString *)doctorId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 发起文字问诊
+ (void)PostPharmaryReplyRequestwithTopicText:(NSString *)topic withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 发起图文问诊
+ (void)PostImgaes:(NSArray *)images withTopicText:(NSString *)topic withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取问诊详情
+ (void)GetPharaDetailsDetailsRequestwithPharaVisitId:(NSString *)pharaVisitId withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;



// MARK: - 退出登录
+ (void)PostLogoutRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 问诊详情回复
+ (void)SendPharmaryReplyRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 用药记录添加
+ (void)PostMedicationRecordAdditionRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;


// MARK: - 绑定设备
+ (void)PostBandDeviceRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 解除绑定设备
+ (void)PostremoveBandDeviceRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;


// MARK: -  获取我的设备列表
+ (void)GetmyDeviceListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 创建手工记录
+ (void)PostManualRcorederRequestwithParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取手工记录
+ (void)GetManualRcorederRequestwithTime:(NSString *)timeString withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 修改手工记录
+ (void)PATCHManualRcorederRequestwithresourceUrl:(NSString *)resourceUri withParameters:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 创建日记更新日记接口
+ (void)PostDairyImgaes:(NSArray *)images withparams:(NSDictionary *)params withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 删除日记图片资源
+ (void)DeleteDairyImgaeRequestwithresourceUrl:(NSString *)resourceUri withSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

// MARK: - 获取用药列表
+ (void)GetmedicationListRequestwithSuccessBlock:(HTTPResponseSuccess)successBlock WithFailBlock:(HTTPResponseFail)failBlock withdownloadBlock:(DownloadProgress)downloadBlock;

@end
