//
//  ShoppingCartCtrl.h
//  petShop
//
//  Created by GaryFan on 2016/7/6.
//  Copyright © 2016年 user12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDelegate.h"
#import "CheckoutDelegate.h"

@interface ShoppingCartCtrl : UIViewController<ProductDelegate,CheckoutDelegate>


@end
