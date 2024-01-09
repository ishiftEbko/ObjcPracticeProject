//
//  UserDefaults.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/9/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaults : NSObject

// MARK: Singleton Interface
+ (instancetype _Nonnull)shared;

// MARK: UserDefaults
+ (void)setMemberYn:(NSString *)memberYn;
+ (NSString *)getMemberYn;


@end

NS_ASSUME_NONNULL_END
