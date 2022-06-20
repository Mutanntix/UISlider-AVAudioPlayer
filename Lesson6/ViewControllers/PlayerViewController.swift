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
    private var timer: Timer?
    private var sliderTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        initializate()
        setupConstraints()
    }
    
    deinit {
        for elem in [btnStackView.playBtn, btnStackView.forwardBtn,
                     btnStackView.backwardBtn, sliderView.slider] {
            elem.removeTarget(nil,
                              action: nil,
                              for: .allEvents)
        }
        currentSong.stop()
    }
}

//MARK: UI
extension PlayerViewController {
    private func initializate() {
        addSubviews()
        updateUI()
        addBtnTargets()
        setSongDuration()
        setupTimer()
        
        view.backgroundColor = .white
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
        songDescrtiptionStackView.setupTextForLabels(name: currentSong.name,
                                                     album: currentSong.albumName)
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
            make.leadingMargin.equalToSuperview().inset(10)
            make.topMargin.equalToSuperview().multipliedBy(2.2)
        }
        
        shareBtn.snp.makeConstraints { make in
            make.trailingMargin.equalToSuperview().inset(10)
            make.topMargin.equalToSuperview().multipliedBy(2)
        }
    }
}

//MARK: Methods
extension PlayerViewController {
    private func addBtnTargets() {
        btnStackView.playBtn.addTarget(self,
                                       action: #selector(playBtnPressed),
                                       for: .touchUpInside)
        btnStackView.forwardBtn.addTarget(self,
                                          action: #selector(nextBtnPressed),
                                          for: .touchUpInside)
        btnStackView.backwardBtn.addTarget(self,
                                           action: #selector(prevBtnPressed),
                                           for: .touchUpInside)
        sliderView.slider.addTarget(self,
                                    action: #selector(slidersValueChanged(_ :)),
                                    for: .valueChanged)
    }
    
    private func setSongDuration() {
        sliderView.setSlidersMaxValue(value: currentSong.getSongDurationValue())
    }
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                            selector: #selector(updateTime),
                            userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        let timePlayed = currentSong.player.currentTime
        let minutes = Int(timePlayed / 60)
        let seconds = Int(timePlayed) % 60
        let passStr = NSString(format: "%02d:%02d",
                               minutes, seconds) as String
        
        let diffTime = currentSong.getSongDurationValue() - Float(timePlayed)
        let diffMinutes = Int(diffTime / 60)
        let diffSeconds = Int(diffTime.truncatingRemainder(dividingBy: 60))
        let diffStr = NSString(format: "%02d:%02d",
                               diffMinutes, diffSeconds) as String
        sliderView.setupTextForLabels(passedTime: passStr,
                                      leftTime: diffStr)
        sliderView.setCurrentSlidersValue(value: Float(timePlayed))
    }
    
    @objc private func slidersValueChanged(_ sender: UISlider) {
        guard sender == sliderView.slider
        else { return }
        timer?.invalidate()
        sliderTimer.invalidate()
        sliderTimer = Timer.scheduledTimer(withTimeInterval: 0.2,
                                     repeats: false,
                                     block: { [unowned self] _ in
            currentSong.rewindSong(value: sender.value)
            setupTimer()
        })
    }
    
    @objc private func playBtnPressed(_ sender: UIButton) {
        currentSong.play()
    }
    
    @objc private func nextBtnPressed() {
        guard songIndex < songs.count - 1
        else {
            prevBtnPressed()
            return
        }
        currentSong.stop()
        songIndex += 1
        currentSong = songs[songIndex]
        setSongDuration()
        updateUI()
        currentSong.play()
    }
    
    @objc private func prevBtnPressed() {
        guard songIndex > 0
        else {
            nextBtnPressed()
            return
        }
        currentSong.stop()
        songIndex -= 1
        currentSong = songs[songIndex]
        setSongDuration()
        updateUI()
        currentSong.play()
    }
}
