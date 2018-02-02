//
//  Exp_FinalModel.h
//  toone
//
//  Created by 景晓峰 on 2018/2/1.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Exp_FinalModel : JSONModel

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *contentName;

@property (nonatomic,strong) NSString *contentId;

@property (nonatomic,strong) NSString *para_key;

@property (nonatomic,assign) NSInteger type;

@end
