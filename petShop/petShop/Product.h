//
//  Product.h
//  petShop
//
//  Created by GaryFan on 2016/7/6.
//  Copyright © 2016年 user12. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface Product : NSManagedObject
@property(nonatomic) NSNumber *productID;
@property(nonatomic) NSString *name;
@property(nonatomic) NSNumber *price;
@property(nonatomic) NSString *imageName;
@property(nonatomic) NSDate *insertTime;


@end
