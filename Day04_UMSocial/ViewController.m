//
//  ViewController.m
//  Day04_UMSocial
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "UMSocial.h"

#define kUMKey    @"5657f8a367e58e3b660032d7"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn =[UIButton buttonWithType:0];
    [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"分享" forState:0];
    btn.backgroundColor=[UIColor redColor];
    btn.frame = CGRectMake(20, 20, 100, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:btn];
    
// QQ登录按钮
    UIButton *loginBtn =[UIButton buttonWithType:0];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"QQ登录" forState:0];
    loginBtn.backgroundColor=[UIColor redColor];
    loginBtn.frame = CGRectMake(20, 80, 100, 40);
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:loginBtn];
}
- (void)login:(UIButton *)sender{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
            NSLog(@"SnsInformation is %@",response.data);
        }];
        
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}


-(void)share:(UIButton *)sender{
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self appKey:kUMKey
    shareText:@"你要分享的文字"
shareImage:[UIImage imageNamed:@"icon.png"]
shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToSms,UMShareToEmail,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatFavorite,nil]
delegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






