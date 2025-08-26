//
//  WXZPickDateTimeView.m
//  自定义选择器
//
//  Created by lipixu on 2025/8/19.
//  Copyright © 2025 WOSHIPM. All rights reserved.
//

#import "WXZPickDateTimeView.h"

@interface WXZPickDateTimeView()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 选择的年 */
@property (nonatomic, assign)NSInteger selectYear;
/** 选择的月 */
@property (nonatomic, assign)NSInteger selectMonth;
/** 选择的日 */
@property (nonatomic, assign)NSInteger selectDay;

@property (nonatomic, assign)NSInteger selectHour;

@property (nonatomic, assign)NSInteger selectMinute;

@property (nonatomic, assign)NSInteger currentYear;
@property (nonatomic, assign)NSInteger currentMonth;
@property (nonatomic, assign)NSInteger currentDay;
@property (nonatomic, assign)NSInteger currentHour;
@property (nonatomic, assign)NSInteger currentMinute;

@property (nonatomic, assign)NSInteger defaultYear;
@property (nonatomic, assign)NSInteger defaultMonth;
@property (nonatomic, assign)NSInteger defaultDay;
@property (nonatomic, assign)NSInteger defaultHour;
@property (nonatomic, assign)NSInteger defaultMinute;

@property (nonatomic, assign)NSInteger minShowYear;

@property (nonatomic, assign)NSInteger yearSum;
@end

@implementation WXZPickDateTimeView

- (void)initPickView
{
    [super initPickView];
    
    
    _minShowYear = 1940;//最小年份
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 指定获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    
    _yearSum = comp.year - _minShowYear + 100;
    _currentYear=comp.year;
    _currentMonth=comp.month;
    _currentDay=comp.day;
    _currentHour = comp.hour;
    _currentMinute = comp.minute;
 
    
    _selectYear  = comp.year;
    _selectMonth = comp.month;
    _selectDay   = comp.day;
    _selectHour  = comp.hour;
    _selectMinute = comp.minute;
    
    
     _defaultYear = comp.year;
    _defaultMonth = comp.month;
    _defaultDay = comp.day;
    _defaultHour = comp.hour;
    _defaultMinute = comp.minute;
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
}

-(void)setDefaultTSelectYear:(NSInteger)defaultSelectYear defaultSelectMonth:(NSInteger)defaultSelectMonth defaultSelectDay:(NSInteger)defaultSelectDay defaultSelectHour:(NSInteger)defaultSelectHour defaultSelectMinute:(NSInteger)defaultSelectMinute
{
    if (defaultSelectYear!=0) {
     _defaultYear=defaultSelectYear;
    }
    
    if (defaultSelectMonth!=0) {
        _defaultMonth = defaultSelectMonth;
    }
    
    if (defaultSelectDay!=0) {
         _defaultDay=defaultSelectDay;
    }
    
    if (defaultSelectHour != 0) {
        _defaultHour = defaultSelectHour;
    }
    
    if (defaultSelectMinute != 0) {
        _defaultMinute = defaultSelectMinute;
    }
    
    
    if (defaultSelectYear==-1) {
        _defaultYear=_currentYear+1;
        _defaultMonth=1;
        _defaultDay=1;
        _defaultHour = 1;
        _defaultMinute = 1;
    }
   
   
    [self.pickerView selectRow:(_defaultYear - _minShowYear) inComponent:0 animated:NO];

    [self.pickerView selectRow:(_defaultMonth - 1) inComponent:1 animated:NO];
        [self.pickerView reloadComponent:1];
    
    
    [self.pickerView selectRow:(_defaultDay-1) inComponent:2 animated:NO];
    [self.pickerView reloadComponent:2];

    
    
    [self.pickerView selectRow:_defaultHour inComponent:3 animated:NO];
    
    [self.pickerView reloadComponent:3];
    
    [self.pickerView selectRow:_defaultMinute inComponent:4 animated:NO];
    
    [self.pickerView reloadComponent:4];
               
    
//
    [self refreshPickViewData];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearSum;
    }else if(component == 1) {
        
        return 12;
    }else if(component == 2) {
        
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        return  [self getDaysWithYear:yearSelected month:monthSelected];
        
    } else if(component == 3) {
        return 24;
    } else {
        return 60;
    }
}

- (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    //每一行的高度
    return 36;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSInteger selectYear;
    NSInteger selectMonth;
    
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            selectYear = row + _minShowYear;
            break;
        case 1:
            selectMonth = row + 1;
            
        case 2:
        case 3:
        case 4:
            
        default:
            break;
    }
    [self refreshPickViewData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%zd年", row + _minShowYear];
        
    }else if (component == 1){
        text =  [NSString stringWithFormat:@"%zd月", row + 1];
    }else if (component == 2) {
        text = [NSString stringWithFormat:@"%zd日", row + 1];
    }else if (component == 3) {
        if (row<10) {
            text =  [NSString stringWithFormat:@"0%zd时", row];
        }else{
            text =  [NSString stringWithFormat:@"%zd时", row];
        }
    } else {
        if (row<10) {
            text =  [NSString stringWithFormat:@"0%zd分", row ];
        }else{
            text =  [NSString stringWithFormat:@"%zd分", row ];
        }
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    
    return label;
}

- (void)clickConfirmButton
{
    
    
    if ([self.delegate respondsToSelector:@selector(pickerDateView:selectYear:selectMonth:selectDay:selectHour:selectMinute:)]) {
        
        [self.delegate pickerDateView:self selectYear:self.selectYear selectMonth:self.selectMonth selectDay:self.selectDay selectHour:self.selectHour selectMinute:self.selectMinute];
    }
    
    [super clickConfirmButton];
    
}



- (void)refreshPickViewData
{
    
    self.selectYear  = [self.pickerView selectedRowInComponent:0] + self.minShowYear;
    
    self.selectMonth = [self.pickerView selectedRowInComponent:1] + 1;
    
    self.selectDay   = [self.pickerView selectedRowInComponent:2] + 1;
    
    self.selectHour  = [self.pickerView selectedRowInComponent:3];
    
    self.selectMinute = [self.pickerView selectedRowInComponent:4];
    
}

- (void)setYearLeast:(NSInteger)yearLeast
{
    _minShowYear = yearLeast;
}

- (void)setYearSum:(NSInteger)yearSum
{
    _yearSum = yearSum;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
