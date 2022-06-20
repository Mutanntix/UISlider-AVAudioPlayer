//
//  TrackSliderView.swift
//  Lesson6
//
//  Created by Мурад Чеерчиев on 20.06.2022.
//

import UIKit

class TrackSliderView: UIView {
    let slider = CustomSlider(thumbColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
                              tintColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
    let timePassedLbl = HeaderLabel(fontColor: .lightGray,
                                    font: supFont,
                                    .center)
                                    
    let timeLeftLbl = HeaderLabel(fontColor: .lightGray,
                                  font: supFont,
                                  .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLabels()
        setupSlider()
    }
    
    public func setupTextForLabels(passedTime: String, leftTime: String) {
        timePassedLbl.text = passedTime
        timeLeftLbl.text = leftTime
    }
    
    public func setSlidersMaxValue(value: Float) {
        slider.maximumValue = value
        slider.minimumValue = 0.0
    }
    
    public func setCurrentSlidersValue(value: Float) {
        slider.setValue(value, animated: true)
    }
    
    private func addSubviews() {
        [timePassedLbl, timeLeftLbl, slider].forEach {
            [unowned self] subview in
            self.addSubview(subview)
        }
    }
    
    private func setupLabels() {
        let size = CGSize(width: self.bounds.width * 0.2,
                          height: self.bounds.height * 0.2)
        let leftOrigin = CGPoint(x: self.bounds.minX * 1.1,
                                 y: self.bounds.maxY * 0.4)
        let rightOrigin = CGPoint(x: self.bounds.maxX - size.width,
                                  y: self.bounds.maxY * 0.4)
        
        for (i, lbl) in [timePassedLbl, timeLeftLbl].enumerated() {
            lbl.frame.size = size
            switch i {
            case 0:
                lbl.frame.origin = leftOrigin
            case 1:
                lbl.frame.origin = rightOrigin
            default:
                break
            }
        }
    }
    
    private func setupSlider() {
        let size = CGSize(width: self.bounds.width,
                          height: self.bounds.height * 0.5)
        let origin = CGPoint(x: self.bounds.minX,
                             y: self.bounds.maxY - size.height)
        slider.frame = CGRect(origin: origin, size: size)
    }
    
}
