//
//  TopChannelsCollectionViewCell.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 23.06.2022.
//

import UIKit

class TopChannelsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "TopChannelsCollectionViewCell"
    
    var video: Video?
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.113761507, green: 0.1048973277, blue: 0.150441885, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
     
    // знаю что по правилам английского надо было бы писать nameOfTheChannel, но я решил сократить)
    let nameOfChannel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfSubscribers: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6234598756, green: 0.6235695481, blue: 0.6234529018, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // добавляем все элементы в нашу ячейку
        addSubview(mainImageView)
        addSubview(nameOfChannel)
        addSubview(numberOfSubscribers)
        // теперь надо указать какую информацию эти элементы будут принимать в методе cellForItemAt в файле TopChannelsCollectionView
        // и плюс констрейнты
        
        // mainImageView constraints
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        // nameOfChannel constraints
        nameOfChannel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameOfChannel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameOfChannel.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        
        // numberOfSubscribers constraints
        numberOfSubscribers.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        numberOfSubscribers.topAnchor.constraint(equalTo: nameOfChannel.bottomAnchor, constant: 8).isActive = true
        numberOfSubscribers.widthAnchor.constraint(equalTo: widthAnchor, constant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        
        self.clipsToBounds = true
    }
    
    func setCell(_ video: Video) {
        
        self.video = video
        guard self.video != nil else { return }
        
        self.nameOfChannel.text = video.title
        
        self.numberOfSubscribers.text = video.numberOfViews
        
        guard self.video?.thumbnail != nil else { return }
        
        if let cacheData = CacheManager.getVideoCache(self.video!.thumbnail) {
            self.mainImageView.image = UIImage(data: cacheData)
            return
        }
        
        let url = URL(string: self.video!.thumbnail)
        let session = URLSession.shared
        let dataData = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                if url!.absoluteString != self.video?.thumbnail {
                    return
                }
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.mainImageView.image = image
                }
                
            }
            
        }
        dataData.resume()
    }
        
}
