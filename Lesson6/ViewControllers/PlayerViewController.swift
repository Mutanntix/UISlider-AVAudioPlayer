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
    let songDescrtiptionStackView = SongDescriptionStackView()
    lazy var albumImgView: UIImageView = {
        guard let imgName = currentSong.imageName
        else { return UIImageView() }
        let image = UIImage(named: imgName)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    let downBtn = MainButton(systemImageName: "chevron.down",
                             highLightImageName: "chevron.down",
                             color: nil,
                             scale: .default,
                             weight: .regular,
                             pSize: 30,
                             tintColor: .lightGray)
    let shareBtn = MainButton(systemImageName: "square.and.arrow.up",
                              highLightImageName: "square.and.arrow.up.fill",
                              color: nil,
                              scale: .default,
                              weight: .regular,
                              pSize: 30,
                              tintColor: .lightGray)
        
    var songs = [Song]()
    var currentSong: Song!
    var songIndex = 0

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
        updateUI()
        
        navigationController?.navigationBar.isHidden = true
        
        albumImgView.layer.cornerRadius = 10
        albumImgView.clipsToBounds = true
        
    }
    
    private func addSubviews() {
        [btnStackView, sliderView,
        songDescrtiptionStackView,
        albumImgView, downBtn,
        shareBtn].forEach { [unowned self] subview in
            view.addSubview(subview)
        }
    }
    
    private func updateUI() {
        currentSong.getSong()
        
        songDescrtiptionStackView.setupTextForLabels(name: currentSong.name,
                                                     album: currentSong.albumName)
        sliderView.setupTextForLabels(passedTime: "0.0",
                                      leftTime: currentSong.duration)
    }
}

//MARK: Constraints
extension PlayerViewController {
    private func setupConstraints() {
        btnStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.bottomMargin.equalToSuperview()
        }
        
        sliderView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.15)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(btnStackView.snp_topMargin)
        }
        
        songDescrtiptionStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalTo(sliderView.snp_topMargin)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        albumImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(albumImgView.snp.width)
            make.bottomMargin.equalTo(songDescrtiptionStackView.snp_topMargin).inset(-15)
        }
        
        downBtn.snp.makeConstraints { make in
            make.leadingMargin.equalToSuperview()
            make.topMargin.equalToSuperview().multipliedBy(2)
        }
        
        shareBtn.snp.makeConstraints { make in
            make.trailingMargin.equalToSuperview()
            make.topMargin.equalToSuperview().multipliedBy(2)
        }
    }
}

//MARK: Methods
extension PlayerViewController {
    @objc private func playBtnPressed() {
        currentSong.play()
    }
    
    @objc private func nextBtnPressed() {
        guard songIndex < songs.count - 1
        else {
            prevBtnPressed()
            return
        }
        songIndex += 1
        currentSong = songs[songIndex]
    }
    
    @objc private func prevBtnPressed() {
        guard songIndex >= 0
        else {
            nextBtnPressed()
            return
        }
        songIndex -= 1
        currentSong = songs[songIndex]
    }
}
