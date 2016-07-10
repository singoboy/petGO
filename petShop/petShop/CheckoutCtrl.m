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
#import "ProductListCtrl.h"

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
            //    NSLog(@"productList_count= %lu",(unsigned long)productList.count);
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTotalPrice];
    // Do any additional setup after loading the view.
}

//This is workaroud !!
- (IBAction)payAction:(id)sender {
       NSString *orderResponse = [self addProductOrder];
        if ([orderResponse  isEqualToString:@"error"]) {
            [self showUIAlertCtrl:@"結帳失敗"];
            return;
        }
    for (int i = 0; i<productList.count;  i++) {
            [self addProductDetail:orderResponse withProduct:productList[i]];
    }
   //此處因該再做detail筆數的確認
    
    //刪除coreData內的資料
    CoreDataHelper *helper = [CoreDataHelper sharedInstance];
    for (int i = 0; i<productList.count;  i++) {
        Product *product = productList[i];
        [helper.managedObjectContext deleteObject:product];
    }
    NSError *error = nil ;
    [helper.managedObjectContext save:&error];
    if (error) {
        NSLog(@"error saving %@",error);
    }
    [self.delegate clearProducts];
    [self showUIAlertCtrl:@"訂單已生成"];
    
      /*以下方法無法切換畫面   只好改用navigation */
//    ProductListCtrl *productListCtrl = [self.storyboard   instantiateViewControllerWithIdentifier:@"productListCtrl"];
//    [self presentViewController:productListCtrl animated:YES completion:nil];
    
}

-(NSString *)addProductOrder{
    
    NSInteger total = [self getTotalPrice];
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/addOrder.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"total=%ld",total];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    return result ;
}


-(NSString *)addProductDetail:(NSString*)orderID  withProduct:(Product *)product {
    
        //使用get 傳productList 　會超過256 上限
        NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/addDetail.php"];
        NSURL *url = [NSURL URLWithString:urlStr];
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        [request setHTTPMethod:@"POST"];
        NSString *postString = [NSString stringWithFormat:@"orderID=%@&productID=%@&name=%@&price=%@",orderID,product.productID,product.name,product.price];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
        NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//        NSLog(@"result= %@",result);
       return result ;
    
}

-(NSString *)deleteProductOrder:(NSString*)orderID{
    return @"";
}

-(NSInteger )getTotalPrice{
    NSInteger totalPrice  = 0;
    
    for (Product* element in productList) {
        totalPrice += [element.price integerValue];
    }
    
    _totalLabel.text=[NSString stringWithFormat:@"總共 %ld 元" ,(long)totalPrice];
    return totalPrice ;
    
}

-(void)showUIAlertCtrl:(NSString *)message{
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"提示" message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction =
    [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];

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
