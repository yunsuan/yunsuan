//
//  NetConfig.h
//  云渠道
//
//  Created by xiaoq on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#ifndef NetConfig_h
#define NetConfig_h
#endif /* NetConfig_h */


#pragma mark ---  基础接口  ---
//基础接口
//static NSString *const Base_Net = @"http://120.27.21.136:2798/";

//基础接口正式
//static NSString *const TestBase_Net = @"http://120.78.69.178:2902/";

//基础接口测试
//static NSString *const TestBase_Net = @"http://120.27.21.136:2798/";

static NSString *const TestBase_Net = @"http://47.106.39.169:2797/";

//获取版本
static NSString *const Version_URL = @"getVersion";

#pragma mark ---  配置文件  ---
//配置文件
static NSString *const Config_URL = @"config";

//static NSString *const Advicer_URL = @"user/yunsuan/advicer";

//获取项目置业顾问
static NSString *const ProjectAdvicer_URL = @"agent/project/advicer";

//到访确认获取项目置业顾问
static NSString *const ProjectGetAdvicer_URL = @"user/project/getAdvicer";

//加入团队地址
static NSString *const PersonalJoinAgentTeam_URL = @"agent/personal/joinAgentTeam";

#pragma mark ---  登录注册  ---
//1登录
static NSString *const Login_URL = @"agent/user/login";

//2验证码
static NSString *const Captcha_URL = @"agent/user/captcha";

//3注册
static NSString *const Register_URL = @"agent/user/register";

//修改密码
static NSString *const ChangePassword_URL = @"agent/user/changePassword";

//第三方账号注册
static NSString *const RegisterOther_URL = @"agent/user/registerOther";

//切换绑定
static NSString *const SwitchBingding_URL = @"agent/user/switchBinding";

//忘记密码
static NSString *const ForgetPassWord_URL = @"user/resetPassword";


#pragma mark ---  我的  ---
//上传文件
static NSString *const UploadFile_URL = @"agent/file/upload";

//获取订阅列表
static NSString *const GetFocusProjectList_URL = @"agent/personal/getFocusProjectList";

//获取关注列表
static NSString *const PersonalGetSubList_URL = @"agent/personal/getSubList";

//获取个人信息
static NSString *const GetPersonalBaseInfo_URL = @"agent/personal/getBaseInfo";


//修改个人信息
static NSString *const UpdatePersonal_URL = @"agent/personal/update";

//获取公司列表
static NSString *const GetCompanyList_URL = @"agent/personal/getCompanyList";

//公司认证申请提交
static NSString *const AddAuthInfo_URL = @"agent/personal/addAuthInfo";

//获取公司旗下项目
static NSString *const GetCompanyProject_URL = @"agent/personal/getCompanyProject";

//获取经纪人工作历史
static NSString *const WorkHis_URL = @"agent/personal/WorkHis";

//获取经纪人申请历史
//static NSString *const ApplyHis_URL = @"agent/personal/ApplyHis";

//取消订阅项目
static NSString *const CancelFocusProject_URL = @"agent/personal/cancelFocusProject";

//绑定银行卡
static NSString *const BindingBankCard_URL = @"agent/personal/bindingBankCard";

//发送验证码
static NSString *const SendCaptcha_URL = @"agent/personal/sendCaptcha";

//获取银行卡信息
static NSString *const BankCardInfo_URL = @"agent/personal/bankCardInfo";

//解绑银行卡
static NSString *const DeleteBankCard_URL = @"agent/personal/deleteBankCard";

//意见反馈
static NSString *const Advice_URL = @"agent/personal/advice";

//佣金概况
static NSString *const BrokerInfo_URL = @"agent/personal/brokerInfo";

//未接佣金
static NSString *const UnPayList_URL = @"agent/personal/unPayList";

//已结佣金列表
static NSString *const IsPayList_URL = @"agent/personal/isPayList";

//佣金详情
static NSString *const PayDetail_URL = @"agent/personal/unPayDetail";

//催佣
static NSString *const Urge_URL = @"agent/personal/urge";

//身份证认证
static NSString *const AgentAuth_URL = @"agent/personal/agentAuth";

//获取身份证认证信息
static NSString *const GetAgentAuthInfo_URL = @"agent/personal/getAgentAuthInfo";

//获取认证信息
static NSString *const GetAuthInfo_URL = @"agent/personal/getAuthInfo";

//取消公司认证
static NSString *const CancelAuth_URL = @"agent/personal/canCelAuth";

//离职
static NSString *const QuitAuth_URL = @"agent/personal/quit";

//我的二维码

