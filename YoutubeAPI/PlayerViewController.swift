//
//  PlayerViewController.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 28.06.2022.
//

import UIKit
import WebKit
import AVFoundation
import MediaPlayer
import youtube_ios_player_helper

class PlayerViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var openCloseArrow: UIImageView!
    
    // Property representing the video to display. And it could be nil, so - ?
    var video: Video?
    var currentVideoId: String?
    var durationOfVideo: Double?
    
    var webView: YTPlayerView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let webView = YTPlayerView(frame: .zero)
//        webView.allowsInlineMediaPlayback = true
        webView.backgroundColor = .black
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
        
        if let durationOfVideo = durationOfVideo {
            let seekToTime = Float(durationOfVideo * Double(rewindSlider.value))
            
            webView.seek(toSeconds: seekToTime, allowSeekAhead: true)
        }
        
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
        label.text = "Vitaly Zubenko - APESHIT (Official Video)"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
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
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Play")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(tapPause), for: .touchUpInside)
        
        return button
    }()
    
    // Надо сделать зависимой от статуса видео
    var isPlaying = true
    
    @objc func tapPause() {
        if isPlaying {
            webView.playVideo()
            pausePlayButton.setImage(UIImage(named: "Pause"), for: .normal)
            isPlaying = false
            print("play player")
        } else {
            webView.pauseVideo()
            pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
            isPlaying = true
            print("pause player")
        }
//        isPlaying = !isPlaying
        
//        audioPlayer.play()
//        view.backgroundColor = UIColor.clear
//        view.addSubview(wrapperView)
//        let volumeView = MPVolumeView(frame: wrapperView.bounds)
//        wrapperView.addSubview(volumeView)
        
        // ПРОВЕРИТЬ
//        webView.playerState { state, error in
//            guard error != nil else { return }
//
//            print(state)
//        }
        
    }
    
    var nextButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Next")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    var previousButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Prev")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
//    var soundMaxButton: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "Sound_Max")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
    
//    var soundMinButton: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "Sound_Min")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
    
    lazy var soundSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7)
        let thumbImage = UIImage(named: "Thumb_VolumeBar")?.resized(to: CGSize(width: 22, height: 22))
        slider.setThumbImage(thumbImage, for: .normal)
        slider.minimumValueImage = UIImage(named: "Sound_Min")
        slider.maximumValueImage = UIImage(named: "Sound_Max")
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.value = AVAudioSession.sharedInstance().outputVolume
        
        slider.addTarget(self, action: #selector(handleVolumeSliderChange), for: .valueChanged)
        
        return slider
    }()
    
    @objc func handleVolumeSliderChange() {
        MPVolumeView.setVolume(soundSlider.value)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        webView.load(withVideoId: "kbMqWXnpXcA",
                     playerVars: ["playsinline": 1])
        
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        // For track system volume
        _ = MPVolumeView()
//        let volumeView = MPVolumeView()
                
        view.addSubview(webView)
        view.addSubview(rewindSlider)
        view.addSubview(videoLengthLabel)
        view.addSubview(videoCurrentTimeLabel)
        view.addSubview(titleOfVideoLabel)
        view.addSubview(numberOfViewsLabel)
        view.addSubview(pausePlayButton)
        view.addSubview(nextButton)
        view.addSubview(previousButton)
//        view.addSubview(soundMaxButton)
        view.addSubview(soundSlider)
//        view.addSubview(soundMinButton)
        
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
        
        pausePlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pausePlayButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextButton.leadingAnchor.constraint(equalTo: pausePlayButton.trailingAnchor, constant: 40).isActive = true
        nextButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        previousButton.trailingAnchor.constraint(equalTo: pausePlayButton.leadingAnchor, constant: -40).isActive = true
        previousButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
//        soundMaxButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        soundMaxButton.topAnchor.constraint(equalTo: pausePlayButton.bottomAnchor, constant: 45).isActive = true
//        soundMaxButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        soundMaxButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        soundSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        soundSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        soundSlider.topAnchor.constraint(equalTo: pausePlayButton.bottomAnchor, constant: 43).isActive = true
        
//        soundMinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        soundMinButton.topAnchor.constraint(equalTo: pausePlayButton.bottomAnchor, constant: 45).isActive = true
//        soundMinButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        soundMinButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
                
        NotificationCenter.default.addObserver(self, selector: #selector(getVideoObject(_:)), name: Notification.Name.init(rawValue: "selectedCell"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(getChannelObject(_:)), name: Notification.Name.init(rawValue: "selectedChannel"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged(_:)), name: Notification.Name.init(rawValue: "SystemVolumeDidChange"), object: nil)
        
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
    
    // MARK: - Player control
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.duration { (time, error) in
            guard error == nil else { return }
            
//            print("duration: \(time)")
            self.durationOfVideo = time
            
            // Set video length Label
            let secondsToText = String(format: "%02d", Int(time.truncatingRemainder(dividingBy: 60)))
            let minutesToText = String(format: "%02d",
                                       Int(time / 60))
            self.videoLengthLabel.text = "\(minutesToText):\(secondsToText)"
        }
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        
        // Update video length Label
        playerView.duration { (time, error) in
            guard error == nil else { return }
            
            self.durationOfVideo = time
            
            let secondsToText = String(format: "%02d", Int(time.truncatingRemainder(dividingBy: 60)))
            let minutesToText = String(format: "%02d",
                                       Int(time / 60))
            self.videoLengthLabel.text = "\(minutesToText):\(secondsToText)"
        }
        
        guard durationOfVideo != nil else { return }
        self.rewindSlider.value = Float((Double(playTime) / durationOfVideo!))
        
        // Set player progress
        let secondsString = String(format: "%02d",
                                   Int(playTime.truncatingRemainder(dividingBy: 60)))
        let minutesString = String(format: "%02d",
                                   Int(playTime / 60))
        self.videoCurrentTimeLabel.text = "\(minutesString):\(secondsString)"
    }
        
    func playerView(_: YTPlayerView, didChangeTo: YTPlayerState) {

        switch didChangeTo {
        case YTPlayerState.unstarted:
            pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
            isPlaying = true
        case YTPlayerState.buffering:
            pausePlayButton.setImage(UIImage(named: "Pause"), for: .normal)
            isPlaying = false
        case YTPlayerState.playing:
            pausePlayButton.setImage(UIImage(named: "Pause"), for: .normal)
            isPlaying = false
        case YTPlayerState.paused:
            pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
            isPlaying = true
        case YTPlayerState.ended:
            pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
            isPlaying = true
        case YTPlayerState.cued:
            pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
            isPlaying = true
        default:
            break
        }
    
    }
    
}

