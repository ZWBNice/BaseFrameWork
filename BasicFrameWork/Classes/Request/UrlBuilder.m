//
//  UrlBuilder.m
//  breathPatientApp
//
//  Created by ifly on 2018/7/10.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "UrlBuilder.h"

// MARK: - 登陆验证码url
NSString *const GetLoginAuthCodeUrl = @"/ibreath-manual/patient/get-verification-code/";
// MARK: - 登陆url
NSString *const LoginUrl = @"/ibreath-manual/patient/user-login/";
// MARK: - 创建患者信息
NSString *const CreatPatientInformationUrl = @"/ibreath-manual/patient/create_info/";
// MARK: - 获取患者个人信息
NSString *const GetPatientInformationUrl = @"/ibreath-manual/patient/get_info/";
// MARK: - 更新个人信息
NSString *const UpdatePatientInformationUrl = @"/ibreath-manual/patient/update_info/";
// MARK: - 请求医院
NSString *const RequestHospitalUrl = @"/ibreath/v1/hospitals/";
// MARK: - 请求对应医院的医生
NSString *const RequestDoctorsUrl = @"/ibreath/v1/doctors/";
// MARK: - 申请添加医生
NSString *const AddDoctorUrl = @"/ibreath/v1/invitations/";
// MARK: - 获取所有的申请
NSString *const GetAllApply = @"/ibreath/v1/invitations/";
// MARK: - 获取文章列表
NSString *const GetArtcleListUrl = @"/ibreath/v1/patient/articles/";
// MARK: - 获取用药视频列表
NSString *const GetVideoListUrl = @"/ibreath/v1/patient/videos/";
// MARK: - 上传用药视频
NSString *const UploadVideotUrl = @"/ibreath-manual/patient/consultation/video_upload/";
// MARK: - 获取上传用药视频列表
NSString *const GetUploadVideoListUrl = @"/ibreath-manual/patient/patient_videos/list/";
// MARK: - 文章点赞
NSString *const articalLikeUrl = @"/ibreath-manual/patient/articles/";
// MARK: - 视频点赞
NSString *const videoLikeUrl = @"/ibreath-manual/patient/videos/";
// MARK: - 5岁TRACK测试结果保存
NSString *const fiveagesUrl = @"/ibreath/v1/patient/exam/track/";
// MARK: - 12岁TRACK测试结果保存
NSString *const telveaboveagesUrl = @"/ibreath/v1/patient/exam/act/";
// MARK: - 4-12岁CACT测试结果
NSString *const fourtotelveagesUrl = @"/ibreath/v1/patient/exam/cact/";
// MARK: - 保存慢阻肺CAT测试结果
NSString *const manzufeiUrl = @"/ibreath/v1/patient/exam/cat/";
// MARK: - 获取最后一次测试得分
NSString *const GetlastScore = @"/ibreath-manual/patient/last_exam_result/";
// MARK: - 获取我的医生列表
NSString *const GetMyDoctorListUrl = @"/ibreath-manual/patient/doctors/list/";
// MARK: -  获取我提交问诊列表
NSString *const GetMyPhysicianVisitsListUrl = @"/ibreath/v1/consultations/";
// MARK: -  获取我的历史测试情况列表
NSString *const GetMyTestHistoryListUrl = @"/ibreath-manual/patient/exams/list/";
// MARK: -  对于医生的特定问诊进行答复
NSString *const PostPharyReplyUrl = @"/ibreath/v1/consultation/patient/reply/";

// MARK: -  获取医生列表医生的详情信息
NSString *const GETDoctorDetailsUrl = @"/ibreath/v1/doctors/";

// MARK: -  发起图文问诊
NSString *const SendPhramaryUrl = @"/ibreath-manual/patient/consultation/image/";
// MARK: -  发起文字问诊
NSString *const SendTextPhramaryUrl = @"/ibreath-manual/patient/consultation/text/";
// MARK: -  问诊详情回复
NSString *const SendReplyPhysicianUrl = @"/ibreath/v1/consultation/patient/reply/";

// MARK: - 获取问诊详情
NSString *const GetPhysicianDetailsUrl = @"/ibreath/v1/consultations/";


// MARK: -  退出登录
NSString *const LogoutUrl = @"/ibreath-manual/user-logout/";


// MARK: -  用药记录的添加
NSString *const MedicationrecordAddUrl = @"/ibreath-manual/patient/medication/record/add/";
// MARK: - 绑定BLE设备/ibreath-manual/patient/ble/device/bind/
NSString *const bandEquipmentUrl = @"/ibreath-manual/patient/ble/device/bind/";

// MARK: - 解除绑定BLE设备
NSString *const removeBandEquipmentUrl = @"/ibreath-manual/patient/ble/device/unbind/";


// MARK: - 我的设备列表
NSString *const MyEquipmentListUrl = @"/ibreath/v1/patient/ble/devices/";

// MARK: - 获取当天手动记录添加数据
NSString *const GETRecordUrl = @"/ibreath/v1/manual/records/";

// MARK: - 创建手工记录
NSString *const CreateRecordUrl = @"/ibreath/v1/manual/records/";


// MARK: - 创建日记接口
NSString *const CreateDiaryUrl = @"/ibreath-manual/patient/medication/journal/add/";


// MARK: - 获取用药记录
NSString *const GetMedicationUrl = @"/ibreath/v1/medication/records/";
