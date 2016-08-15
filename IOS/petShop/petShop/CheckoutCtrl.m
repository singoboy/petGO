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
#import "MBProgressHUD.h"


@interface CheckoutCtrl ()<UITextFieldDelegate>
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
    self.addressTextField.delegate = self ;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.memberNameLabel.text = self.member.memberName;
}


//This is workaroud !!
- (IBAction)payAction:(id)sender {
    //確認是否有填寫地址
    if (self.addressTextField.text.length == 0) {
        [self showUIAlertCtrl:@"請填寫配送地址"];
        return ;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *orderResponse = [self addProductOrder];
    if ([orderResponse  isEqualToString:@"error"]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    //   [self showUIAlertCtrl:@"訂單已生成"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    // Note 表示切換畫面後還會往下執行
    [self.delegate showUIAlertCtrl:@"訂單已生成"];
    
    
    /* Note  畫面會被UIAlertCtrl卡住無法切換  */
    //    ProductListCtrl *productListCtrl = [self.storyboard   instantiateViewControllerWithIdentifier:@"productListCtrl"];
    //    [self presentViewController:productListCtrl animated:YES completion:nil];
    
    // select * from orders a join detail b on a.O_OrderID = b.D_OrderID where a.O_OrderID = '20160716121116e5c50';
    
}

-(NSString *)addProductOrder{
    
    NSInteger total = [self getTotalPrice];
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/order_add.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"total=%ld&memberID=%@",total,self.member.memberID];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    return result ;
}


-(NSString *)addProductDetail:(NSString*)orderID  withProduct:(Product *)product {
    
    //使用get 傳productList 　會超過256 上限
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/detail_add_android.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"orderID=%@&productID=%@&name=%@&price=%@&quantity=%@&itemTotal=%@",orderID,product.productID,product.name,product.price,product.quantity,[self getItemTotal:product]];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //        NSLog(@"result= %@",result);
    return result ;
    
}

-(NSString *)deleteProductOrder:(NSString*)orderID{
    return @"";
}

// it's worth to discuss that get data from db not coreData ?
- (IBAction)pickMemberAddr:(id)sender {
    self.addressTextField.text = self.member.memberAddr;
}

-(NSInteger )getTotalPrice{
    NSInteger totalPrice  = 0;
    
    for (Product* element in productList) {
        totalPrice += [element.price integerValue] * [element.quantity integerValue];
    }
    
    _totalLabel.text=[NSString stringWithFormat:@"總共 %ld 元" ,(long)totalPrice];
    return totalPrice ;
    
}

-(NSString * )getItemTotal: (Product *)product{
    NSInteger ItemTotal = [product.price  integerValue] *[product.quantity integerValue];
    return [NSString stringWithFormat:@"%ld",(long)ItemTotal]  ;
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES ;
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
