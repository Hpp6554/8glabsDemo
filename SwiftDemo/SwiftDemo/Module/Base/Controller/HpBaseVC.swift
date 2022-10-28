//
//  HpBaseVC.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//

import Foundation
import UIKit

class HpBaseVC: UIViewController {
    
    @objc func goBack() {
        if self.navigationController != nil && (self.navigationController?.viewControllers.count ?? 0) > 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true) {
                
            }
        }
    }
}
