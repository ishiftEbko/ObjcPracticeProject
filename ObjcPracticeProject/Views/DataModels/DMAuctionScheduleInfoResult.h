//
//  DMAuctionScheduleInfoResult.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/22/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMAuctionScheduleInfoResult : NSObject
@property (nonatomic, strong) NSString *displayDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
