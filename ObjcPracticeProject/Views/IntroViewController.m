//
//  IntroViewController.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/8/24.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testLabel.text = @"IntroViewController";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self goMain];
    });
    
    // backgroundView 세팅
    // 언어 변경 세팅
    // 로딩 gif 이미지 세팅
    // 자동로그인 안내 문구 세팅
    // 로딩 이미지, 자동로그인 문구 hidden 처리
    // 버전 체크 -> 자동로그인 확인 -> 성공 시 로그인 정보 세팅 및 푸시 등록
    //                       -> 실패 시 정보 초기화 및 메인 이동
    //                                토큰 갱신 -> 실패 시 정보 초기화 및 메인 이동
    //                                        -> 성공 시 로그인 정보 세팅 및 메인 이동
    // 토큰 갱신과 로그인 API는 동일 
}

- (void)goMain {
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainNaviVC = [mainSB instantiateViewControllerWithIdentifier:@"MainNavigationVC"];

    NSArray<UIWindow *> *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        NSLog(@"window >>> %@", window);
        if (window.isKeyWindow) {
            window.rootViewController = mainNaviVC;
            [window makeKeyAndVisible];
        }
    }
}



@end
