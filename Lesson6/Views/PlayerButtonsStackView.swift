//
//  PlayerButtonsStackView.swift
//  Lesson6
//
//  Created by Мурад Чеерчиев on 19.06.2022.
//

import UIKit

class PlayerButtonsStackView: UIStackView {
    let playBtn = MainButton(systemImageName: "play",
                             highLightImageName: "play.fill",
                             color: nil,
                             scale: .default,
                             weight: .regular,
                             pSize: 35)
    let shuffleBtn = MainButton(systemImageName: "shuffle",
                                highLightImageName: "shuffle")
    let forwardBtn = MainButton(systemImageName: "forward",
                                highLightImageName: "forward.fill")
    let backwardBtn = MainButton(systemImageName: "backward",
                                 highLightImageName: "backward.fill")
    let repeatBtn = MainButton(systemImageName: "repeat",
                               highLightImageName: "repeat")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        initializate()
    }
    
    private func initializate() {
        setupSubviews()
        self.alignment = .fill
        self.axis = .horizontal
        self.distribution = .fillProportionally
    }
    
    private func setupSubviews() {
        [shuffleBtn, backwardBtn,
         playBtn, forwardBtn, repeatBtn].forEach({ [unowned self] btn in
            switch btn {
            case shuffleBtn, repeatBtn:
                btn.tintColor = .lightGray
            default:
                btn.tintColor = .black
            }
            self.addArrangedSubview(btn)
        })
    }
    
}
