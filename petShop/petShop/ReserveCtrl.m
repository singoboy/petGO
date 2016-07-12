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
    //先判斷是否在現在日期之後
    NSDate *pickerDate = _timePicker.date;
    NSTimeInterval interval =  [pickerDate timeIntervalSinceDate:adjustTime]     ;
    if (interval == 0) {
        [self showUIAlertCtrl:@"請選擇未來的時間"];
        return;  //不往下執行
    }
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setCalendar: [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    //判斷是否在預約時間 10:00~2100
        dateFormat.dateFormat = @"H";
        NSInteger hourInteger =[[dateFormat stringFromDate:pickerDate] integerValue];
    NSLog(@"hourInteger=%ld",(long)hourInteger);
    if (hourInteger>21 || hourInteger==0) {
        [self showUIAlertCtrl:@"已關店"];
        return;
    }
    
    if (hourInteger<9) {
        [self showUIAlertCtrl:@"尚未營業"];
        return;
    }

    //判斷是否選擇 30

        dateFormat.dateFormat = @"mm";
        NSString *minuteStr = [dateFormat stringFromDate:pickerDate];
    if ([minuteStr isEqualToString:@"30"]) {
        [self showUIAlertCtrl:@"請選擇整點"];
        return;  //不往下執行
    }
    
    //  開始接受預約
    
    
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
