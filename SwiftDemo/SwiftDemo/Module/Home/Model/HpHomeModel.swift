//
//  HpHomeModel.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//  首页相关数据model

import UIKit
import HandyJSON

class HpHomeListModel: HandyJSON {
    var title: String?
    var icon: String?
    var list: [HpHomeItemModel]?
    
    //业务参数
    var styleType: Int = 0//区头样式类型
    var isUnfold: Bool = false//是否展开
    var selectItem: HpHomeItemModel?
    
    required init() {}
    
    // MARK:  mock数据
    static func mockDatas() -> [HpHomeListModel] {
        var ary:[HpHomeListModel] = []
        
        let model1 = HpHomeListModel()
        model1.title = "Select crypto"
        model1.icon = "sdfjsdfs"
        model1.styleType = 1
        model1.list = HpHomeItemModel.mockDatas()
        model1.selectItem = model1.list?.first
        ary.append(model1)
        
        let model2 = HpHomeListModel()
        model2.title = "Network"
        model2.styleType = 1
        model2.list = HpHomeItemModel.mockDatas()
        model2.selectItem = model2.list?.first
        ary.append(model2)
        
        let model3 = HpHomeListModel()
        model3.title = "Withdraw to"
        model3.styleType = 2
        model3.list = HpHomeItemModel.mockDatas()
        model3.selectItem = model3.list?.first
        ary.append(model3)
        
        return ary
    }
}

class HpHomeItemModel: HandyJSON {
    var name: String?
    var icon: String?
    var address: String?
    
    required init() {}
    
    // MARK:  mock数据
    let names:[String] = ["Name1", "Name2", "Name3", "Name4", "Name5"]
    let roads:[String] = ["Road1", "Road2", "Road3", "Road4"]
    let streets:[String] = ["Street1", "Street2", "Street3", "Street4", "Street5", "Street6"]
    
    static func mockDatas() -> [HpHomeItemModel] {
        let count = Int(arc4random()) % 20
        var ary:[HpHomeItemModel] = []
        for i in 0...count {
            let model = HpHomeItemModel()
            if i == 0 {
                model.icon = "sdfsd"
            }
            model.name = model.names[Int(arc4random()) % model.names.count]
            model.address = model.roads[Int(arc4random()) % model.roads.count] + model.streets[Int(arc4random()) % model.streets.count]
            ary.append(model)
        }
        return ary
    }
}


