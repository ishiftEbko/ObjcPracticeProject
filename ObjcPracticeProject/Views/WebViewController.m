//
//  WebViewController.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/8/24.
//

#import "WebViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"

#define ABOUT_BLANK @"about:blank"
#define NavigationHeaderHeight 48.0f

WebServiceUrl const myPageExport = @"/";
WebServiceUrl const myPageNormal = @"/";
WebServiceUrl const testPage = @"https://www.google.com";

// MARK: WKWebInterface Handler Function Name
NSString * const showToast = @"showToast";

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *webViewBase;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) WKWebView *popupView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWebViewDelegate];
    [self setLoadUrl];
}

- (void)initCacheCookie {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSSet *websiteSet = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeCookies]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteSet modifiedSince:date completionHandler:^{}];
}

- (void)setWebViewDelegate {
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.delegate = self;
}

- (WKWebViewConfiguration *)configWebView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKProcessPool *pool = [[WKProcessPool alloc] init];
    config.processPool = pool;
    
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    [userController addScriptMessageHandler:self name:showToast];
    
    // ios -> js
    NSString *jScript = @"";
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [userController addUserScript:userScript];
    
    WKWebpagePreferences *webPreference = [[WKWebpagePreferences alloc] init];
    WKPreferences *preference = [[WKPreferences alloc] init];
    if (@available(iOS 14.0, *)) {
        webPreference.allowsContentJavaScript = YES;
    } else {
        preference.javaScriptEnabled = YES;
    }
    
    config.preferences = preference;
    config.defaultWebpagePreferences = webPreference;
    config.userContentController = userController;
    config.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
    
    return config;
}

- (void)initViews:(WKWebViewConfiguration *)config {
    self.webView = [[WKWebView alloc] initWithFrame:self.webViewBase.bounds configuration:config];
    self.webView.translatesAutoresizingMaskIntoConstraints = false; // false 설정이 되어있어야 layout을 코드로 조정 가능
    self.webView.allowsLinkPreview = NO;
    
    [self.webViewBase addSubview:self.webView];
    
    // Constraint는 addSubView가 된 후에 조정해야 함!! View에 올라가지 않았으니 Layout을 조정할 수 없음
    [NSLayoutConstraint activateConstraints:@[
        [self.webView.bottomAnchor constraintEqualToAnchor:self.webViewBase.bottomAnchor],
        [self.webView.topAnchor constraintEqualToAnchor:self.webViewBase.topAnchor],
        [self.webView.leadingAnchor constraintEqualToAnchor:self.webViewBase.leadingAnchor],
        [self.webView.trailingAnchor constraintEqualToAnchor:self.webViewBase.trailingAnchor],
        [self.webView.widthAnchor constraintEqualToAnchor:self.webViewBase.widthAnchor],
        [self.webView.heightAnchor constraintEqualToAnchor:self.webViewBase.heightAnchor],
    ]];
}

- (void) setLoadUrl {
    [self initViews:[self configWebView]];
    [self initCacheCookie];
    
    if (self.requestPath != nil && self.requestPath.length > 0) {
        // 유효하지 않아도 로딩은 되는데, ?(쿼리스트링) 이후로 있는 params가 딱히 영향을 안 주는 것 같기도?
        NSString *loadUrl = [CommonUtils componentsWithUrlConvertibleString:self.requestPath].URL.absoluteString;
        
        NSString *urlWithParams = @"";
        BOOL isLogin = [UserDefaults isLogin];
        if (isLogin) {
            urlWithParams = [NSString stringWithFormat:@"authToken=%@&", [UserDefaults getAuthToken]];
        }
        urlWithParams = [NSString stringWithFormat:@"%@ABLE_LANGUAGE_SELECTION_PARAM=%@", urlWithParams, [CommonUtils getSystemLanguage]];
        
        if ([loadUrl containsString:@"?"]) {
            loadUrl = [NSString stringWithFormat:@"%@&%@", loadUrl, urlWithParams];
        } else {
            loadUrl = [NSString stringWithFormat:@"%@?%@", loadUrl, urlWithParams];
        }
        
        if (self.requestParam) {
            loadUrl = [CommonUtils addQueryStringToUrl:loadUrl params:self.requestParam];
        }
        
        NSLog(@"loadURL >>> %@", loadUrl);
        
        NSURL *requestUrl = [self evaluatedUrlForPath:loadUrl];
        
        if (self.headerTitle != nil && self.headerTitle.length > 0) {
            self.headerTitleLabel.text = self.headerTitle;
        } else {
            [self setHTitle:requestUrl.absoluteString];
        }
        
        NSMutableURLRequest *webRequest = [[NSMutableURLRequest alloc]initWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:(60.0)];
        
        // request에 유효하지 않은 keyValue 설정 시 크래시
//        if ([[CommonUtils getSystemLanguage] isEqualToString:@"ko"]) {
//            [webRequest setValue:@"ko" forKey:@"Accept-Language"];
//        } else {
//            [webRequest setValue:@"en" forKey:@"Accept-Language"];
//        }
        
        [self.webView loadRequest:[[NSURLRequest alloc]initWithURL:requestUrl]];
    }
}

