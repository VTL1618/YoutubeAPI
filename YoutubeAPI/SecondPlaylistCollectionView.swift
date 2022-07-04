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
    
    // MARK: - Filling with content
    
    func fetchVideos(_ videos: [Video]) {
        self.secondPlaylist = videos
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
//    func fetchNumberOfViews(_ views: [ChannelsModel]) {
//        
//    }
    
}

extension SecondPlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsForSecondPlaylist.galleryItemWidth, height: frame.height)
        // gjсле расставления всего, для крвадратного размеры, сначала выставить надо высоту, а потом длинну сделать равной
    }
    
}