static NSString *const QRCode_URL = @"agent/personal/qrcodeUrl";

//我的团队
static NSString *const PersonalMyTeamList_URL = @"agent/personal/myTeamList";


#pragma mark ---  客源  ---


//1客户列表
//static NSString *const ListClient_URL = @"agent/client/list";
static NSString *const ListClient_URL = @"agent/client/list/v2.7";

//新增客户和需求
static NSString *const AddCustomer_URL = @"agent/client/addClientAndNeed";

//6修改客户信息
static NSString *const UpdateClient_URL = @"agent/client/update";


//新增客户需求
//static NSString *const AddCliendAddNeed_URL = @"agent/client/addNeed";

//修改客户需求

static NSString *const UpdateNeed_URL = @"agent/client/updateNeed";

//删除客户需求
//static NSString *const DeleteNeed_URL = @"agent/client/deleteNeed";

//获取客户信息
static NSString *const GetCliendInfo_URL = @"agent/client/getInfo/v2.7";

//新增跟进记录
static NSString *const AddRecord_URL = @"agent/client/addFollow";

//获取客户跟进
static NSString *const GetRecord_URL = @"agent/client/getFollowList";

//获取客户以推荐项目
//static NSString *const GetStateList_URL = @"agent/client/getStateList";

//推荐客户
static NSString *const RecommendClient_URL = @"agent/client/recommend";

//客户匹配项目
static NSString *const ClientMatching_URL = @"agent/matching/client";

#pragma mark ---  房源  ---

//获取源标签
static NSString *const ProjectResources_URL = @"user/project/resources";

//获取开放区域
static NSString *const OpenCity_URL = @"user/project/openCity";

//获取项目列表
//static NSString *const ProjectList_URL = @"user/project/list";
static NSString *const ProjectList_URL = @"user/project/list/v2.7";

//获取项目信息，动态，户型等信息
//static NSString *const ProjectDetail_URL = @"user/project/detail";
static NSString *const ProjectDetail_URL = @"user/project/detail/v2.7";

//获取项目的具体信息
static NSString *const ProjectBuildInfo_URL = @"user/project/buildInfo/v2.7";

//关注项目
//static NSString *const FocusProject_URL = @"agent/personal/focusProject";

//获取动态列表
static NSString *const DynamicList_URL = @"user/dynamic/list/v2.7";

//获取项目图片
static NSString *const GetImg_URL = @"user/img/get/v2.7";

////获取项目分析
static NSString *const HouseTypeAnalyse_URL = @"user/houseType/analyse/v2.7";

//获取佣金规则
//static NSString *const GetRule_URL = @"user/project/getRule";

//获取佣金规则新
static NSString *const GetRuleNew_URL = @"user/project/getRuleNew";

//获取户型信息
static NSString *const HouseTypeDetail_URL = @"user/houseType/detail";

//项目户型匹配
static NSString *const HouseTypeMatching_URL = @"agent/matching/houseType";

//项目匹配客户
static NSString *const ProjectMatching_URL = @"agent/matching/project";

//获取楼栋
static NSString *const GetBuilding_URL = @"user/yunsuan/build";

//获取所有楼栋
static NSString *const GetAllBuilding_URL = @"user/yunsuan/buildAll";

//获取单元
static NSString *const GetUnit_URL = @"user/yunsuan/unit";

//添加客户并且推荐到项目上
static NSString *const AddAndRecommend_URL = @"project/client/addAndRecommend";

//获取客源列表用于推荐
static NSString *const FastRecommendList_URL = @"agent/matching/fastRecommendList";
#pragma mark ---  消息  ---

//获取消息未读数量
//static NSString *const InfoList_URL = @"agent/message/getUnread";

//获取消息未读数量-新
static NSString *const MessageGetUnreadCount_URL = @"agent/message/getUnreadCount";

//系统消息列表
static NSString *const SystemInfoList_URL = @"agent/message/system";

static NSString *const SystemInfoisread_URL = @"agent/message/system/isRead";

//系统消息列表
//static NSString *const GetMessage_URL = @"admin/message/getMessage";

//标记系统消息已读
//static NSString *const SystemRead_URL = @"agent/message/agentMessageRead";

//工作消息列表
//static NSString *const WorkingInfoList_URL = @"agent/message/work/list";
static NSString *const WorkingInfoList_URL = @"agent/message/work/list/v2.7";

//经纪人待确认客户消息
static NSString *const WaitConfirminfo_URL = @"agent/message/work/waitConfirmDetail";

//经纪人有效到访客户消息
static NSString *const Valueinfo_URL = @"agent/message/work/confirmDetail";

