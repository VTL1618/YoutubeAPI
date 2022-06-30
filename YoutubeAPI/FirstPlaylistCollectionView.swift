//
//  FirstPlaylistCollectionView.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 26.06.2022.
//

import UIKit

class FirstPlaylistCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, ModelDelegate {
  
    var model = Model()
    var firstPlaylist: [Video] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 0.113761507, green: 0.1048973277, blue: 0.150441885, alpha: 1)
        delegate = self
        dataSource = self
        register(FirstPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FirstPlaylistCollectionViewCell.reuseId)
        
        model.delegate = self
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layout.minimumLineSpacing = ConstantsForPlaylists.galleryMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: ConstantsForPlaylists.leftDistanceToView, bottom: 0, right: ConstantsForPlaylists.rightDistanceToView)
        // свойство CollectionView, отвечающее за отступы ячеек от краев
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        model.detVideos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Model Delegate
    
    func fetchVideos(_ videos: [Video]) {
        self.firstPlaylist = videos
        
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
//        cell.mainImageView.image = firstPlaylist[indexPath.row].thumbnail
//        cell.nameOfVideo.text = firstPlaylist[indexPath.row].title
//        cell.numberOfViews.text = firstPlaylist[indexPath.row].numberOfViews
        let video = self.firstPlaylist[indexPath.row]
        cell.setCell(video)
        
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
        return CGSize(width: ConstantsForPlaylists.galleryItemWidth, height: frame.height)
    }
    
}
