//
//  SongDescriptionStackView.swift
//  Lesson6
//
//  Created by Мурад Чеерчиев on 20.06.2022.
//

import UIKit

class SongDescriptionStackView: UIStackView {
    let nameLbl = HeaderLabel(font: 20, aligment: .center)
    let albumLbl = HeaderLabel(fontColor: .lightGray,
                               font: supFont,
                               .center)
    let addBtn = MainButton(systemImageName: "plus.app",
                            highLightImageName: "plus.app.fill",
                            color: nil,
                            scale: .medium,
                            weight: .regular,
                            pSize: 30)
    let moreActionsBtn = MainButton(systemImageName: "ellipsis.circle",
                                    highLightImageName: "ellipsis.circle.fill",
                                    color: nil,
                                    scale: .medium,
                                    weight: .regular,
                                    pSize: 30)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        addSubviews()
        
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAlbumLbl()
    }
    
    public func setupTextForLabels(name: String, album: String) {
        nameLbl.text = name
        albumLbl.text = album
    }
    
    private func addSubviews() {
        nameLbl.addSubview(albumLbl)
        [addBtn, nameLbl, moreActionsBtn]
            .forEach { [unowned self] subview in
                self.addArrangedSubview(subview)
                if subview is UIButton {
                    subview.tintColor = .black

                }
            }
    }
    
    private func setupAlbumLbl() {
        let size = CGSize(width: nameLbl.bounds.width * 0.8,
                          height: nameLbl.bounds.height * 0.5)
        let origin = CGPoint(x: nameLbl.bounds.midX - size.width / 2,
                             y: bounds.minY + size.height * 2.5)
        albumLbl.frame = CGRect(origin: origin,
                                size: size)
    }
    
}
