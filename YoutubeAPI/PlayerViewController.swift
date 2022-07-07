//
//  PlayerViewController.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 28.06.2022.
//

import UIKit
import WebKit
import AVFoundation
//import youtube_ios_player_helper

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var openCloseArrow: UIImageView!
    
    // Property representing the video to display. And it could be nil, so - ?
    var video: Video?
    var currentUrl: URL?
    
    var webView: WKWebView! = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = .black
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
//    var webView: YTPlayerView = {
//        let configuration = WKWebViewConfiguration()
//        configuration.allowsInlineMediaPlayback = true
//        let webView = YTPlayerView(frame: .zero)
//        webView.allowsInlineMediaPlayback = true
//        webView.backgroundColor = .black
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        return webView
//    }()
    
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
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Double(rewindSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: CMTimeValue(Int64(value)), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedMove) in
                // later
            })
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
        label.text = "Vitaly Zubenko - Song of Youtube app"
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
    
//    lazy var playButton: UIButton = {
//        let button = UIButton(type: .system)
//        let image = UIImage(named: "Play")
//        button.setImage(image, for: .normal)
//        button.contentMode = .center
//        button.imageView?.contentMode = .scaleAspectFit
//        button.tintColor = .white
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        button.addTarget(self, action: #selector(tapPlay), for: .touchUpInside)
//
//        button.isHidden = true
//
//        return button
//    }()
//
//    @objc func tapPlay() {
//        print("play player")
//        player?.play()
//    }
    
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
    
    var isPlaying = true
    
    @objc func tapPause() {
        if isPlaying {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "Pause"), for: .normal)
            print("play player")
        } else {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "Play"), for: .normal)
            print("pause player")
        }
        isPlaying = !isPlaying
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
        
        playerControl()
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
//        webView.delegate = self
        
        view.addSubview(webView)
        view.addSubview(rewindSlider)
        view.addSubview(videoLengthLabel)
        view.addSubview(videoCurrentTimeLabel)
        view.addSubview(titleOfVideoLabel)
        view.addSubview(numberOfViewsLabel)
        view.addSubview(pausePlayButton)
//        view.addSubview(playButton)
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
        
        pausePlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pausePlayButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
//        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        playButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
//        playButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
//        playButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextButton.leadingAnchor.constraint(equalTo: pausePlayButton.trailingAnchor, constant: 40).isActive = true
        nextButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        previousButton.trailingAnchor.constraint(equalTo: pausePlayButton.leadingAnchor, constant: -40).isActive = true
        previousButton.topAnchor.constraint(equalTo: numberOfViewsLabel.bottomAnchor, constant: 45).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 31).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        soundMaxButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        soundMaxButton.topAnchor.constraint(equalTo: pausePlayButton.bottomAnchor, constant: 45).isActive = true
        soundMaxButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        soundMaxButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        soundSlider.leadingAnchor.constraint(equalTo: soundMinButton.trailingAnchor, constant: 10).isActive = true
        soundSlider.trailingAnchor.constraint(equalTo: soundMaxButton.leadingAnchor, constant: -10).isActive = true
        soundSlider.topAnchor.constraint(equalTo: pausePlayButton.bottomAnchor, constant: 43).isActive = true
        
        soundMinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        soundMinButton.topAnchor.constraint(equalTo: pausePlayButton.bottomAnchor, constant: 45).isActive = true
        soundMinButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        soundMinButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
                
        NotificationCenter.default.addObserver(self, selector: #selector(getVideoObject(_:)), name: Notification.Name.init(rawValue: "selectedCell"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(getChannelObject(_:)), name: Notification.Name.init(rawValue: "selectedChannel"), object: nil)
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        // But first. Clear the fields (probably from the previous video)
//        titleOfVideoLabel.text = ""
//        numberOfViewsLabel.text = ""
//
//        // Check if there's a video
//        guard video != nil else { return }
//
//        // Creat the embed URL
//        let embedUrlString = APIConstants.YOUTUBE_EMBED_URL + video!.videoId
//
//        // Load it into the webview
//        let url = URL(string: embedUrlString)
//        let request = URLRequest(url: url!)
//        webView.load(request)
//
//        // Set to title
//        titleOfVideoLabel.text = video!.title
//
//        // Set the number of views
//        numberOfViewsLabel.text = "\(video!.numberOfViews) просмотров"
//
//    }
    
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    // Local references
    var player: AVPlayer?
    
    private func playerControl() {
        if let url = currentUrl {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.webView.layer.addSublayer(playerLayer)
            playerLayer.frame = self.webView.frame
            
            player!.play()
            player!.pause()
                        
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondText = String(seconds.truncatingRemainder(dividingBy: 60))
//                var minutesText = Int(seconds.truncatingRemainder(dividingBy: 3600) / 60)
                let minutesText = String(format: "%02d", Double(seconds) / 60)
                self.videoLengthLabel.text = "\(minutesText):\(secondText)"
            }
           
            // player progress
            let intervar = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: intervar, queue: DispatchQueue.main, using: { (timeProgress) in
                
                let seconds = CMTimeGetSeconds(timeProgress)
                let secondsString = String(format: "%02d", seconds.truncatingRemainder(dividingBy: 60))
                let minutesString = String(format: "%02d", Double(seconds) / 60)
                self.videoCurrentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                // move slider duration of video
                if let duration = self.player?.currentItem?.duration {
                    let durationInSeconds = CMTimeGetSeconds(duration)
                    self.rewindSlider.value = Float(seconds / durationInSeconds)
                }
                
            })
            
            
            
//            player?.addObserver(self, forKeyPath: "currentItem.loaded", options: .new, context: nil)
//
//            NotificationCenter.default.addObserver(self, selector: #selector(getChannelObject(_:)), name: Notification.Name.init(rawValue: "currentItem.loaded"), object: nil)
        }
    }
    
