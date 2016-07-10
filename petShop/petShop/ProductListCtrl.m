//
//  ProductListCtrl.m
//  petShop
//
//  Created by user12 on 2016/6/30.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "ProductListCtrl.h"
#import "CoreDataHelper.h"
#import "ShoppingCartCtrl.h"


@interface ProductListCtrl ()
@property NSArray *productArray ;

@end

@implementation ProductListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url =[NSURL URLWithString:@"http://localhost:8888/petShop/product_json.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    self.productArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    [self.tableView reloadData];
    
    //    NSLog(@"productJson= %@",self.productArray);
    
    //      NSLog(@"count= %lu",(unsigned long)self.productArray.count);
    
    //NSDictionary *item = menus[0];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.productArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
    
    NSDictionary *item = self.productArray[indexPath.row];
    
    //NSLog(@"item= %@",item);
    
    cell.textLabel.text =  [item objectForKey: @"name"];
    
    cell.detailTextLabel.text = [[item objectForKey: @"price"] stringValue];
    
    
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",price];
    NSURL *imageURL = [NSURL URLWithString:[item objectForKey: @"imageUrl"]];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    
    cell.imageView.image = [UIImage imageWithData:data];
    
    [cell setNeedsLayout];
    
    
    
    return cell;
}


#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = self.productArray[indexPath.row];
    NSLog(@"%ld 筆被案到" ,(long)indexPath.row);
    
    NSString *productID = [item objectForKey: @"productID"];
    NSString *name = [item objectForKey: @"name"];
    NSString *price = [item objectForKey: @"price"];
    NSString *imageName = [item objectForKey: @"imageName"];
    
    NSString *output =  [NSString stringWithFormat:@" %@  加入購物車",name];
    
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
    Product *product= [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
    
    
    
    product.productID= [NSNumber numberWithInt:[productID intValue]];
    product.name=name;
    product.price=[NSNumber numberWithInt:[price intValue]];
    product.imageName=imageName;
    
    product.insertTime = [NSDate date];
    
    [context save:nil];
    
    //FIXME this is not a good method to get viewCtrl
    UINavigationController *navi =[self.tabBarController.viewControllers objectAtIndex:1 ];
    ShoppingCartCtrl *shoppingCartCtrl = [navi.viewControllers objectAtIndex:0];
    self.delegate = shoppingCartCtrl;
    [self.delegate didUpdateCar:product];
    
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"提示"
                                        message:output
                                 preferredStyle:UIAlertControllerStyleAlert];
    // Close
    UIAlertAction *alertAction =
    [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
    /* 請stroybord產生畫面 */
    //    NoteViewController *noteViewController = [self.storyboard   instantiateViewControllerWithIdentifier:@"noteViewController"];
    //    [self.navigationController pushViewController:noteViewController animated:YES];
    
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
