//
//  SecondPlaylistCollectionView.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 27.06.2022.
//

import UIKit

class SecondPlaylistCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, ModelDelegate {
        
    // Kick off this network call
    var model = PlaylistsModel()
    
    var secondPlaylist: [Video] = []
    
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
        register(SecondPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: SecondPlaylistCollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false

        layout.minimumLineSpacing = ConstantsForSecondPlaylist.galleryMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: ConstantsForSecondPlaylist.leftDistanceToView, bottom: 0, right: ConstantsForSecondPlaylist.rightDistanceToView)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        model.delegate = self
        
        model.getVideos(playlist: APIConstants.SECOND_PLAYLIST_API)
        
        NotificationCenter.default.addObserver(self, selector: #selector(toNextVideo(notification:)), name: Notification.Name.init(rawValue: "toNextVideoInSecondPlaylist"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(toPreviousVideo(notification:)), name: Notification.Name.init(rawValue: "toPrevVideoInSecondPlaylist"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secondPlaylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SecondPlaylistCollectionViewCell.reuseId, for: indexPath) as! SecondPlaylistCollectionViewCell
        
        let video = self.secondPlaylist[indexPath.row]
        cell.setCell(video)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedVideo = secondPlaylist[indexPath.row]
        
        currentIndexPath = indexPath.row
        nextIndexPath = IndexPath(item: indexPath.row + 1, section: 0)
        prevIndexPath = IndexPath(item: indexPath.row - 1, section: 0)
        
        let dictionaryFromVideo = selectedVideo.toDict()
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "selectedCellFromSecondPlaylist"), object: nil, userInfo: dictionaryFromVideo)
        
    }
    
    @objc func toNextVideo(notification: NSNotification) {
        if currentIndexPath < secondPlaylist.count {
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
            self.collectionView(self, didSelectItemAt: IndexPath(item: secondPlaylist.count - 1, section: 0))
            currentIndexPath = secondPlaylist.count - 2
        }
        print("previous video")
    }
    
    // MARK: - Filling with content
    
    func fetchVideos(_ videos: [Video]) {
        self.secondPlaylist = videos
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}

extension SecondPlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsForSecondPlaylist.galleryItemWidth, height: frame.height)
        // gjсле расставления всего, для крвадратного размеры, сначала выставить надо высоту, а потом длинну сделать равной
    }
    
}
