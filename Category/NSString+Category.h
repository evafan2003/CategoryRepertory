//
//  PK-ios
//
//  Created by peikua on 15/9/15.
//  Copyright (c) 2015年 peikua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (Category)


//电话号码中间4位****显示
+ (NSString*) getSecrectStringWithPhoneNumber:(NSString*)phoneNum;

//银行卡号中间8位显示
+ (NSString*) getSecrectStringWithAccountNo:(NSString*)accountNo;

//计算文字高度
- (CGFloat   ) heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width;

/**抹除运费小数末尾的0*/
- (NSString *) removeUnwantedZero;

//去掉前后空格
- (NSString *) trimmedString;


- (NSMutableDictionary *)getURLParameters;

//根据身份证号获取生日
-(NSString *)birthdayStrFromIdentityCard;

//根据身份证号性别
-(NSString *)getIdentityCardSex;

//根据省份证号获取年龄
-(NSString *)getIdentityCardAge;
@end


@interface NSString (Base64)
//Data类型转换为Base64
+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;
@end


@interface NSString (Format)
//转为电话格式
//+ (NSString*) stringMobileFormat:(NSString*)mobile;

//数组中文格式（几万）可自行添加
//+ (NSString*) stringChineseFormat:(double)value;


+(NSString *) utf8ToUnicode:(NSString *)string;
@end