//经纪人无效客户消息
static NSString *const Disabledinfo_URL = @"agent/message/work/disabledDetail";

//项目上判断有效
static NSString *const MessageProejectValueDetail_URL = @"agent/message/work/projectValueDetail";

//项目上判断无效
static NSString *const MessageProjectDisabledDetail_URL = @"agent/message/work/projectDisabledDetail";

//获取工作消息项目成交
static NSString *const MessageProjectDealDetail_URL = @"agent/message/work/projectDealDetail";

#pragma mark -- 派单 --

//派单待确认
static NSString *const HousePushWaitList_URL = @"agent/house/push/wait/list";

//派单待确认详情
static NSString *const HousePushWaitDetail_URL = @"agent/house/push/wait/detail";

//接受派单
static NSString *const HouseRecordPushAccept_URL = @"agent/house/record/push/accept";

//拒绝派单
static NSString *const HouseRecordPushRefuse_URL = @"agent/house/record/push/refuse";

//确认列表
static NSString *const HousePushConfirmList_URL = @"agent/house/push/confirm/list";

//失效列表
static NSString *const HousePushDisabledList_URL = @"agent/house/push/disabled/list";

#pragma mark ---  工作  ---
//static NSString *const RecommendList_URL = @"agent/work/getRecommendList";

//经纪人信息统计
static NSString *const AgentInfoCount_URL = @"agent/work/broker/count";


static NSString *const Butterinfocount_URL = @"agent/work/butter/count";

//确认所需字段
static NSString *const ClientNeedInfo_URL = @"agent/client/needInfo";

//更新数据
static NSString *const FlushDate_URL = @"agent/work/flushDate";

//经纪人信息统计
//static NSString *const BrokerCount_URL = @"agent/work/broker/count";

//对接人信息统计
//static NSString *const ButterCount_URL = @"agent/work/butter/count";

//经纪人待确认客户列表
static NSString *const BrokerWaitConfirm_URL = @"agent/work/broker/waitConfirm";

//经纪人有效到访客户列表
static NSString *const BrokerValue_URL = @"agent/work/broker/value";

//经纪人无效列表
static NSString *const BrokerDisabled_URL = @"agent/work/broker/disabled";

//申诉
static NSString *const ClientAppeal_URL = @"agent/client/appeal";

//经纪人申诉列表
static NSString *const BrokerAppeal_URL = @"agent/work/broker/appeal";

//经纪人申诉详情
static NSString *const BrokerAppealDetail_URL = @"agent/work/broker/appealDetail";

//对接经纪人判断为有效到访
static NSString *const ConfirmValue_URL = @"agent/client/confirmValue";


//对接经纪人判断为无效
static NSString *const ConfirmDisabled_URL = @"agent/client/confirmDisabled";

//经纪人待确认客户详细
static NSString *const WaitConfirmDetail_URL = @"agent/work/broker/waitConfirmDetail";

//经纪人无效客户详细
static NSString *const DisabledDetail_URL = @"agent/work/broker/disabledDetail";

//获取申诉信息
//static NSString *const AppealGetOne_URL = @"agent/appeal/getOne";

//取消申诉
static NSString *const AppealCancel_URL = @"agent/client/appealCancel";

//经纪人有效到访客户详细
static NSString *const ValueDetail_URL = @"agent/work/broker/valueDetail";

//项目待确认列表
static NSString *const ProjectWaitConfirm_URL = @"agent/work/project/waitConfirm";

//项目待确认详情
static NSString *const ProjectWaitConfirmDetail_URL = @"agent/work/project/waitConfirmDetail";

//项目有效列表
static NSString *const ProjectValue_URL = @"agent/work/project/value";

//项目有效详情
static NSString *const ProjectValueDetail_URL = @"agent/work/project/valueDetail";

//项目失效列表
static NSString *const ProjectDisabled_URL = @"agent/work/project/disabled";

//项目失效详情
static NSString *const ProjectDisabledDetail_URL = @"agent/work/project/disabledDetail";

//项目申诉列表
static NSString *const ProjectAppealList_URL = @"agent/work/project/appealList";

//经纪人待成交列表
static NSString *const ProjectWaitDeal_URL = @"agent/work/project/waitDeal";

//经纪人待成交详细
static NSString *const ProjectWaitDealDetail_URL = @"agent/work/project/waitDealDetail";

//经纪人成交列表
static NSString *const ProjectDealList_URL = @"agent/work/project/deal";

//经纪人成交详情
static NSString *const ProjectDealDetail_URL = @"agent/work/project/dealDetail";