//    func observeValue(forKeyPath: String?, ofObject: Any?, change: [String: Any]?, context: UnsafeMutableRawPointer) {
//
//        if forKeyPath == "currentItem.loaded" {
//            isPlaying = true
//            print("I am listening")
//
//        }
//    }
    
}

extension PlayerViewController {

    @objc func getVideoObject(_ notification: NSNotification) {
        let videoObject = notification.userInfo as? [String: Any] ?? [:]
        
        print("GOT IT !!!")
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "tapOnVideo"), object: nil)
                
        // But first. Clear the fields (probably from the previous video)
        self.titleOfVideoLabel.text = ""
        self.numberOfViewsLabel.text = ""
        self.currentUrl = nil
        
        // Creat the embed URL
        let embedUrlString = APIConstants.YOUTUBE_EMBED_URL + String(describing: videoObject["videoId"]!)
        
        // Load it into the webview
        let url = URL(string: embedUrlString)
        self.currentUrl = url
        let request = URLRequest(url: url!)
        webView.load(request)
        
//        self.webView.load(withVideoId: String(describing: videoObject["videoId"]))
        
        // Set to title
        self.titleOfVideoLabel.text = videoObject["title"] as? String
        
        // Set the number of views
        self.numberOfViewsLabel.text = "\(String(describing: videoObject["numberOfViews"]!)) просмотров"
        
        playerControl()
    }
    
    @objc func getChannelObject(_ notification: NSNotification) {
        let channelObject = notification.userInfo as? [String: Any] ?? [:]
        
        print("GOT IT !!!")
                
        // But first. Clear the fields (probably from the previous video)
        self.titleOfVideoLabel.text = ""
        self.numberOfViewsLabel.text = ""
        
        // Creat the embed URL
        let embedUrlString = APIConstants.UPLOADS_API + String(describing: channelObject["uploads"]!)
        
        // Load it into the webview
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        webView.load(request)
        
//        self.webView.load(withVideoId: String(describing: channelObject["videoId"]))
        
        // Set to title
        self.titleOfVideoLabel.text = channelObject["channelName"] as? String
        
        // Set the number of views
        self.numberOfViewsLabel.text = "\(String(describing: channelObject["numberOfSubscribers"]!)) Подписчиков"
        
        playerControl()
    }
    
}

