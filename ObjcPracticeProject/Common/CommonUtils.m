//
//  CommonUtils.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/9/24.
//

#import "CommonUtils.h"

@implementation CommonUtils

/**
 url에 쿼리스트링 추가
 */
+ (NSString *)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params {
    NSMutableString *urlWithQueryString = [[NSMutableString alloc] initWithString:url];
    if (params) {
        for (id param in params) {
            NSString *key = [param description];
            NSString *value = [[params objectForKey:param] description];
            
            if ([urlWithQueryString rangeOfString:@"?"].location==NSNotFound) {
                [urlWithQueryString appendFormat:@"?%@=%@", key, value];
            } else {
                [urlWithQueryString appendFormat:@"&%@=%@", key, value];
            }
        }
    }
    return urlWithQueryString;
}

/**
 url 검증
 */
+ (NSURLComponents *)componentsWithUrlConvertibleString:(NSString *)UrlConvertibleString {
    NSURLComponents *components = nil;
    @try {
        if ([UrlConvertibleString length] == 0) {
            @throw [NSException exceptionWithName:NSGenericException reason:@"the length of URL convertible string could not be zero" userInfo:nil];
        }
        UrlConvertibleString = [UrlConvertibleString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        components = [NSURLComponents componentsWithString:UrlConvertibleString];
        if (![components isKindOfClass:[NSURLComponents class]]) {
            @throw [NSException exceptionWithName:NSGenericException reason:@"failed to parse the URL convertible string as an URL" userInfo:nil];
        }
        if (components.scheme == nil) {
            components.scheme = @"https";
        }
        if (components.host == nil) {
            components.host = @"domain address";
        }
        if (components.path && components.path.length && ![components.path hasPrefix:@"/"]) {
            components.path = [@"/" stringByAppendingString:components.path];
        }
    } @catch (NSException *exception) {
#if DEBUG
        NSLog(@"Exception >>> %@", [exception description]);
#else
#endif
    } @finally {
    }
    
    return components;
}

+ (WebViewController * _Nullable)getWebView:(NSString *)url params:(NSDictionary * _Nullable)params headerTitle:(NSString * _Nullable)title {
    if (url != nil && url.length > 0) {
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:SB_MAIN bundle:nil];
        WebViewController *webVC = (WebViewController *)[mainSB instantiateViewControllerWithIdentifier:NSStringFromClass([WebViewController class])];
        webVC.requestPath = url;
        if(params != nil && params.count > 0) {
            webVC.requestParam = params;
        }
        if(title != nil && title.length > 0) {
            webVC.headerTitle = title;
        }
        return webVC;
    } else {
        return nil;
    }
}

+ (NSString *)getSystemLanguage {
    NSString *lang = [[NSLocale preferredLanguages] objectAtIndex:0];
    if (![lang hasPrefix:@"ko"]) {
        return @"en";
    }
    return @"ko";
}

@end