//经纪人成交失效列表
static NSString *const ProjectDealDisableList_URL = @"agent/work/project/dealDisabled";

//经纪人成交失效详情
static NSString *const ProjectDeailDisableDetail_URL = @"agent/work/project/dealDisabledDetail";

//经纪人成交申诉列表
static NSString *const ProjectDealAppealList_URL = @"agent/work/project/dealAppealList";

//对接人待确认列表
static NSString *const ButterWaitConfirm_URL = @"agent/work/butter/waitConfirm";

//对接人有效列表
static NSString *const ButterValue_URL = @"agent/work/butter/value";

//对接人无效客户列表
static NSString *const ButterDisabled_URL = @"agent/work/butter/disabled";

#pragma 二手房/租房

#pragma mark -- 二手房-认证

//获取审核信息
static NSString *const StoreAuthState_URL = @"agent/personal/store/auth/state";

//获取门店列表
static NSString *const StoreAuthStoreList_URL = @"agent/personal/store/auth/storeList";

//门店经纪人能力列表
static NSString *const StoreAuthStoreRole_URL = @"agent/personal/store/auth/storeRole";

//认证申请
static NSString *const PersonalSoreAuth_URL = @"agent/personal/store/auth";

#pragma mark -- 二手房-消息
//抢单列表
static NSString *const HouseRecordList_URL = @"agent/house/record/list";

//抢单详情
static NSString *const HouseRecordDetail_URL = @"agent/house/record/detail";

//抢单
static NSString *const HouseGrabRecord_URL = @"agent/house/grabRecord";

//二手房失效详情
static NSString *const MessageWordHouseDisabledDetail_URL = @"agent/message/work/houseDisabledDetail";

//二手房有效信息详情
static NSString *const MessageWordHouseValueDetail_URL = @"agent/message/work/houseValueDetail";


#pragma mark -- 二手房-房源

//房源-关注
static NSString *const UserFocusNews_URL = @"user/focusNews/list";

//项目列表
static NSString *const HouseProjectList_URL = @"user/house/project/list";
//static NSString *const HouseProjectList_URL = @"user/house/project/list";

//房源列表
static NSString *const HouseHouseList_URL = @"user/house/house/list";

//项目详情
static NSString *const HouseProjectDetail_URL = @"user/house/project/detail";

//成交列表
static NSString *const HouseHouseSubHis_URL = @"user/house/house/subHis";

//房源详情
static NSString *const HouseHouseDetail_URL = @"user/house/house/detail";

//楼盘信息
//static NSString *const HouseProjectBuildInfo_URL = @"user/project/buildInfo";

//房源信息
static NSString *const HouseHouseGetHouseAnalyse_URL = @"user/house/house/getHouseAnalyse";

//房源渠道规则
static NSString *const HouseHouseGetDistrictRule_URL = @"user/house/house/getDistrictRule";

//小区渠道规则
static NSString *const HouseProjectGetDistrictRule_URL = @"user/house/project/getDistrictRule";

//订阅项目
static NSString *const PersonalFocusProject_URL = @"agent/personal/focusProject";

//关注房源
static NSString *const PersonalFocusHouse_URL = @"agent/personal/focusHouse";

//取消关注
static NSString *const PersonalCancelFocusHouse_URL = @"agent/personal/cancelFocusHouse";

#pragma mark -- 二手房-工作-报备

//项目地址信息
static NSString *const HouseProjectAddressInfo_URL = @"user/house/project/addressInfo";

//检测是否具备勘察能力
static NSString *const HouseCapacityCheck_URL = @"agent/house/capacityCheck";

//报备
static NSString *const HouseRecord_URL = @"agent/house/record";

//待抢列表
static NSString *const HouseSurveywaitGrab_URL = @"agent/house/survey/waitGrab";

//待抢单详情
static NSString *const HouseRecorWaiGrabDetail_URL = @"agent/house/record/waitGrab/detail";

//有效列表
static NSString *const HouseRecordValueList_URL = @"agent/house/record/value/list";

//有效详情
static NSString *const HouseRecordValueDetail_URL = @"agent/house/record/value/detail";

//无效列表
static NSString *const HouseRecordDisabledList_URL = @"agent/house/record/disabled/list";

//无效详情
static NSString *const HouseRecordDisabledDetail_URL = @"agent/house/record/disabled/detail";

//申诉
static NSString *const HouseRecordAppeal_URL = @"agent/house/record/appeal";

//申诉列表
static NSString *const HouseRecordAppealList_URL = @"agent/house/record/appeal/list";

