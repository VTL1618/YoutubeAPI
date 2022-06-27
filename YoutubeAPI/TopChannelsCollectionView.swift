//
//  TopChannelsCollectionView.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 23.06.2022.
//

import UIKit

class TopChannelsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var channels: [TopChannelModel] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 0.113761507, green: 0.1048973277, blue: 0.150441885, alpha: 1)
        delegate = self
        dataSource = self
        register(TopChannelsCollectionViewCell.self, forCellWithReuseIdentifier: TopChannelsCollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // за расстояние между ячейками у нас отвечает layout, свойство minimumLineSpacing
        layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        
        // и св-во CollectionView, которое отвечает за принятие отступов
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isPagingEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: TopChannelsCollectionViewCell.reuseId, for: indexPath) as! TopChannelsCollectionViewCell
        cell.mainImageView.image = channels[indexPath.row].coverImage
        cell.nameOfChannel.text = channels[indexPath.row].nameOfChannel
        cell.numberOfSubscribers.text = channels[indexPath.row].numberOfSubscribers
        return cell
    }
    
    // MARK: - Filling with content
    
    func setContentFor(channels: [TopChannelModel]) {
        self.channels = channels
    }
    // будем вызывать ее там, от куда мы будем получать наши данные. В нашем случае мы будем получать их в файле ViewController

}

extension TopChannelsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: frame.height)
    }
    
}
