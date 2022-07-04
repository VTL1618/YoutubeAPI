//
//  FirstPlaylistCollectionView.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 26.06.2022.
//

import UIKit

class FirstPlaylistCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, ModelDelegate {
  
    // Kick off this network call
    var playlistsModel = PlaylistsModel()
    
    private var firstPlaylist: [Video] = []
//    private var videosWithStat: [ChannelsModel] = []
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PlaylistsModel Delegate
    
    func fetchVideos(_ videos: [Video]) {
        self.firstPlaylist = videos
        
//        playlistsModel.getNumberOfViews()
        
        // Refresh
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
//    func fetchNumberOfViews(_ numbersOfViews: [ChannelsModel]) {
//        self.videosWithStat = numbersOfViews
//        
//        // Refresh
//        DispatchQueue.main.async {
//            self.reloadData()
//        }
//    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstPlaylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: FirstPlaylistCollectionViewCell.reuseId, for: indexPath) as! FirstPlaylistCollectionViewCell
        
        let video = self.firstPlaylist[indexPath.row]
        cell.setCell(video)
        
//        let views = self.videosWithStat[indexPath.row]
//        cell.setCellWithStat(views)
//        cell.numberOfViews.text = self.numbersOfViews[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
//    // MARK - Filling with content
//
//    func setContentFor(playlist: [Video]) {
//        self.firstPlaylist = playlist
//    }
    
}

extension FirstPlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsForPlaylist.galleryItemWidth, height: frame.height)
    }
    
}
