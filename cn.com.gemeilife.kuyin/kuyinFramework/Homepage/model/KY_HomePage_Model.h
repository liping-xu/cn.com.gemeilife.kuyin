//
//  KY_HomePage_Model.h
//  cn.com.gemeilife.kuyin
//
//  Created by lipixu on 2025/8/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KY_HomePage_Model : NSObject

+ (instancetype)kd_HomePage_ModelWithDictionary:(NSDictionary *)dict;

@end

//新办水卡
@interface KY_CreateNewCard_Model : KY_HomePage_Model

+ (instancetype)kd_CreateNewCardWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *height;
@property (nonatomic,assign) BOOL    isSelect;
@property (nonatomic,copy) NSString *placeHolder;
@property (nonatomic,copy) NSString *isIcon;

@end

//设备列表
@interface KY_DeviceList_Model : KY_HomePage_Model

+ (instancetype)KY_DeviceList_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *CreatedAt;
@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *activeAt;
@property (nonatomic,assign) int enable;
@property (nonatomic,copy) NSString *expire;
@property (nonatomic,assign) int expireDay;
@property (nonatomic,copy) NSString *lastTime;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *merchant;
@property (nonatomic,copy) NSString *nick;
@property (nonatomic,copy) NSString *serial;
@property (nonatomic,assign) int status;
@property (nonatomic,assign) int uid;
@property (nonatomic,copy) NSString *uuid;

//@property (nonatomic,copy) NSString *deviceName;
//@property (nonatomic,copy) NSString *date;
@property (nonatomic,assign) CGFloat cellHeight;


@end

//设备详情
@interface KY_DeviceDetail_Model : KY_HomePage_Model

+ (instancetype)KY_DeviceDetail_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;

@end


//打水记录
@interface KY_WaterRecord_Model : KY_HomePage_Model

+ (instancetype)KY_WaterRecord_ModelWithDictionary:(NSDictionary *)dict;

//@property (nonatomic,copy) NSString *title;
//@property (nonatomic,copy) NSString *icon;
@property (nonatomic,assign) int ID;
@property (nonatomic,assign) int afterBalance;
@property (nonatomic,assign) int beforeBalance;
@property (nonatomic,copy) NSString *card;
@property (nonatomic,copy) NSString *deviceName;
@property (nonatomic,assign) int did;
@property (nonatomic,copy) NSString *merchant;
@property (nonatomic,assign) int mid;
@property (nonatomic,assign) int money;
@property (nonatomic,assign) int orderNo;
@property (nonatomic,assign) int payStatus;
@property (nonatomic,copy) NSString *payTime;
@property (nonatomic,assign) int payType;
@property (nonatomic,assign) int price;
@property (nonatomic,assign) int recharge;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,assign) int total;
@property (nonatomic,copy) NSString *trans;
@property (nonatomic,assign) int transactionType;
@property (nonatomic,assign) int type;
@property (nonatomic,assign) int uid;
@property (nonatomic,assign) int water;

@end

//收入记录
@interface KY_Income_Model : KY_HomePage_Model

+ (instancetype)KY_Income_ModelWithDictionary:(NSDictionary *)dict;

//@property (nonatomic,copy) NSString *title;
//@property (nonatomic,copy) NSString *icon;
@property (nonatomic,assign) int ID;
@property (nonatomic,assign) int afterBalance;
@property (nonatomic,assign) int beforeBalance;
@property (nonatomic,copy) NSString *card;
@property (nonatomic,copy) NSString *deviceName;
@property (nonatomic,assign) int did;
@property (nonatomic,copy) NSString *merchant;
@property (nonatomic,assign) int mid;
@property (nonatomic,assign) int money;
@property (nonatomic,assign) int orderNo;
@property (nonatomic,assign) int payStatus;
@property (nonatomic,copy) NSString *payTime;
@property (nonatomic,assign) int payType;
@property (nonatomic,assign) int price;
@property (nonatomic,assign) int recharge;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,assign) int total;
@property (nonatomic,copy) NSString *trans;
@property (nonatomic,assign) int transactionType;
@property (nonatomic,assign) int type;
@property (nonatomic,assign) int uid;
@property (nonatomic,assign) int water;

@end


//分组信息
@interface KY_CreateNewCard_GroupList_Model : KY_HomePage_Model

+ (instancetype)KY_CreateNewCard_GroupList_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *CreatedAt;
@property (nonatomic,copy) NSString *CreatedBy;
@property (nonatomic,copy) NSString *DeletedBy;
@property (nonatomic,assign) int ID;
@property (nonatomic,copy) NSString *UpdatedAt;
@property (nonatomic,copy) NSString *UpdatedBy;
@property (nonatomic,copy) NSString *capacity;
@property (nonatomic,copy) NSString *card;
@property (nonatomic,copy) NSString *device;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *recharge;
@property (nonatomic,assign) int type;
@property (nonatomic,assign) int uid;
@property (nonatomic,copy) NSString *uuid;
    
@end

//点击分组信息后 充值item model
@interface KY_CreateNewCard_Group_ItemList_Model : KY_HomePage_Model

+ (instancetype)KY_CreateNewCard_Group_ItemList_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *CreatedAt;
@property (nonatomic,copy) NSString *CreatedBy;
@property (nonatomic,copy) NSString *DeletedBy;
@property (nonatomic,assign) int ID;
@property (nonatomic,copy) NSString *UpdatedAt;
@property (nonatomic,copy) NSString *UpdatedBy;
@property (nonatomic,assign) int gid;
@property (nonatomic,assign) int give;
@property (nonatomic,assign) int money;
@property (nonatomic,copy) NSString *remark;
@end


//设备最新状态
@interface KY_DeviceDetailStatus_Model : KY_HomePage_Model

+ (instancetype)KY_DeviceDetailStatus_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *value;

@end

//设备最新状态
@interface KY_DeviceDetail_parameterSetting_Model : KY_HomePage_Model

+ (instancetype)KY_DeviceDetail_parameterSetting_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *unit;
@property (nonatomic,copy) NSString *placeholder;

@end

//用户列表
@interface KY_UserList_Model : KY_HomePage_Model

+ (instancetype)KY_UserList_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *CreatedAt;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,assign) int balance;
@property (nonatomic,copy) NSString *medical;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,assign) int point;
@property (nonatomic,copy) NSString *proxy;
@property (nonatomic,assign) int uid;

@end


//用户详情
@interface KY_UserDetail_Model : KY_HomePage_Model

+ (instancetype)KY_UserDetail_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *placeholder;

@end

//水卡列表
@interface KY_WaterCardList_Model : KY_HomePage_Model

+ (instancetype)KY_WaterCardList_ModelWithDictionary:(NSDictionary *)dict;

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,assign) int balance;
@property (nonatomic,copy) NSString *cardNo;
@property (nonatomic,assign) int gid;


@end


NS_ASSUME_NONNULL_END
