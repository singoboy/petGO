//
//  ProductListCtrl.h
//  petShop
//
//  Created by user12 on 2016/6/30.
//  Copyright © 2016年 user12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductDelegate.h"



@interface ProductListCtrl : UITableViewController
@property id<ProductDelegate> delegate;

@end
