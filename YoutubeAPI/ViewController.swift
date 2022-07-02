//
//  ViewController.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 22.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

enum PlayerState {
    case expanded
    case collapsed
}

class ViewController: UIViewController {
        
    private var topChannelsCollectionView = TopChannelsCollectionView()
    private var firstPlaylistCollectionView = FirstPlaylistCollectionView()
    private var secondPlaylistCollectionView = SecondPlaylistCollectionView()
    
    var playerViewController: PlayerViewController!
    var visualEffectView: UIVisualEffectView!
    
    // Two constants
    let playerHeight: CGFloat = 600
    let playerHandleAreaHeight: CGFloat = 56
    
    var playerVisible = false
    var nextState: PlayerState {
        return playerVisible ? .collapsed : .expanded
    }
    
    // Array for hold all animation that we want perform
    var runningAnimations: [UIViewPropertyAnimator] = []
    // We wand to make animations interruptible and interactive, we should also store the progress of our animation when it interrupted
    var animationProgressWhenInterrupted: CGFloat = 0
        
    @IBOutlet var dots: UIPageControl!
    
    var timer = Timer()
    var counter = 0
        
    var firstPlaylistName: UILabel = {
        let label = UILabel()
        label.text = "Playlist #1"
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondPlaylistName: UILabel = {
        let label = UILabel()
        label.text = "Playlist #2"
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dots.numberOfPages = TopChannelModel.fetchChannels().count
        
        DispatchQueue.main.async { [self] in
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(automaticScrollImage), userInfo: nil, repeats: true)
        }
        
        // добавим collection views и элементы на экран
        // делается это через view
        view.addSubview(topChannelsCollectionView)
        view.addSubview(firstPlaylistName)
        view.addSubview(firstPlaylistCollectionView)
        view.addSubview(secondPlaylistName)
        view.addSubview(secondPlaylistCollectionView)
       
        // MARK: - add constraints for topChannelsCollectionView
        // и закрепим с помощью констрейнтов
        topChannelsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topChannelsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topChannelsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        topChannelsCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                
        // MARK: - add constraints for dots
        dots.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dots.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dots.topAnchor.constraint(equalTo: topChannelsCollectionView.bottomAnchor, constant: 10).isActive = true
        dots.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        dots.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - add constraints for firstPlaylistName
        firstPlaylistName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        firstPlaylistName.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        firstPlaylistName.topAnchor.constraint(equalTo: dots.bottomAnchor, constant: 18).isActive = true
        
        firstPlaylistName.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - add constraints for firstPlaylistCollectionView
        firstPlaylistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        firstPlaylistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        firstPlaylistCollectionView.topAnchor.constraint(equalTo: firstPlaylistName.bottomAnchor, constant: 19).isActive = true
        firstPlaylistCollectionView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
//        firstPlaylistCollectionView.fetchVideos(Model.detVideos())
        
        // MARK: - add constraints for secondPlaylistName
        secondPlaylistName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        secondPlaylistName.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        secondPlaylistName.topAnchor.constraint(equalTo: firstPlaylistCollectionView.bottomAnchor, constant: 36).isActive = true
        
        secondPlaylistName.translatesAutoresizingMaskIntoConstraints = false

        // MARK: - add constraints for secondPlaylistCollectionView
        secondPlaylistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        secondPlaylistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        secondPlaylistCollectionView.topAnchor.constraint(equalTo: secondPlaylistName.bottomAnchor, constant: 19).isActive = true
        secondPlaylistCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
//        secondPlaylistCollectionView.setContentFor(playlist: SecondPlaylistModel.fetchVideos())
        
        // Setup our player
        setupPlayer()
             
    }
    
    @objc func automaticScrollImage() {
        
        if counter < dots.numberOfPages - 1 {
            counter += 1
        } else {
            counter = 0
        }
        
        self.topChannelsCollectionView.scrollToItem(at: IndexPath(item: counter, section: 0), at: .centeredHorizontally, animated: true)
        dots.currentPage = counter
        
    }

}

extension ViewController {
    
    // MARK: Settings for the player
    
    func setupPlayer() {
        visualEffectView = UIVisualEffectView()
        
        // We must set it to our current frame
        visualEffectView.frame = self.view.frame
        
        // Now use our main view and add the visualEffectView as a Subview
        self.view.addSubview(visualEffectView)
//        visualEffectView.isHidden = true
        visualEffectView.isUserInteractionEnabled = false
        
        // Now we can already load our playerViewController with nibName (name of .xib)
        playerViewController = PlayerViewController(nibName: "PlayerViewController", bundle: nil)
        // Add him as a child to Main ViewController
        self.addChild(playerViewController)
        
        // Now add the View of our playerViewController
        self.view.addSubview(playerViewController.view)
        
        // Setting the frame of playerViewController's view
        playerViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - playerHandleAreaHeight, width: self.view.bounds.width, height: playerHeight)
        
        // For correct displayed corner radius
        playerViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePlayerTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePlayerPan(recognizer:)))
        
        // And add this gesture recognizzers
        playerViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        playerViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
        self.playerViewController.view.layer.cornerRadius = 20
    }
    
    // When user Tap
    @objc func handlePlayerTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    // When user Pan
    @objc func handlePlayerPan(recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.playerViewController.handleArea)
            var fractionComplete = translation.y / playerHeight
            fractionComplete = playerVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    // This function going to be called every time when animation is needed or we are gouing to check if an animation is needed
    func animateTransitionIfNeeded(state: PlayerState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.playerViewController.view.frame.origin.y = self.view.frame.height - self.playerHeight
                case .collapsed:
                    self.playerViewController.view.frame.origin.y = self.view.frame.height - self.playerHandleAreaHeight
                }
            }
            
            // We need to update our player visible flag, when the animation is complited
            frameAnimator.addCompletion { _ in
                self.playerVisible = !self.playerVisible
                self.runningAnimations.removeAll()
            }
            
            // And actually start animation
            frameAnimator.startAnimation()
            // But we have a multiply animations, so we append this to our array of animations, to our running animations
            runningAnimations.append(frameAnimator)
            
            // For corners
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.playerViewController.view.layer.cornerRadius = 30
                case .collapsed:
                    self.playerViewController.view.layer.cornerRadius = 20
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            // Blur animation
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
//                    self.visualEffectView.isHidden = false
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
//                    self.visualEffectView.isUserInteractionEnabled = false
                }
            }
            
            // And again to make this happen
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
            // Rotate player arrow
            let rotateArrow = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.playerViewController.openCloseArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                case .collapsed:
                    self.playerViewController.openCloseArrow.transform =  CGAffineTransform.identity
                }
            }
            
            rotateArrow.startAnimation()
            runningAnimations.append(rotateArrow)
        }
    }
    
    func startInteractiveTransition(state: PlayerState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            // Run animation
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}
