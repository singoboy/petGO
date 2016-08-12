//
//  CheckoutCtrl.h
//  petShop
//
//  Created by GaryFan on 2016/7/8.
//  Copyright © 2016年 user12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckoutDelegate.h"
#import "Member.h"

@interface CheckoutCtrl : UIViewController
@property id<CheckoutDelegate>  delegate;
@property  Member *member ;
@end
