//
//  CheckoutCtrl.m
//  petShop
//
//  Created by GaryFan on 2016/7/8.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "CheckoutCtrl.h"
#import "CoreDataHelper.h"
#import "Product.h"

@interface CheckoutCtrl ()
{
    NSMutableArray *productList;
}
@property (weak, nonatomic) IBOutlet UILabel *memberNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation CheckoutCtrl
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        productList = [NSMutableArray array];
        //query from coredata
        NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
        //要抓取的物件
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Product"];
        //排序條件
        NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"insertTime" ascending:YES];
        //set 條件
        [request setSortDescriptors:@[timeSort]];
        NSError *error = nil ;
        //執行查詢後的結果
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (error) {
            NSLog(@"error %@",error);
        }
        else{
            [productList addObjectsFromArray:results];
            NSLog(@"productList_count= %lu",(unsigned long)productList.count);
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTotalPrice];
    // Do any additional setup after loading the view.
}


- (IBAction)payAction:(id)sender {
}




-(void)getTotalPrice{
    NSInteger totalPrice  = 0;
    
    for (Product* element in productList) {
        totalPrice += [element.price integerValue];
    }
    
    _totalLabel.text=[NSString stringWithFormat:@"總共 %ld 元" ,(long)totalPrice];
    
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
