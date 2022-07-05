//
//  PlayerViewController.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 28.06.2022.
//

import UIKit
import WebKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var openCloseArrow: UIImageView!
    
    var webView: WKWebView! = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var rewindSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7)
        slider.setThumbImage(UIImage(named: "Thumb_On_ProgressLine"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
        print(rewindSlider.value)
    }
    
    var videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var videoCurrentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleOfVideoLabel: UILabel = {
        let label = UILabel()
        label.text = "Vitaly Zubenko - Song of Youtube app"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var numberOfViewsLabel: UILabel = {
        let label = UILabel()
        label.text = "7 000 000 просмотров"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var playPauseButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Pause")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var nextButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Next")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var previousButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Prev")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var soundMaxButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Sound_Max")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var soundMinButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Sound_Min")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var soundSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7)
        slider.setThumbImage(UIImage(named: "Round_Thumb_VolumeBar"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleVolumeSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleVolumeSliderChange() {
        print(soundSlider.value)
    }
    
    // MARK: - Private properties
    
    private let primaryColor = UIColor(
        red: 230/255,
        green: 63/255,
        blue: 143/255,
        alpha: 1
    )
    
    private let secondaryColor = UIColor(
        red: 114/255,
        green: 17/255,
        blue: 233/255,
        alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        view.addSubview(webView)
        view.addSubview(rewindSlider)
        view.addSubview(videoLengthLabel)
        view.addSubview(videoCurrentTimeLabel)
        view.addSubview(titleOfVideoLabel)
        view.addSubview(numberOfViewsLabel)
        view.addSubview(playPauseButton)
        view.addSubview(nextButton)
        view.addSubview(previousButton)
        view.addSubview(soundMaxButton)
        view.addSubview(soundSlider)
        view.addSubview(soundMinButton)
        
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: 7).isActive = true
        webView.heightAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 720.0/1280.0).isActive = true
        
        rewindSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        rewindSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        rewindSlider.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20).isActive = true
        
        videoLengthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        videoLengthLabel.topAnchor.constraint(equalTo: rewindSlider.bottomAnchor, constant: 0).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        videoCurrentTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        videoCurrentTimeLabel.topAnchor.constraint(equalTo: rewindSlider.bottomAnchor, constant: 0).isActive = true
        videoCurrentTimeLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        videoCurrentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        titleOfVideoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        titleOfVideoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50).isActive = true
        titleOfVideoLabel.topAnchor.constraint(equalTo: rewindSlider.bottomAnchor, constant: 44).isActive = true
        
        numberOfViewsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        numberOfViewsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50).isActive = true
        numberOfViewsLabel.topAnchor.constraint(equalTo: titleOfVideoLabel.bottomAnchor, constant: 9).isActive = true
        
        playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playPauseButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 40).isActive = true
        nextButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        previousButton.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor, constant: -40).isActive = true
        previousButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        soundMaxButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        soundMaxButton.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 45).isActive = true
        soundMaxButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        soundMaxButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        soundSlider.leadingAnchor.constraint(equalTo: soundMinButton.trailingAnchor, constant: 10).isActive = true
        soundSlider.trailingAnchor.constraint(equalTo: soundMaxButton.leadingAnchor, constant: -10).isActive = true
        soundSlider.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 43).isActive = true
        
        soundMinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        soundMinButton.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 45).isActive = true
        soundMinButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        soundMinButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
}
