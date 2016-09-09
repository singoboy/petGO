//
//  SalonCtrl.m
//  petShop
//
//  Created by GaryFan on 2016/7/12.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "SalonCtrl.h"
#import "Member.h"
#import "CoreDataHelper.h"
#import "ReserveCtrl.h"

@interface SalonCtrl ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *reserveArray ;
    Member *member ;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SalonCtrl

-(void)viewWillAppear:(BOOL)animated{
    
       [self queryMemberFromCoreData];
//    if ([returnStr isEqualToString:@"error"]) {
//        [self showUIAlertCtrl:@"尚未登入"];
//        return;
//    }
    
    //同步取得改成異步取得 0716
//    NSNumber *memberID = member.memberID ;
//    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/reserve_json.php"];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    [request setHTTPMethod:@"POST"];
//    NSString *postString = [NSString stringWithFormat:@"memberID=%@",memberID];
//    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSError *error = nil;
//    
//    /* notices 回傳的是 NSARRAY 不是 NSMUTABLEARRAY */
//     NSArray  *jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
//    reserveArray = [jsonArray mutableCopy];
//    
//    if (error != nil) {
//        NSLog(@"Error parsing JSON.");
//        return ;
//    }
//        [self.tableView reloadData];
    
    /*  異步開始 */
    NSNumber *memberID = member.memberID ;
    NSURL *url =[NSURL URLWithString:@"http://localhost:8888/petShop/reserve_json.php"];
    
    NSString *postString = [NSString stringWithFormat:@"memberID=%@",memberID];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    //設定為POST method
    [request setHTTPMethod:@"POST"];
    //NSString　轉成NSData
    NSData *body = [postString  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    //利用uploadTask上傳
    NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
            /* notices 回傳的是 NSARRAY 不是 NSMUTABLEARRAY */
             NSArray  *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            reserveArray = [jsonArray mutableCopy];
        
            if (error != nil) {
                NSLog(@"Error parsing JSON.");
                return ;
            }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    [task resume];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self ;
    self.tableView.delegate =self;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.80 green:0.50 blue:0.79 alpha:1.0];
        self.tableView.rowHeight = 40;

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    reserveArray = [NSMutableArray array];
    
    self.tableView.layoutMargins = UIEdgeInsetsMake(20, 0, 20, 0);
    
    // Do any additional setup after loading the view.
}


-(NSString *)queryMemberFromCoreData{
    //query from coredata
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
    //要抓取的物件
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Member"];
    
    NSError *error = nil ;
    //執行查詢後的結果
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"getMember error");
        return @"error";
    }
    
    if (results.count == 0) {
        member = nil ;
        NSLog(@"查無結果");
         return @"error";
    }
    
    member =results[0];
    return @"ok";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"reserve"]) {
        if ( member == nil) {
            [self showUIAlertCtrl:@"請先登入會員"];
            return ;
        }
        
        ReserveCtrl *reserveCtrl =segue.destinationViewController;
        reserveCtrl.member = member;
    }
 
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return reserveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reserveCell" forIndexPath:indexPath];
    
    NSDictionary *item = reserveArray[indexPath.row];
    
    cell.textLabel.text =  [item objectForKey: @"R_TIME"];
    

    cell.detailTextLabel.text = [NSString stringWithFormat:@"預約人   %@",item[@"M_Name"]];
    
    
    return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  //點了 不會一直是在選取狀態
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle== UITableViewCellEditingStyleDelete) {
        //先判斷是不是同一個人才可以刪   //是 id不同才不能刪  //NSSTRING isEqualToString 不只會比值還會比型態！！！NSLOG印看都一樣 !!
        
        NSDictionary *dic  =  reserveArray[indexPath.row] ;
        NSString *arrayMemIDStr  = [dic[@"R_MEMBER_ID"] stringValue];
        NSString *memberIDStr   =[member.memberID stringValue];

        if (![memberIDStr isEqualToString:arrayMemIDStr]) {
            [self showUIAlertCtrl:@"只能取消自己預約的時間"];
                    return ;
        }

        // 去 db刪
        NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/reserve_delete.php"];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        [request setHTTPMethod:@"POST"];
           NSDictionary *item = reserveArray[indexPath.row];
           NSInteger R_ID = [item[@"R_ID"] integerValue] ;
        
        NSString *postString = [NSString stringWithFormat:@"R_ID=%d",R_ID];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSLog(@"result=%@",result);
        if ([result isEqualToString:@"error"]) {
            [self showUIAlertCtrl:@"DB刪除失敗"];
            return;
        }
        
        //從array 刪去那一筆
        
        [reserveArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*   bug with string
 NSDictionary *dic  =  reserveArray[indexPath.row] ;
 NSString *arrayMemIDStr  = dic[@"R_MEMBER_ID"];  //type  (long)8
 NSString *memberIDStr   =[member.memberID stringValue];    8
 NSLog(@"arrayMemIDStr=%@",arrayMemIDStr);
 NSLog(@"memberIDStr=%@",memberIDStr);
 if ([memberIDStr isEqualToString:arrayMemIDStr]) {
 [self showUIAlertCtrl:@"相同"];
 return ;
 }
 else{
 [self showUIAlertCtrl:@"不相同"];
 return ;
 }
 
 */

@end
