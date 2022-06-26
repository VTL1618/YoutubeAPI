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
    private var firstPlaylist = UICollectionView(frame: <#T##CGRect#>, collectionViewLayout: <#T##UICollectionViewLayout#>)
    // инициализируем через frame и collectionViewLayout
        
    @IBOutlet var dots: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        topChannelsCollectionView.type = .timeMachine
//        topChannelsCollectionView.contentMode =  .scaleAspectFill
//
//        // добавляем topChannelsCollectionView на экран
//        view.addSubview(topChannelsCollectionView)
//        topChannelsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        topChannelsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        topChannelsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
//
//        topChannelsCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        topChannelsCollectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        topChannelsCollectionView.setContentFor(channels: TopChannelModel.fetchChannels())
        
        // добавляем наш topChannelsCollectionView на экран
        // делается это через view
        view.addSubview(topChannelsCollectionView)
        // и закрепим с помощью констрейнтов
        topChannelsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topChannelsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topChannelsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        topChannelsCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        topChannelsCollectionView.setContentFor(channels: TopChannelModel.fetchChannels())
        
        // констрейнты для dots
        dots.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dots.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dots.topAnchor.constraint(equalTo: topChannelsCollectionView.bottomAnchor, constant: 10).isActive = true
        dots.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        dots.translatesAutoresizingMaskIntoConstraints = false
        
    }

}
