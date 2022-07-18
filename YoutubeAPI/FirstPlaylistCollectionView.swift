//
//  FirstPlaylistCollectionView.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 26.06.2022.
//

import UIKit

protocol FirstPlaylistCollectionViewDelegate: AnyObject {
    func playVideo()
}

class FirstPlaylistCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, ModelDelegate, JSONable {
  
    // Kick off this network call
    var playlistsModel = PlaylistsModel()
    
    private var firstPlaylist: [Video] = []
    
    private var currentIndexPath = 0
    private var nextIndexPath = IndexPath()
    private var prevIndexPath = IndexPath()
        
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 0.113761507, green: 0.1048973277, blue: 0.150441885, alpha: 1)
        delegate = self
        dataSource = self
        register(FirstPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FirstPlaylistCollectionViewCell.reuseId)
                
        translatesAutoresizingMaskIntoConstraints = false
        
        layout.minimumLineSpacing = ConstantsForPlaylist.galleryMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: ConstantsForPlaylist.leftDistanceToView, bottom: 0, right: ConstantsForPlaylist.rightDistanceToView)
        // свойство CollectionView, отвечающее за отступы ячеек от краев
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        playlistsModel.delegate = self
        
        playlistsModel.getVideos(playlist: APIConstants.FIRST_PLAYLIST_API)
        
        NotificationCenter.default.addObserver(self, selector: #selector(toNextVideo(notification:)), name: Notification.Name.init(rawValue: "toNextVideoInFirstPlaylist"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(toPreviousVideo(notification:)), name: Notification.Name.init(rawValue: "toPrevVideoInFirstPlaylist"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PlaylistsModel Delegate
    
    func fetchVideos(_ videos: [Video]) {
        self.firstPlaylist = videos
        
        ViewController.firstPlaylistVideos = videos
        
        // Refresh
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstPlaylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: FirstPlaylistCollectionViewCell.reuseId, for: indexPath) as! FirstPlaylistCollectionViewCell
        
        let video = self.firstPlaylist[indexPath.row]
        cell.setCell(video)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        let selectedVideo = firstPlaylist[indexPath.row]
        
        currentIndexPath = indexPath.row
        nextIndexPath = IndexPath(item: indexPath.row + 1, section: 0)
        prevIndexPath = IndexPath(item: indexPath.row - 1, section: 0)
        
        let dictionaryFromVideo = selectedVideo.toDict()
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "selectedCellFromFirstPlaylist"), object: nil, userInfo: dictionaryFromVideo)
        
    }
    
    @objc func toNextVideo(notification: NSNotification) {
        if currentIndexPath < firstPlaylist.count {
//          self.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.collectionView(self, didSelectItemAt: nextIndexPath)
            currentIndexPath += 1
        } else {
            self.collectionView(self, didSelectItemAt: IndexPath(item: 0, section: 0))
            currentIndexPath = 1
        }
        print("next video")
    }
    
    @objc func toPreviousVideo(notification: NSNotification) {
        if currentIndexPath > 0 {
            self.collectionView(self, didSelectItemAt: prevIndexPath)
            currentIndexPath -= 1
        } else {
            self.collectionView(self, didSelectItemAt: IndexPath(item: firstPlaylist.count - 1, section: 0))
            currentIndexPath = firstPlaylist.count - 2
        }
        print("previous video")
    }
    
//    override func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
//        super.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
//
//        let indexPath = IndexPath(item: currentIndexPath + 1, section: 0)
//
//    }
}

extension FirstPlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsForPlaylist.galleryItemWidth, height: frame.height)
    }
    
}
