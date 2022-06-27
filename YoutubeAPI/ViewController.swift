//
//  ViewController.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 22.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
        
    private var topChannelsCollectionView = TopChannelsCollectionView()
    private var firstPlaylistCollectionView = FirstPlaylistCollectionView()
    private var secondPlaylistCollectionView = SecondPlaylistCollectionView()
        
    @IBOutlet var dots: UIPageControl!
    
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
        
        topChannelsCollectionView.setContentFor(channels: TopChannelModel.fetchChannels())
        
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
        
        firstPlaylistCollectionView.setContentFor(playlist: FirstPlaylistModel.fetchVideos())
        
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
        
        secondPlaylistCollectionView.setContentFor(playlist: SecondPlaylistModel.fetchVideos())
    }

}
