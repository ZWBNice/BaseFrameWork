//
//  UrlBuilder.h
//  breathPatientApp
//
//  Created by ifly on 2018/7/10.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

// MARK: - 登陆验证码url
extern NSString *const GetLoginAuthCodeUrl;
// MARK: - 登陆url
extern NSString *const LoginUrl;
// MARK: - 创建患者信息
extern NSString *const CreatPatientInformationUrl;
// MARK: - 获取患者个人信息
extern NSString *const GetPatientInformationUrl;
// MARK: - 更新个人信息
extern NSString *const UpdatePatientInformationUrl;
// MARK: - 请求医院
extern NSString *const RequestHospitalUrl;
// MARK: - 请求对应医院的医生
extern NSString *const RequestDoctorsUrl;
// MARK: - 申请添加医生
extern NSString *const AddDoctorUrl;
// MARK: - 获取所有的申请
extern NSString *const GetAllApply;
// MARK: - 获取文章列表
extern NSString *const GetArtcleListUrl;
// MARK: - 获取用药视频列表
extern NSString *const GetVideoListUrl;
// MARK: - 上传用药视频
extern NSString *const UploadVideotUrl;
// MARK: - 获取上传用药视频列表
extern NSString *const GetUploadVideoListUrl;
// MARK: - 文章点赞
extern NSString *const articalLikeUrl;
// MARK: - 视频点赞
extern NSString *const videoLikeUrl;
// MARK: - 5岁TRACK测试结果保存
extern NSString *const fiveagesUrl;
// MARK: - 12岁TRACK测试结果保存
extern NSString *const telveaboveagesUrl;
// MARK: - 4-12岁CACT测试结果
extern NSString *const fourtotelveagesUrl;
// MARK: - 保存慢阻肺CAT测试结果
extern NSString *const manzufeiUrl;
// MARK: - 获取最后一次测试得分
extern NSString *const GetlastScore;
// MARK: - 获取我的医生列表
extern NSString *const GetMyDoctorListUrl;
// MARK: -  获取我提交问诊列表
extern NSString *const GetMyPhysicianVisitsListUrl;
// MARK: -  获取我的历史测试情况列表
extern NSString *const GetMyTestHistoryListUrl;
// MARK: -  对于医生的特定问诊进行答复
extern NSString *const PostPharyReplyUrl;
// MARK: -  获取医生列表医生的详情信息
extern NSString *const GETDoctorDetailsUrl;
// MARK: -  发起图文问诊
extern NSString *const SendPhramaryUrl;
// MARK: -  发起文字问诊
extern NSString *const SendTextPhramaryUrl;
// MARK: - 获取问诊详情
extern NSString *const GetPhysicianDetailsUrl;
// MARK: -  问诊详情回复
extern NSString *const SendReplyPhysicianUrl;

// MARK: -  退出登录
extern NSString *const LogoutUrl;

// MARK: -  用药记录的添加
extern NSString *const MedicationrecordAddUrl;
// MARK: - 绑定BLE设备
extern NSString *const bandEquipmentUrl;
// MARK: - 解除绑定BLE设备
extern NSString *const removeBandEquipmentUrl;
// MARK: - 我的设备列表
extern NSString *const MyEquipmentListUrl;
// MARK: - 获取当天手动记录添加数据
extern NSString *const GETRecordUrl;
// MARK: - 创建手工记录
extern NSString *const CreateRecordUrl;

// MARK: - 创建日记接口
extern NSString *const CreateDiaryUrl;

// MARK: - 获取用药记录
extern NSString *const GetMedicationUrl;