extension PlayerViewController {

    @objc func getVideoObject(_ notification: NSNotification) {
        
        let videoObject = notification.userInfo as? [String: Any] ?? [:]
        
        print("GOT IT !!!")
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnVideo"), object: nil)
                
        // But first. Clear the fields (probably from the previous video)
        self.titleOfVideoLabel.text = ""
        self.numberOfViewsLabel.text = ""
        self.currentVideoId = nil
        self.pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
        
        // Load videoId to webView (as URL)
        self.currentVideoId = videoObject["videoId"] as! String?
        webView.load(withVideoId: videoObject["videoId"] as! String, playerVars: ["playsinline": 1])
                
        // Set to title
        self.titleOfVideoLabel.text = videoObject["title"] as? String
        
        // Set the number of views
        let numberOfViews: Int? = Int(videoObject["numberOfViews"]! as! String)
        self.numberOfViewsLabel.text = "\(numberOfViews!.formattedWithSpaces) просмотров"
//        self.numberOfViewsLabel.text = "\(String(describing: videoObject["numberOfViews"]!)) просмотров"
        
    }
    
    @objc func getChannelObject(_ notification: NSNotification) {
        let channelObject = notification.userInfo as? [String: Any] ?? [:]
        
        print("GOT IT !!!")
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnVideo"), object: nil)
                
        // But first. Clear the fields (probably from the previous video)
        self.titleOfVideoLabel.text = ""
        self.numberOfViewsLabel.text = ""
        self.pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
                
        // Load uploads into the webview
        self.currentVideoId = channelObject["uploads"] as! String?
        webView.load(withPlaylistId: channelObject["uploads"] as! String, playerVars: ["playsinline": 1])
                
        // Set to title
        self.titleOfVideoLabel.text = channelObject["channelName"] as? String
        
        // Set the number of views
        let numberOfSubscribers = Int(channelObject["numberOfSubscribers"]! as! String)
        self.numberOfViewsLabel.text = "\(numberOfSubscribers!.formattedWithSpaces) Подписчиков"
    }
    
    @objc func volumeChanged(_ notification: NSNotification) {
        
//        let volume = notification.userInfo!["AVSystemController_AudioVolumeNotificationParameter"] as? Float
        let volume = notification.userInfo!["Volume"] as? Float
        
        guard volume != nil else { return }
                
        DispatchQueue.main.async {
            if self.soundSlider.value != volume {
                self.soundSlider.value = volume!
            } else {
                return
            }
        }
        
    }
    
}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {

        let volumeView = MPVolumeView()
        let volumeSlider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            volumeSlider?.value = volume
        }

    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension Formatter {
    static let withSpaces: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSpaces: String { Formatter.withSpaces.string(for: self) ?? "" }
}
