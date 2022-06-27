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
    // инициализируем через frame и collectionViewLayout
        
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
       
        // MARK: - add topChannelsCollectionView на экран
        // делается это через view
        view.addSubview(topChannelsCollectionView)
        // и закрепим с помощью констрейнтов
        topChannelsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topChannelsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topChannelsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        topChannelsCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        topChannelsCollectionView.setContentFor(channels: TopChannelModel.fetchChannels())
        
        // MARK: - add constraints for dots
        dots.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dots.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dots.topAnchor.constraint(equalTo: topChannelsCollectionView.bottomAnchor, constant: 10).isActive = true
        dots.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        dots.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - add constraints for firstPlaylistName
        view.addSubview(firstPlaylistName)
        firstPlaylistName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        firstPlaylistName.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        firstPlaylistName.topAnchor.constraint(equalTo: dots.bottomAnchor, constant: 22).isActive = true
        
        firstPlaylistName.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - add firstPlaylistCollectionView на экран
        view.addSubview(firstPlaylistCollectionView)
        firstPlaylistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        firstPlaylistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        firstPlaylistCollectionView.topAnchor.constraint(equalTo: firstPlaylistName.bottomAnchor, constant: 20).isActive = true
        firstPlaylistCollectionView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        firstPlaylistCollectionView.setContentFor(playlist: FirstPlaylistModel.fetchVideos())
        
        // MARK: - add constraints for secondPlaylistName
        view.addSubview(secondPlaylistName)
        secondPlaylistName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        secondPlaylistName.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        secondPlaylistName.topAnchor.constraint(equalTo: firstPlaylistCollectionView.bottomAnchor, constant: 38).isActive = true
        
        secondPlaylistName.translatesAutoresizingMaskIntoConstraints = false

        
        
    }

}
