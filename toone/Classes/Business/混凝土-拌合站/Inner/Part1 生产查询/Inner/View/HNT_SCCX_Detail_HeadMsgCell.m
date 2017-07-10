//
//  HNT_SCCX_Detail_HeadMsgCell.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_SCCX_Detail_HeadMsgCell.h"
#import "HNT_SCCX_Detail_HeadMsg.h"
#import "HNT_CBCZ_Detail_HeadMsg.h"
#import "HNT_SCCX_Detail_HeadModel.h"
@interface HNT_SCCX_Detail_HeadMsgCell()
@property (nonatomic,weak) IBOutlet UILabel  *  banhezhanminchen ;//  拌合站名称
@property (nonatomic,weak) IBOutlet UILabel  *  chaozuozhe ;//  操作者
//@property (nonatomic,weak) IBOutlet UILabel  *  chuli ;//  处理与否
@property (nonatomic,weak) IBOutlet UILabel  *  chuliaoshijian ;//  出料时间
@property (nonatomic,weak) IBOutlet UILabel  *  gongchengmingcheng ;//  工程名称
@property (nonatomic,weak) IBOutlet UILabel  *  gongdanhao ;//  工单号
@property (nonatomic,weak) IBOutlet UILabel  *  gujifangshu ;//  估计方数
@property (nonatomic,weak) IBOutlet UILabel  *  jiaobanshijian ;//  搅拌时间
@property (weak, nonatomic) IBOutlet UILabel *jbsjLabel;//可变搅拌


@property (nonatomic,weak) IBOutlet UILabel  *  jiaozuobuwei ;//  浇筑部位
@property (nonatomic,weak) IBOutlet UILabel  *  peifanghao ;//  配方号  -->施工配比编号
@property (nonatomic,weak) IBOutlet UILabel  *  qiangdudengji ;//  强度等级
//@property (nonatomic,weak) IBOutlet UILabel  *  shenhe ;//  审核
@property (nonatomic,weak) IBOutlet UILabel  *  shuinipingzhong ;//  水泥品种
@property (nonatomic,weak) IBOutlet UILabel  *  sigongdidian ;//  施工地点
@property (nonatomic,weak) IBOutlet UILabel  *  waijiajipingzhong ;//  外加剂品种
@property (nonatomic,weak) IBOutlet UILabel  *  xinxibianhao ;//  信息编号
@end
@implementation HNT_SCCX_Detail_HeadMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.jbsjLabel.textAlignment = NSTextAlignmentRight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setHeadModel:(HNT_SCCX_Detail_HeadModel *)headModel {
//    self.jbsjLabel.textAlignment = NSTextAlignmentRight;
    _headModel = headModel;
    self.jbsjLabel.text = [NSString stringWithFormat:@"%@:\t",headModel.jiaobanshijian];
}
-(void)setHeadMsg:(HNT_SCCX_Detail_HeadMsg *)headMsg{
    self.banhezhanminchen.text = headMsg.banhezhanminchen ;//  拌合站名称
    self.chaozuozhe.text = headMsg.chaozuozhe ;//  操作者
    self.chuliaoshijian.text = headMsg.chuliaoshijian ;//  出料时间
    self.gongchengmingcheng.text = headMsg.gongchengmingcheng ;//  工程名称
    self.gongdanhao.text = headMsg.gongdanhao ;//  工单号
    self.gujifangshu.text = headMsg.gujifangshu ;//  估计方数
    self.jiaobanshijian.text = headMsg.jiaobanshijian ;//  搅拌时间
    self.jiaozuobuwei.text = headMsg.jiaozuobuwei ;//  浇筑部位
    self.peifanghao.text = headMsg.peifanghao ;//  配方号
    self.qiangdudengji.text = headMsg.qiangdudengji ;//  强度等级
    self.shuinipingzhong.text = headMsg.shuinipingzhong ;//  水泥品种
    self.sigongdidian.text = headMsg.sigongdidian ;//  施工地点
    self.waijiajipingzhong.text = headMsg.waijiajipingzhong ;//  外加剂品种
    self.xinxibianhao.text = headMsg.xinxibianhao ;//  信息编号
}
-(void)setHeadMsg2:(HNT_CBCZ_Detail_HeadMsg *)headMsg{
    self.banhezhanminchen.text = headMsg.banhezhanminchen ;//  拌合站名称
    self.chaozuozhe.text = headMsg.chaozuozhe ;//  操作者
    self.chuliaoshijian.text = headMsg.chuliaoshijian ;//  出料时间
    self.gongchengmingcheng.text = headMsg.gongchengmingcheng ;//  工程名称
    self.gongdanhao.text = headMsg.gongdanhao ;//  工单号
    self.gujifangshu.text = headMsg.gujifangshu ;//  估计方数
    self.jiaobanshijian.text = headMsg.jiaobanshijian ;//  搅拌时间
    self.jiaozuobuwei.text = headMsg.jiaozuobuwei ;//  浇筑部位
    self.peifanghao.text = headMsg.peifanghao ;//  配方号
    self.qiangdudengji.text = headMsg.qiangdudengji ;//  强度等级
    self.shuinipingzhong.text = headMsg.shuinipingzhong ;//  水泥品种
    self.sigongdidian.text = headMsg.sigongdidian ;//  施工地点
    self.waijiajipingzhong.text = headMsg.waijiajipingzhong ;//  外加剂品种
    self.xinxibianhao.text = headMsg.xinxibianhao ;//  信息编号
}

@end
