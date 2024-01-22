//
//  DMAuctionScheduleInfo.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/22/24.
//

#import <Foundation/Foundation.h>
#import "DMAuctionScheduleInfoResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMAuctionScheduleInfo : NSObject
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *recordCount;
@property (nonatomic, strong) NSArray *result;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
