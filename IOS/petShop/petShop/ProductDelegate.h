//
//  ProductDelegate.h
//  petShop
//
//  Created by GaryFan on 2016/7/7.
//  Copyright © 2016年 user12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@protocol ProductDelegate <NSObject>
-(void)didUpdateCar:(Product *)product;

@end
