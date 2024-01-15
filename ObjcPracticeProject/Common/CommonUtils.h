//
//  CommonUtils.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/9/24.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class WebViewController;

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtils : NSObject

+ (NSString *)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params;
+ (NSURLComponents *)componentsWithUrlConvertibleString:(NSString *)UrlConvertibleString;
+ (WebViewController * _Nullable)getWebView:(NSString *)url params:(NSDictionary * _Nullable)params headerTitle:(NSString * _Nullable)title;
+ (NSString *)getSystemLanguage;

@end

NS_ASSUME_NONNULL_END
