//
//  DMNoticeListResult.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/17/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMNoticeListResult : NSObject
@property (nonatomic, strong) NSString *noticeTitle;
@property (nonatomic, strong) NSString *noticeDate;
@property (nonatomic, strong) NSString *noticeUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
