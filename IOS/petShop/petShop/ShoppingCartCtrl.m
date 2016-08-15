//
//  ShoppingCartCtrl.m
//  petShop
//
//  Created by GaryFan on 2016/7/6.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "ShoppingCartCtrl.h"
#import "CoreDataHelper.h"
#import "Product.h"
#import "CheckoutCtrl.h"
#import "Member.h"
#import "CoreDataHelper.h"
#import "ShoppingCartCell.h"


@interface ShoppingCartCtrl ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *productList;
    Member *member ;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation ShoppingCartCtrl
- (IBAction)editAction:(id)sender {
    // self.tableView.editing = ! self.tableView.editing ;
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

-(void)loadData{
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self ;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self getTotalPrice];
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self loadData];
    
    //query from coredata
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
    //要抓取的物件
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Member"];
    
    NSError *error = nil ;
    //執行查詢後的結果
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"getMember error");
        return ;
    }
    
    if (results.count == 0) {
        member = nil ;
        NSLog(@"查無結果");
        return;
    }
    
    member =results[0];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle== UITableViewCellEditingStyleDelete) {
        Product *product = productList[indexPath.row];
        CoreDataHelper *helper = [CoreDataHelper sharedInstance];
        [helper.managedObjectContext deleteObject:product];
        NSError *error = nil ;
        [helper.managedObjectContext save:&error];
        if (error) {
            NSLog(@"error saving %@",error);
        }
        [productList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self getTotalPrice];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return productList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell"];
    
    Product *product = [productList objectAtIndex:indexPath.row];
    
    
    NSString *serverUrl = @"http://localhost:8888/petShop/upload/";
    NSString *imageLocation = [serverUrl stringByAppendingString:product.imageName];
    //    NSLog(@"imageLocation= %@",imageLocation);
    
    NSURL *imageURL = [NSURL URLWithString:imageLocation];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    
    cell.name.text = product.name;
    cell.imageView.image = [UIImage imageWithData:data];
    cell.price.text =   [NSString stringWithFormat:@"%@",product.price];
    cell.number.text =  [NSString stringWithFormat:@"%@",product.quantity];
    cell.stepper.indexPath = indexPath ;
    cell.stepper.value = [product.quantity doubleValue];
    cell.stepper.minimumValue = 1;
    
    return cell;
    
}

//FIXME  not_work_with_reloadRowsAtIndexPaths
-(void)didUpdateCar:(Product *)product{
    
    [productList addObject:product];
    NSInteger index = [productList indexOfObject:product];
    NSLog(@"index %ld",(long)index);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    
    //   [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];   //測試又ok
    
    [self getTotalPrice];
    
    //   [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"checkout"]) {
        if (productList.count ==0) {
            [self showUIAlertCtrl:@"請先選購商品"];
            return ;
        }
        if (member == nil) {
            [self showUIAlertCtrl:@"請先登入會員"];
            return ;
        }
        CheckoutCtrl *checkoutCtrl =segue.destinationViewController;
        checkoutCtrl.delegate = self ;
        checkoutCtrl.member = member;
        
    }
}


-(void)clearProducts{
    productList = [NSMutableArray array];
    [self.tableView reloadData];
    [self getTotalPrice];
}

-(void)getTotalPrice{
    NSInteger totalPrice  = 0;
    
    for (Product* element in productList) {
        totalPrice += [element.price integerValue] * [element.quantity integerValue];
    }
    
    _totalLabel.text=[NSString stringWithFormat:@"總共 %ld 元" ,(long)totalPrice];
    
}




-(IBAction)returnShopCar:(UIStoryboardSegue *)segue{
    
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

- (IBAction)numberCtrl:(CartStepper *)sender {
    
    NSInteger  index = sender.indexPath.row;
    NSLog(@"sender.value %f" , sender.value);
    Product *product =  productList[index];
    product.quantity =  [NSNumber numberWithDouble:sender.value];
    
    NSLog(@"pdoruct.id %@",product.productID);
    
    //update prduct 資料 and save  reload productList  and reload data ;
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Product"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"productID=%@",product.productID]; // If required to fetch specific vehicle
    fetchRequest.predicate=predicate;
    Product *productData=[[context executeFetchRequest:fetchRequest error:nil] lastObject];
    
    productData.quantity = [NSNumber numberWithDouble:sender.value] ;
    
    
    
    [context save:nil];
    
    [self.tableView reloadRowsAtIndexPaths:@[sender.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self getTotalPrice];
    
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
