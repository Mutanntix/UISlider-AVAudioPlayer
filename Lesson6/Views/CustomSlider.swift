//
//  CustomSlider.swift
//  Lesson6
//
//  Created by Мурад Чеерчиев on 20.06.2022.
//

import UIKit

class CustomSlider: UISlider {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(thumbColor: UIColor, tintColor: UIColor) {
        self.init(frame: .zero)
        self.thumbTintColor = thumbColor
        self.tintColor = tintColor
    }
}
