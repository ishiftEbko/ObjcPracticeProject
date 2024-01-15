//
//  UserDefaults.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/9/24.
//

#import "UserDefaults.h"

NSString *const UserDefaultsMemberYn = @"memberYn";
NSString *const UserDefaultsAuthToken = @"authToken";

@implementation UserDefaults
+ (instancetype _Nonnull)shared {
    static id shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}


+ (NSString *)getMemberYn {
    return [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsMemberYn];
}
+ (void)setMemberYn:(NSString *)memberYn {
    [[NSUserDefaults standardUserDefaults] setObject:memberYn forKey:UserDefaultsMemberYn];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isLogin {
    // 로그인 시 얻어오는 DataModel의 유무로 login 여부 파악
    return YES;
}

+ (void)setAuthToken:(NSString *)token {
    NSLog(@"setAuthToken >>> %@", token);
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:UserDefaultsAuthToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getAuthToken {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsAuthToken] != nil) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsAuthToken];
    } else {
        return nil;
    }
}

@end