- (void) setHTitle:(NSString *)path {
    NSString *pathForResource = [[NSBundle mainBundle] pathForResource:@"WebViewUrl" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:pathForResource];
    NSArray *headerTitles = root[@"HEADER_TITLE"];
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS URL", path];
    NSArray *filter = [headerTitles filteredArrayUsingPredicate:urlPredicate];
    if (filter.count > 0) {
        NSDictionary *resultDic = [[NSDictionary alloc]initWithDictionary:filter.firstObject];
        NSString *title = resultDic[@"ScreenName"];
        if (title != nil && title.length > 0) {
            self.headerTitleLabel.text = title;
        }
    }
    // zoom이 가능한 놈이 따로 있는 거야???? 왜?????
}

// MARK: Action
- (IBAction)backBtnTouched:(id)sender {
    WKBackForwardList *historyList = [self.webView backForwardList];
    WKBackForwardListItem *backItem = [historyList backItem];
    if (self.webView.canGoBack && ![backItem.URL.absoluteString containsString:ABOUT_BLANK]) {
        [self.webView goBack];
    } else {
        [self closePresentingView];
    }
}

- (IBAction)homeBtnTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)closePresentingView {
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


// MARK: URL
- (NSURL *)evaluatedUrlForPath:(NSString *)requestUrlString {
    requestUrlString = [requestUrlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURL *evaluatedUrl = [NSURL URLWithString:requestUrlString];
    if (evaluatedUrl != nil) {
        return evaluatedUrl;
    }
    
    NSLog(@"INCORRECT PATH >>> %@", requestUrlString);
    NSArray *componentsArray = [requestUrlString componentsSeparatedByString:@"%"];
    if (componentsArray.count < 2) {
        requestUrlString = [requestUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        evaluatedUrl = [NSURL URLWithString:requestUrlString];
        return evaluatedUrl;
    }
    
    NSLog(@"INCORRECT COMPONENTS COUNT >>> %lu", (unsigned long)componentsArray.count);
    NSString *wholeEscaped = @"";
    for (NSString *component in componentsArray) {
        if (component != componentsArray.firstObject) {
            wholeEscaped = [wholeEscaped stringByAppendingString:@"%25"];
        }
        NSString *escaped = [component stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        wholeEscaped = [wholeEscaped stringByAppendingString:escaped];
    }
    
    requestUrlString = [wholeEscaped copy];
    evaluatedUrl = [NSURL URLWithString:requestUrlString];
    return evaluatedUrl;
}

// MARK: WKScriptMessageHandler Delegate
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    NSLog(@"message.name >>> %@", message.name);
    NSLog(@"message.body >>> %@", message.body);
    NSArray *params = nil;
    NSString *delimiter = @"|^|";
    
    // 기존 프로젝트에서는 body를 NSString으로 한정지었는데(아마도 그렇게 약속했을 듯), message.body는 NSNumber, NSString, NSData, NSDic, NSArray, NSNull이 될 수 있음
    // 여기서는 nil 체크만 함
    if (message.body == nil) {
        NSLog(@"NOT DEFINED MESSAGE BODY");
    } else {
        if ([message.body isKindOfClass:[NSString class]]) {
            params = [message.body componentsSeparatedByString:delimiter];
        } else {
            params = [[NSArray alloc] init];
        }
        
        // name에 따라 처리
    }
}

// MARK: WKNavigation Delegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // url 검증: mail, tel일 경우 링크 오픈 등... 
    NSLog(@"navigationAction >>> %@", navigationAction.request);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"response >>> %@", navigationResponse.response);
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        self.popupView = [[WKWebView alloc] initWithFrame:self.webView.frame configuration:configuration];
        self.popupView.autoresizingMask = true;
        self.popupView.navigationDelegate = self;
        self.popupView.UIDelegate = self;
        [self.webView addSubview:self.popupView];
        
        return self.popupView;
    } else {
        return nil;
    }
    
}

// loadingView, headerTitle 처리 등
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation and Error >>> %@", error.debugDescription);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation and Error >>> %@", error.debugDescription);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSLog(@"didReceiveAuthenticationChallenge >>> %@", challenge.debugDescription);
}

// MARK: WKUI Delegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}

@end
