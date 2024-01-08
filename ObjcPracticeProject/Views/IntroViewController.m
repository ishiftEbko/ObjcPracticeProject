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
    NSLog(@"IntroViewController ViewDidLoad");
    self.testLabel.text = @"안녕하세요??????";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self goMain];
    });
}

- (void)goMain {
    NSLog(@"goMain");
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
