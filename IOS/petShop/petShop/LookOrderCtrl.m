//
//  LookOrderCtrl.m
//  petShop
//
//  Created by user12 on 2016/8/19.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "LookOrderCtrl.h"
#import "LookDetailCtrl.h"

@interface LookOrderCtrl ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property     NSMutableArray *orderList;

@end

@implementation LookOrderCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectView.delegate=self;
    self.collectView.dataSource=self;
    self.collectView.backgroundColor = [UIColor purpleColor];
    self.orderList= [NSMutableArray array];

}

-(void)viewWillAppear:(BOOL)animated{
    self.orderList= [NSMutableArray array];
    NSURL *url =[NSURL URLWithString:@"http://localhost:8888/petShop/order_json.php"];
    
    // NSString *parameters = [NSString stringWithFormat:@"memberID=%d",1];
    NSString *parameters =  [NSString stringWithFormat:@"memberID=%@",self.member.memberID];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    //設定為POST method
    [request setHTTPMethod:@"POST"];
    //NSString　轉成NSData
    NSData *body = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    //利用uploadTask上傳
    NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        self.orderList = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
          [self.collectView reloadData];
        });
        
    }];
    [task resume];
}

#pragma mark UICollectionViewDataSource;
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.orderList.count;
}


//回傳UICollectionView顯示每格資料用的UICollectionViewCell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //透過dequeueReusableCellWithReuseIdentifier:forIndexPath:訊息，
    //將預先設計的cell樣本拿出來使用，
    //其Identifier為cell1的樣本
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
        NSDictionary *item = self.orderList[indexPath.row];
    
    //透過viewWithTag:訊息，
    //找出Tag為100的view，

    UILabel * orderLabel = (UILabel*)[cell viewWithTag:01];
    orderLabel.text =item[@"orderID"];
    UILabel * dateLabel = (UILabel*)[cell viewWithTag:02];
    dateLabel.text =item[@"date"];
    UILabel * totalLabel = (UILabel*)[cell viewWithTag:03];
    totalLabel.text =item[@"total"];
    //[label setText:[orderList objectAtIndex:[indexPath row]]];
    
    //設cell的背景色為blue
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    //回傳cell
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"lookDetail"]) {
        LookDetailCtrl *lookDetailCtrl = segue.destinationViewController;
        UICollectionViewCell *  cell = (UICollectionViewCell *)sender;
        NSIndexPath *indexPath = [self.collectView indexPathForCell:cell];
//        Order *selectOrder = self.orderList[indexPath.row];
//        lookDetailCtrl.order=selectOrder;
        NSMutableDictionary *dic = self.orderList[indexPath.row];
        lookDetailCtrl.orderID =  dic[@"orderID"];
        lookDetailCtrl.total =  [dic[@"total"] integerValue];
        
    }


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
