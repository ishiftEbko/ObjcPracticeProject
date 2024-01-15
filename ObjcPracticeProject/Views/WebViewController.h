//
//  WebViewController.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/8/24.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef NSString *WebServiceUrl;

extern WebServiceUrl const _Nonnull testPage; // https://www.naver.com
extern WebServiceUrl const _Nonnull myPageExport; // 수출회원
extern WebServiceUrl const _Nonnull myPageNormal; // 일반회원

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, UIScrollViewDelegate>
@property (strong, nonatomic) NSString *requestPath;
@property (strong, nonatomic) NSDictionary *requestParam;
@property (strong, nonatomic) NSString *headerTitle;
@property (strong, nonatomic, readwrite) NSString *isWatch;
@end

NS_ASSUME_NONNULL_END
