//
//  LookDetailCtrl.m
//  petShop
//
//  Created by user12 on 2016/8/19.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "LookDetailCtrl.h"


@interface LookDetailCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *detailList ;

@end

@implementation LookDetailCtrl





- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.detailList= [NSMutableArray array];
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.detailList= [NSMutableArray array];  //清空前一位的資料
    NSString *totalStr = [NSString stringWithFormat:@"%ld", (long)self.total ];
    self.totalLabel.text = totalStr;   //Note 使用order傳值有問題
    
    NSURL *url =[NSURL URLWithString:@"http://localhost:8888/petShop/detail_json.php"];
    
    // NSString *parameters = [NSString stringWithFormat:@"memberID=%d",1];
    NSString *parameters =  [NSString stringWithFormat:@"orderID=%@",self.orderID];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    //設定為POST method
    [request setHTTPMethod:@"POST"];
    //NSString　轉成NSData
    NSData *body = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    //利用uploadTask上傳
    NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        self.detailList = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        NSLog(@"list %lu",(unsigned long)self.detailList.count);});

    }];
    [task resume];
    

    
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.detailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    NSMutableDictionary  *dic = self.detailList[indexPath.row];
    
    UILabel * nameLabel = (UILabel*)[cell viewWithTag:01];
    nameLabel.text =dic[@"name"];
    UILabel * priceLabel = (UILabel*)[cell viewWithTag:02];
    priceLabel.text =dic[@"price"];
    UILabel * numberLabel = (UILabel*)[cell viewWithTag:03];
    numberLabel.text =dic[@"number"];

    
    
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
