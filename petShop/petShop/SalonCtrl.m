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
    NSArray *reserveArray ;
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
    reserveArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"Error parsing JSON.");
    }
        [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self ;
    self.tableView.delegate =self;
    
    // Do any additional setup after loading the view.
}

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
