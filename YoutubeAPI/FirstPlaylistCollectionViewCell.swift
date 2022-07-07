//
//  FirstPlaylistCollectionViewCell.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 27.06.2022.
//

import UIKit

//protocol FirstPlaylistCollectionViewCellDelegate: AnyObject {
//    func collectionViewCell(_ cell: UICollectionViewCell, buttonTapped)
//}

class FirstPlaylistCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "FirstPlaylistCollectionViewCell"
    
    var video: Video?
//    var views: ChannelsModel?
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainImageView.layer.cornerRadius = 8
        mainImageView.clipsToBounds = true
    }
    
    let nameOfVideo: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfViews: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = #colorLiteral(red: 0.4862487316, green: 0.4819176793, blue: 0.5067149401, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        addSubview(nameOfVideo)
        addSubview(numberOfViews)
        
        // mainImageView constraints
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/1.65).isActive = true
        
        // nameOfVideo constraints
        nameOfVideo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        nameOfVideo.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameOfVideo.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10).isActive = true
        
        // numberOfViews constraints
        numberOfViews.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        numberOfViews.topAnchor.constraint(equalTo: nameOfVideo.bottomAnchor, constant: 4).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(_ video: Video) {

        self.video = video
        guard self.video != nil else { return }
        
        // Set title
        self.nameOfVideo.text = video.title
        
        // Set number of views
        self.numberOfViews.text = "\(video.numberOfViews) просмотра"
        
        // Set thumbnail
        guard self.video?.thumbnail != nil else { return }
        
        // Check cache before downloading data
        if let cacheData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            // Set the thumbnail imageView
            self.mainImageView.image = UIImage(data: cacheData)
            
            // And return because we don't want to further implementation if the cache is exist
            return
            
        }
        
        let url = URL(string: self.video!.thumbnail)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                if url!.absoluteString != self.video?.thumbnail {
                    return
                }
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.mainImageView.image = image
                }
                
                // Now we must go in fetch that URL
                
            }
            
        }
        dataTask.resume()
        
    }
    
//    func setCellWith(_ numberOfViews: ChannelsModel, for videoID: Video) {
//    func setCellWithStat(_ views: NumberOfViews) {
//
//        self.views = views
//        guard self.views != nil else { return }
//
//        self.numberOfViews.text = views.numberOfViews
//
//    }
    
}
