//
//  ReserveCtrl.m
//  petShop
//
//  Created by GaryFan on 2016/7/12.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "ReserveCtrl.h"

@interface ReserveCtrl (){
    NSDate *adjustTime ;
    NSDateFormatter *dateFormat;
    NSDate *pickerDate ;
}
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ReserveCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    NSDate *afterOneHour = [NSDate dateWithTimeIntervalSinceNow:60*60];
    dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"YYYY-MM-dd H-00-00";
    NSString *minuteStr = [dateFormat stringFromDate:afterOneHour];
    adjustTime= [dateFormat dateFromString:minuteStr];
    //minimumDate 設定  Date + 1 小時後 取整點
    _timePicker.minimumDate = adjustTime;
    _timePicker.minuteInterval = 30;
}

- (IBAction)clickTime:(id)sender {
    
    //先驗證時間
    NSString *result = [self checkTime];
    if ([result isEqualToString:@"error"]) {
        return ;
    }
    
    //  對DB做處理
    pickerDate = _timePicker.date;
    dateFormat.dateFormat = @"YYYY-MM-dd H:mm:ss";
    NSString *pickStr = [dateFormat stringFromDate:pickerDate];
    
    // check
    NSString *status = [self checkReserveStatus:pickStr];
    /* 去除多餘的換行符號   取回mysql的資料時不知為何會被加上換行符號*/
    status  = [status  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    NSLog(@"status= %@",status);
    if ([status isEqualToString:@"no"]) {
        [self showUIAlertCtrl:@"有人預約嚕"];
        return ;
    }
    
    //insert
    NSString *addStatus = [self addReserve:pickStr];
    NSLog(@"addStatus=%@",addStatus);
    if ([addStatus isEqualToString:@"error"]) {
        [self showUIAlertCtrl:@"資料庫新增失敗"];
        return ;
    }
    
    if ([addStatus isEqualToString:@"ok"]) {
        [self showUIAlertCtrl:@"預約成功"];
    }
    
}

-(NSString *)checkReserveStatus:(NSString *) time{
    
    //INSERT INTO `reserve`( `R_TIME`, `R_MEMBER_ID`) VALUES ('2016-07-14 19:00:00',null)
    
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/reserve_check.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"reserveTime=%@",time ];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    return result;
}

-(NSString *)addReserve:(NSString *)time{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/reserve_add.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"reserveTime=%@",time ];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    return result;
}



-(NSString *)checkTime{
    //先判斷是否在現在日期之後
    pickerDate = _timePicker.date;
    NSTimeInterval interval =  [pickerDate timeIntervalSinceDate:adjustTime]     ;
    if (interval == 0) {
        [self showUIAlertCtrl:@"請選擇未來的時間"];
        return @"error";
    }
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setCalendar: [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    //判斷是否在預約時間 10:00~2100
    dateFormat.dateFormat = @"H";
    NSInteger hourInteger =[[dateFormat stringFromDate:pickerDate] integerValue];
    NSLog(@"hourInteger=%ld",(long)hourInteger);
    if (hourInteger>21 || hourInteger<9) {
        [self showUIAlertCtrl:@"未營業"];
        return @"error";
    }
    
    //判斷是否選擇 30
    dateFormat.dateFormat = @"mm";
    NSString *minuteStr = [dateFormat stringFromDate:pickerDate];
    if ([minuteStr isEqualToString:@"30"]) {
        [self showUIAlertCtrl:@"請選擇整點"];
        return @"error";
    }
    return @"" ;
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