//申诉详情
static NSString *const HouseRecordAppealDetail_URL = @"agent/house/record/appeal/detail";

#pragma mark -- 二手房-工作-勘察
//勘察待确认列表
static NSString *const HouseSurveyWaitConfirm_URL = @"agent/house/survey/waitConfirm";

//勘察待确认详情
static NSString *const HouseSurveyWaitConfirmDetail_URL = @"agent/house/survey/waitConfirm/detail";

//勘察确认
static NSString *const HouseRecordValue_URL = @"agent/house/record/value";

//勘察失效
static NSString *const HouseRecordDisabled_URL = @"agent/house/record/disabled";

//勘查中列表
static NSString *const HouseSurveyUnderWay_URL = @"agent/house/survey/underway";

//勘查中详情
static NSString *const HouseSurveyUnderWayDetail_URL = @"agent/house/survey/underway/detail";

//勘察时间变更历史
static NSString *const HouseSurveyChangeReserveTimeHis_URL = @"agent/house/survey/changeReserveTime/his";

//变更勘察时间
static NSString *const HouseSurveyChangeReserveTime_URL = @"agent/house/survey/changeReserveTime";

//勘察手动失效
static NSString *const HouseSurveyTimeOut_URL = @"agent/house/survey/timeOut";

//勘察失效列表
static NSString *const HouseSurveyDisabled_URL = @"agent/house/survey/disabled";

//勘察失效详情
static NSString *const HouseSurveyDisabledDetail_URL = @"agent/house/survey/disabled/detail";

//勘察完成列表
static NSString *const HouseSurveyFinish_URL = @"agent/house/survey/finish";


//勘察完成所需自动填充字段
static NSString *const HouseRecordSurveyNeedInfo_URL = @"agent/house/record/surveyNeedInfo";

//获取配套UI
static NSString *const HouseRecordUI_URL = @"user/house/record/UI";

//完成勘察
static NSString *const HouseSurveySuccess_URL = @"agent/house/survey/success";

//修改图片
static NSString *const UpdateImgURL = @"agent/house/survey/updateImg";

#pragma mark -- 勘察维护 --
//勘察维护列表
static NSString *const HouseSurveyList_URL = @"agent/house/survey/list";

//勘察详情
static NSString *const HouseSurveyDetail_URL = @"agent/house/survey/detail";

//添加联系人
static NSString *const HouseSurveyAddContact_URL = @"agent/house/survey/addContact";

//修改联系人
static NSString *const HouseSurveyUpdateContact_URL = @"agent/house/survey/updateContact";

//联系人修改排序
static NSString *const HouseSurveyContactChangeSort_URL = @"agent/house/survey/contact/changeSort";

//修改房源信息
static NSString *const HouseSurveyUpdateHouseInfo_URL = @"agent/house/survey/updateHouseInfo";

//添加跟进记录
static NSString *const HouseSurveyAddFollow_URL = @"agent/house/survey/addFollow";

//添加图片
static NSString *const HouseSurveyAddImg_URL = @"agent/house/survey/addImg";

//修改图片
static NSString *const HouseSurveyUpdateImg_URL = @"agent/house/survey/updateImg";

//删除图片
static NSString *const HouseSurveyDelImg_URL = @"agent/house/survey/delImg";

//下架房源
static NSString *const HouseSurveyCancelSale_URL = @"agent/house/survey/cancelSale";

//下架检测
//static NSString *const HouseSurveyCheckCancel_URL = @"agent/house/survey/checkCancel";


#pragma mark -- 代购合同 --

//获取经办人信息
static NSString *const HouseSubNeedAgent_URL = @"agent/house/sub/need/agent";

//代购所需字段
static NSString *const HouseSubNeedInfo_URL = @"agent/house/sub/need/info";

//添加代购合同
static NSString *const AddPurchaseContract_URL = @"agent/house/sub";

//代购合同列表
static NSString *const PurchaseContractList_URL = @"agent/house/sub/list";

//代购合同详情
static NSString *const PurchaseContractDetail_URL = @"agent/house/sub/detail";

//修改合同
static NSString *const PurchaseHouseSub_URL = @"agent/house/sub";

//修改联系人
static NSString *const HouseSubClientUpdate_URL = @"agent/house/sub/client/update";

//添加联系人
static NSString *const HouseSubClientAdd_URL = @"agent/house/sub/client/add";

//挞定
static NSString *const Breach_URL = @"agent/house/sub/breach";

//挞定列表
static NSString *const BreachList_URL = @"agent/house/sub/breach/list";

//挞定详情
static NSString *const BreachDetail_URL = @"agent/house/sub/breach/detail";





