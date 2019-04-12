//
//  BaseRequest.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MBProgressHUD.h"
#import "WaitAnimation.h"

static AFHTTPSessionManager *manager ;
static AFHTTPSessionManager *updatemanager ;
//header头
static NSString *const kACCESSROLE = @"agent";
//static MBProgressHUD *hud ;


@implementation BaseRequest

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure{

    [WaitAnimation startAnimation];
      AFHTTPSessionManager *htttmanger  =   [BaseRequest sharedHttpSessionManager];
    [manager.requestSerializer setValue:[UserModelArchiver unarchive].Token forHTTPHeaderField:@"ACCESS-TOKEN"];
    [manager.requestSerializer setValue:kACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];

    NSString *str = [NSString stringWithFormat:@"%@%@",TestBase_Net,url];
    
    [htttmanger GET:str parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WaitAnimation stopAnimation];
        if ([responseObject[@"code"] integerValue] == 200)
        {
            success(responseObject);
            return;
            
        }else if ([responseObject[@"code"] integerValue] == 401) {
            [BaseRequest showConten:@"账号在其他地点登录，请重新登录！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                [UserModel defaultModel].Token = @"";
                [UserModelArchiver archive];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
            });
            return;
        }else{
            
            if (![responseObject[@"msg"] isEqualToString:@"该项目暂无项目分析"] || ![responseObject[@"msg"] isEqualToString:@"未找到房源信息"]) {
                
                [BaseRequest showConten:responseObject[@"msg"]];
            }
            
            return;
        }
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [WaitAnimation stopAnimation];
        if (failure) {
            failure(error);
           
        }
    }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure{
    [WaitAnimation startAnimation];
    AFHTTPSessionManager *htttmanger  =   [BaseRequest sharedHttpSessionManager];
    [manager.requestSerializer setValue:[UserModelArchiver unarchive].Token forHTTPHeaderField:@"ACCESS-TOKEN"];
    [manager.requestSerializer setValue:kACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];

    NSString *str = [NSString stringWithFormat:@"%@%@",TestBase_Net,url];
    [htttmanger POST:str parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WaitAnimation stopAnimation];
        if ([responseObject[@"code"] integerValue] == 200)
        {
            success(responseObject);
            return ;
            
        }else if ([responseObject[@"code"] integerValue] == 401) {
            [BaseRequest showConten:@"账号在其他地点登录，请重新登录！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                [UserModel defaultModel].Token = @"";
                [UserModelArchiver archive];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
            });
            return;
        }else{
            [BaseRequest showConten:responseObject[@"msg"]];
            return;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WaitAnimation stopAnimation];
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)ThirdLogin:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure{
    
    [WaitAnimation startAnimation];
    AFHTTPSessionManager *htttmanger  =   [BaseRequest sharedHttpSessionManager];
    [manager.requestSerializer setValue:[UserModelArchiver unarchive].Token forHTTPHeaderField:@"ACCESS-TOKEN"];
    [manager.requestSerializer setValue:kACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",TestBase_Net,url];
    [htttmanger POST:str parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WaitAnimation stopAnimation];
        if ([responseObject[@"code"] integerValue] == 200 || [responseObject[@"code"] integerValue] == 400)
        {
            success(responseObject);
            return ;
            
        }else if ([responseObject[@"code"] integerValue] == 401) {
            [BaseRequest showConten:@"账号在其他地点登录，请重新登录！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                [UserModel defaultModel].Token = @"";
                [UserModelArchiver archive];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
            });
            return;
        }else{
            [BaseRequest showConten:responseObject[@"msg"]];
            return;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WaitAnimation stopAnimation];
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)Updateimg:(NSString *)url parameters:(NSDictionary *)parameters constructionBody:(void (^)(id<AFMultipartFormData>))blocks success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WaitAnimation startAnimation];
    NSString *str = [NSString stringWithFormat:@"%@%@",TestBase_Net,url];
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:str]];
  
    AFHTTPSessionManager *htttmanger = [self sharedHttpSessionUpdateManager];
    [updatemanager.requestSerializer setValue:kACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];
    [updatemanager.requestSerializer setValue:[UserModelArchiver unarchive].Token forHTTPHeaderField:@"ACCESS-TOKEN"];

    [htttmanger POST:str parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        blocks(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WaitAnimation stopAnimation];
//        success(responseObject);
        
        if ([responseObject[@"code"] integerValue] == 200 || [responseObject[@"code"] integerValue] == 400)
        {
            success(responseObject);
            return ;
            
        }else if ([responseObject[@"code"] integerValue] == 401) {
            [BaseRequest showConten:@"账号在其他地点登录，请重新登录！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                [UserModel defaultModel].Token = @"";
                [UserModelArchiver archive];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
            });
            return;
        }else{
            
            [BaseRequest showConten:responseObject[@"msg"]];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WaitAnimation stopAnimation];
        failure(error);
    }];
}


+(void)showConten:(NSString *)content
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7f];
    hud.label.text= content;
    hud.label.textColor = [UIColor whiteColor];
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, 10.f*SIZE)];
    //    hud.yOffset = 10.f * SIZE;
    hud.removeFromSuperViewOnHide = YES;
    //    [hud hide:YES afterDelay:1.5];
    [hud hideAnimated:YES afterDelay:1.5];

}



+(AFHTTPSessionManager *)sharedHttpSessionManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    });
    return manager;
}

+(AFHTTPSessionManager *)sharedHttpSessionUpdateManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        updatemanager = [AFHTTPSessionManager manager];
        updatemanager.requestSerializer.timeoutInterval = 10;
        updatemanager.requestSerializer = [AFJSONRequestSerializer serializer];
        updatemanager.responseSerializer = [AFJSONResponseSerializer serializer];
   
        //3.设置允许请求的类别
        updatemanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];

        updatemanager.requestSerializer.timeoutInterval = 30;
    });
    return updatemanager;
}



@end
