//
//  CheckBox.swift
//  MVVM-ios
//
//  Created by Hovhannes Stepanyan on 11/12/18.
//  Copyright © 2018 Matevos Ghazaryan. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    var isChecked: Bool {
        set {
            isSelected = newValue
        }
        get {
            return isSelected
        }
    }
    
    private func initialize() {
        setBackgroundImage(#imageLiteral(resourceName: "ic_checkbox"), for: .normal)
        setBackgroundImage(#imageLiteral(resourceName: "ic_checkbox_checked"), for: .selected)
        addTarget(self, action: #selector(setChecked(_:)), for: .touchUpInside)
    }
    
    @objc private func setChecked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
}
