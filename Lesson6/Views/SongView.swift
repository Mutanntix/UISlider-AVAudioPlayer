//
//  ContactView.swift
//  Lesson5
//
//  Created by Мурад Чеерчиев on 16.06.2022.
//

import UIKit

class SongView: UIView {
    let imageView = SongImageView()
    let nameLbl = HeaderLabel(fontColor: .black,
                              font: .systemFont(ofSize: 15, weight: .bold))
    let btmLine = UIView()
    let durationLbl = HeaderLabel(fontColor: .lightGray,
                                  font: supFont)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        self.imageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initialization()
    }
    
    private func initialization() {
        addSubviews()
        
        setupImg()
        setupNameLbl()
        setupLine()
        setupDurationLbl()
    }
    
    private func addSubviews() {
        [imageView, nameLbl,
         btmLine, durationLbl]
            .forEach({ [unowned self] in
                self.addSubview($0)
                $0.isUserInteractionEnabled = true
            })
    }
    
}

//MARK: Setup subviews
extension SongView {
    private func setupImg() {
        imageView.clipsToBounds = true
        imageView.tintColor = .lightGray
        imageView.frame
        = CGRect(origin: bounds.origin,
                 size: CGSize(width: bounds.height * 0.85,
                              height: bounds.height * 0.85))
    }
    
    private func setupNameLbl() {
        let size = CGSize(width: bounds.width / 2,
                          height: bounds.height / 3)
        let origin = CGPoint(x: bounds.minX + imageView.frame.width * 1.1,
                             y: bounds.minY + 5)
        nameLbl.frame = CGRect(origin: origin,
                               size: size)
    }
    
    
    private func setupLine() {
        let size = CGSize(width: bounds.width - 5,
                          height: 1.5)
        let origin = CGPoint(x: imageView.bounds.minX,
                             y: bounds.maxY * 0.9)
        btmLine.frame = CGRect(origin: origin,
                               size: size)
        btmLine.backgroundColor = .lightGray
    }
    
    private func setupDurationLbl() {
        let size = CGSize(width: bounds.width / 7,
                          height: bounds.height / 4)
        let origin = CGPoint(x: bounds.maxX - size.width * 1.1,
                             y: nameLbl.frame.minY)
        durationLbl.frame = CGRect(origin: origin,
                               size: size)
        durationLbl.textAlignment = .right
    }
}
