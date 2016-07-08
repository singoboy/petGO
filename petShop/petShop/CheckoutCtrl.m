//
//  CheckoutCtrl.m
//  petShop
//
//  Created by GaryFan on 2016/7/8.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "CheckoutCtrl.h"
#import "CoreDataHelper.h"

@interface CheckoutCtrl ()
@property (weak, nonatomic) IBOutlet UILabel *memberNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation CheckoutCtrl
- (IBAction)payAction:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
