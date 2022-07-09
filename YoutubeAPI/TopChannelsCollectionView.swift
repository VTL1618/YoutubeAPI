//
//  TopChannelsCollectionView.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 23.06.2022.
//

import UIKit

class TopChannelsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, ChannelsModelDelegate {
    
    var model = ChannelsModel()
    
    private var channels: [Channel] = []

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
        layout.minimumLineSpacing = ConstantsForChannels.galleryMinimumLineSpacing
        
        // и св-во CollectionView, которое отвечает за принятие отступов
//        contentInset = UIEdgeInsets(top: 0, left: ConstantsForChannels.leftDistanceToView, bottom: 0, right: ConstantsForChannels.rightDistanceToView)
//        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isPagingEnabled = true
        
//        dots.numberOfPages = channels.count
        
        model.channelDelegate = self
        
        model.getChannels(playlist: APIConstants.CHANNELS_API)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - PlaylistsModel Delegate
    
    func fetchChannels(_ channels: [Channel]) {
        self.channels = channels
        
        // Refresh
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: TopChannelsCollectionViewCell.reuseId, for: indexPath) as! TopChannelsCollectionViewCell
        
        let channel = self.channels[indexPath.row]
        cell.setCell(channel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedVideo = channels[indexPath.row]
        
        let dictionaryFromVideo = selectedVideo.toDict()
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "selectedChannel"), object: nil, userInfo: dictionaryFromVideo)
        
    }

}

extension TopChannelsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
}

extension TopChannelsCollectionView {
    func getCountOfChannels() -> Int {
        let count = self.channels.count
        return count
    }
}
