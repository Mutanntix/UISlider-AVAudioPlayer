//
//  ViewController.swift
//  Lesson6
//
//  Created by Мурад Чеерчиев on 18.06.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let topView = MainTopView()
    let frstView = SongView()
    let secondView = SongView()
    
    lazy var songs: [Song] = {
        var song1 = Song("WalkingTheWire", "mp3", imageName: "imagineAlbumImg")
        var song2 = Song("Yesterday", "mp3", imageName: "imagineAlbumImg")
        
        return [song1, song2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializate()
        setupConstraints()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playerVC = segue.destination as! PlayerViewController
        playerVC.songs = songs
        guard let sender = sender as? Int else {
            return
        }

        playerVC.currentSong = songs[sender]
    }
}

//MARK: UI
extension MainViewController {
    private func initializate() {
        addSubviews()
        setupSongViews()
    }
    
    private func addSubviews() {
        [topView, frstView, secondView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupSongViews() {
        for (i, songView) in [frstView, secondView].enumerated() {
            songView.addGestureRecognizer(setupGesture())
            songView.nameLbl.text = songs[i].name
            guard let imageName = songs[i].imageName
            else { return }
            songView.imageView.image = UIImage(named: imageName)
        }
        
    }
}

//MARK: Methods
extension MainViewController {
    @objc private func tapRecognized(_ sender: UIGestureRecognizer) {
        guard let tag = sender.view?.tag
        else { return }
        performSegue(withIdentifier: toPlayer, sender: tag)
    }
    
    private func getModelFromTag(tag: Int) -> Song {
        return songs[tag]
    }
}

//MARK: Constraints
extension MainViewController {
    private func setupConstraints() {
        
        topView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let songViewArr = [frstView, secondView]
        for (i, songView) in songViewArr
            .enumerated() {
            songView.tag = i
            songView.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.95)
                make.leadingMargin.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.1)
                if i == 0 {
                    make.topMargin.equalTo(topView.snp_bottomMargin).multipliedBy(2)
                } else {
                    make.topMargin.equalTo(songViewArr[i - 1].snp_bottomMargin).multipliedBy(1.5)
                }
            }
        }
    }
}


//MARK: UIGestureDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        for songView in [frstView, secondView] {
            guard let touchView = touch.view
            else { return false }
            
            if touchView.isDescendant(of: songView) {
                return true
            }
        }
        return false
    }
    
    private func setupGesture() -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer()
        tap.delegate = self
        tap.addTarget(self, action: #selector(tapRecognized(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        return tap
    }
}
