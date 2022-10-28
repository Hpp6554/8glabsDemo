//
//  HpHomeListVC.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//  首页列表页面

import UIKit

class HpHomeListVC: HpBaseVC {
    //MARK: - 声明属性
    //列表
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(HpBaseTableCell.self, forCellReuseIdentifier: HpBaseTableCell.reuseIdentifier)
        tableView.register(HpHomeCell.self, forCellReuseIdentifier: HpHomeCell.reuseIdentifier)
        tableView.register(HpHomeSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: HpHomeSectionHeaderView.reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: KBottomSafeArea, right: 0)
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        return tableView
    }()

    //当前type
    open var curType: String?
    //是否展开
    private var isUnfold: Bool = false
    //列表
    private var dataList: [HpHomeListModel] = []
}

extension HpHomeListVC {
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadNetData()
    }
}

extension HpHomeListVC {
    //MARK: - 搭建UI
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HpHomeListVC {
    //MARK: - 事件
    //加载数据
    private func loadNetData() {
        getHomeListRequest()
    }
}

extension HpHomeListVC: UITableViewDelegate,UITableViewDataSource {
    //MARK: - 代理
    //MARK: TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionModel = self.dataList.objectOrNil(at: section) as? HpHomeListModel {
            return  sectionModel.isUnfold ? (sectionModel.list?.count ?? 0) : 0
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sectionModel = self.dataList.objectOrNil(at: indexPath.section) as? HpHomeListModel,
           let rowModel = sectionModel.list?.objectOrNil(at: indexPath.row) as? HpHomeItemModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: HpHomeCell.reuseIdentifier, for: indexPath) as! HpHomeCell
            cell.config(model: rowModel)
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: HpBaseTableCell.reuseIdentifier) as! HpBaseTableCell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionModel = self.dataList.objectOrNil(at: section) as? HpHomeListModel else {
            return UIView()
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HpHomeSectionHeaderView.reuseIdentifier) as! HpHomeSectionHeaderView
        headerView.config(model: sectionModel)
        headerView.didSelectViewBlock = {//“券包”区域点击事件
            if (sectionModel.list?.count ?? 0) > 0 {
                sectionModel.isUnfold = !sectionModel.isUnfold
                UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    tableView.reloadSections(IndexSet(integer: section), with: .none)
                    tableView.endUpdates()
                }
            }
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = self.dataList.objectOrNil(at: section) as? HpHomeListModel else {
            return 0.01
        }
        return 100
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sectionModel = self.dataList.objectOrNil(at: indexPath.section) as? HpHomeListModel,
           let rowModel = sectionModel.list?.objectOrNil(at: indexPath.row) as? HpHomeItemModel, (rowModel.icon?.count ?? 0) <= 0 {
            sectionModel.selectItem = rowModel
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
                tableView.endUpdates()
            }
            HpPresentView.show(title:sectionModel.title ?? "title", model: rowModel) {
                UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
                    tableView.endUpdates()
                }
            }
        }
    }
}

extension HpHomeListVC {
    //MARK: - 数据请求
    //获取列表数据请求
    private func getHomeListRequest() {
        self.dataList = HpHomeListModel.mockDatas()
        self.tableView.reloadData()
    }
}
