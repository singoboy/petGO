//
//  Member.h
//  petShop
//
//  Created by GaryFan on 2016/7/15.
//  Copyright © 2016年 user12. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface Member : NSManagedObject
@property NSNumber * memberID ;
@property NSString * memberAccount;
@property NSString * memberName;
@property NSString * memberAddr;


@end
