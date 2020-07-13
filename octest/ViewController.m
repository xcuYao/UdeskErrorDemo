//
//  ViewController.m
//  octest
//
//  Created by yaoning on 7/13/20.
//  Copyright © 2020 yaoning. All rights reserved.
//

#import "ViewController.h"
#import "Udesk.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化公司（appKey、appID、domain都是必传字段）
    UdeskOrganization *organization = [[UdeskOrganization alloc] initWithDomain:@"domain" appKey:@"appKey" appId:@"appId"];

    //注意sdktoken 是客户的唯一标识，用来识别身份,是你们生成传入给我们的。
    //sdk_token: 传入的字符请使用 字母 / 数字 等常见字符集 。就如同身份证一样，不允许出现一个身份证号对应多个人，或者一个人有多个身份证号;其次如果给顾客设置了邮箱和手机号码，也要保证不同顾客对应的手机号和邮箱不一样，如出现相同的，则不会创建新顾客。
    UdeskCustomer *customer = [UdeskCustomer new];
    //必填（请不要使用特殊字符）
    customer.sdkToken = @"sdkToken";
    //非必填可选主键，唯一客户外部标识，用于处理 唯一标识冲突 （请不要随意传值）
    customer.customerToken = @"customerToken";
    //非必填
    customer.nickName = @"测试名字";
    //需要严格按照邮箱规则（没有则不填，不可以为空）
    customer.email = @"test@udesk.cn";
    //需要严格按照号码规则（没有则不填，不可以为空）
    customer.cellphone = @"18888888888";
    customer.customerDescription = @"我是测试";

    //客户自定义字段（非必填）
    UdeskCustomerCustomField *textField = [UdeskCustomerCustomField new];
    textField.fieldKey = @"TextField_390";
    textField.fieldValue = @"测试";
            
    UdeskCustomerCustomField *selectField = [UdeskCustomerCustomField new];
    selectField.fieldKey = @"SelectField_455";
    selectField.fieldValue = @[@0];
            
    customer.customField = @[textField,selectField];

    //初始化sdk
    [UdeskManager initWithOrganization:organization customer:customer];
    
}


@end
