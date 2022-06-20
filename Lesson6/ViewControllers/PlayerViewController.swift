//
//  PlayerViewController.swift
//  Lesson6
//
//  Created by Мурад Чеерчиев on 18.06.2022.
//

import UIKit
import SnapKit

class PlayerViewController: UIViewController {
    let btnStackView = PlayerButtonsStackView()
    let sliderView = TrackSliderView()
    
    var songs = [Song]()
    var currentSong: Song!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializate()
        setupConstraints()
    }
}

//MARK: UI
extension PlayerViewController {
    private func initializate() {
        addSubviews()
    }
    
    private func addSubviews() {
        [btnStackView, sliderView].forEach { [unowned self] subview in
            view.addSubview(subview)
        }
    }
}

//MARK: Constraints
extension PlayerViewController {
    private func setupConstraints() {
        btnStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.bottomMargin.equalToSuperview()
        }
        
        sliderView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.15)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(btnStackView.snp_topMargin)
        }
    }
}
