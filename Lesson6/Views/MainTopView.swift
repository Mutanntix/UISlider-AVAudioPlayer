//
//  MainTopView.swift
//  Lesson5
//
//  Created by Мурад Чеерчиев on 15.06.2022.
//

import UIKit

class MainTopView: UIView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        let size = CGSize(width: self.frame.width * 0.8,
                          height: self.frame.height * 0.8)
        label.frame = CGRect(origin: .zero,
                             size: size)
        label.center = CGPoint(x: bounds.midX,
                               y: bounds.midY)
        label.text = "My player"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
