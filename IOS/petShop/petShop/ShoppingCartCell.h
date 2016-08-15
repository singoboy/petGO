//
//  ShoppingCartCell.h
//  petShop
//
//  Created by user12 on 2016/8/15.
//  Copyright © 2016年 user12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartStepper.h"



@interface ShoppingCartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet CartStepper *stepper;



@end
