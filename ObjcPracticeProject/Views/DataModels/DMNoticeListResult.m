//
//  DMNoticeListResult.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/17/24.
//

#import "DMNoticeListResult.h"

// 보통은 const로 key 값을 설정
NSString *const kDMNoticeListResultNoticeTitle = @"noticeTitle";
NSString *const kDMNoticeListResultNoticeDate = @"noticeDate";
NSString *const kDMNoticeListResultNoticeUrl = @"noticeUrl";

@interface DMNoticeListResult()
@end

@implementation DMNoticeListResult
-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (![dictionary[kDMNoticeListResultNoticeTitle] isKindOfClass:[NSNull class]]) {
        self.noticeTitle = dictionary[kDMNoticeListResultNoticeTitle];
    }
    if (![dictionary[kDMNoticeListResultNoticeDate] isKindOfClass:[NSNull class]]) {
        self.noticeDate = dictionary[kDMNoticeListResultNoticeDate];
    }
    if (![dictionary[kDMNoticeListResultNoticeUrl] isKindOfClass:[NSNull class]]) {
        self.noticeUrl = dictionary[kDMNoticeListResultNoticeUrl];
    }
    return self;
}
-(NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.noticeTitle != nil) {
        dictionary[kDMNoticeListResultNoticeTitle] = self.noticeTitle;
    }
    if (self.noticeDate != nil) {
        dictionary[kDMNoticeListResultNoticeDate] = self.noticeDate;
    }
    if (self.noticeUrl != nil) {
        dictionary[kDMNoticeListResultNoticeUrl] = self.noticeUrl;
    }
    return dictionary;
}

@end
