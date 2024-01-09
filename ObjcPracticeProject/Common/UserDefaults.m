//
//  UserDefaults.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/9/24.
//

#import "UserDefaults.h"

NSString *const UserDefaultsMemberYn = @"memberYn";

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

@end
