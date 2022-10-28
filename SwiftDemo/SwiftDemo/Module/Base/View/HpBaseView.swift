//
//  HpBaseView.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import UIKit

class HpBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fm_addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fm_addSubviews() {
        
    }
    
}

class HpBaseTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        fm_addSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fm_addSubView() {
        
    }
}


