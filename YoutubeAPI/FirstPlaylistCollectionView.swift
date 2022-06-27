//
//  FirstPlaylistCollectionView.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 26.06.2022.
//

import UIKit

class FirstPlaylistCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var firstPlaylist: [FirstPlaylistModel] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 0.113761507, green: 0.1048973277, blue: 0.150441885, alpha: 1)
        delegate = self
        dataSource = self
        register(FirstPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FirstPlaylistCollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layout.minimumLineSpacing = ConstantsForPlaylists.galleryMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: ConstantsForPlaylists.leftDistanceToView, bottom: 0, right: ConstantsForPlaylists.rightDistanceToView)
        // свойство CollectionView, отвечающее за отступы ячеек от краев
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstPlaylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: FirstPlaylistCollectionViewCell.reuseId, for: indexPath) as! FirstPlaylistCollectionViewCell
        cell.mainImageView.image = firstPlaylist[indexPath.row].coverImage
        cell.nameOfVideo.text = firstPlaylist[indexPath.row].nameOfVideo
        cell.numberOfViews.text = firstPlaylist[indexPath.row].numberOfViews
        return cell
    }
    
    // MARK: - Filling with content
    
    func setContentFor(playlist: [FirstPlaylistModel]) {
        self.firstPlaylist = playlist
    }
    
}

extension FirstPlaylistCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsForPlaylists.galleryItemWidth, height: frame.height)
    }
    
}
