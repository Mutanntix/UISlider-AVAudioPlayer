//
//  ContactImageView.swift
//  Lesson5
//
//  Created by Мурад Чеерчиев on 16.06.2022.
//

import UIKit

class SongImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(systemName: "person.crop.circle")
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
    }
    
}
