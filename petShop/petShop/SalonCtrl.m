//
//  SalonCtrl.m
//  petShop
//
//  Created by GaryFan on 2016/7/12.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "SalonCtrl.h"

@interface SalonCtrl ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *reserveArray ;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SalonCtrl

-(void)viewWillAppear:(BOOL)animated{
    NSInteger memberID = 1 ;
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/reserve_json.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"memberID=%ld",(long)memberID ];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *error = nil;
    
    /* notices 回傳的是 NSARRAY 不是 NSMUTABLEARRAY */
     NSArray  *jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    reserveArray = [jsonArray mutableCopy];
    
    if (error != nil) {
        NSLog(@"Error parsing JSON.");
    }
        [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self ;
    self.tableView.delegate =self;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Do any additional setup after loading the view.
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return reserveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reserveCell" forIndexPath:indexPath];
    
    NSDictionary *item = reserveArray[indexPath.row];
    
    cell.textLabel.text =  [item objectForKey: @"R_TIME"];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"會員ID:%@",[[item objectForKey: @"R_MEMBER_ID"] stringValue]];
    
    
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

@end
