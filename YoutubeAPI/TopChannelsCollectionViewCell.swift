//
//  TopChannelsCollectionViewCell.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 23.06.2022.
//

import UIKit
import simd

class TopChannelsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "TopChannelsCollectionViewCell"
    
    var channel: Channel?
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.113761507, green: 0.1048973277, blue: 0.150441885, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    let playCircle: UIButton = {
//        let button = UIButton()
//        let image = UIImage(named: "Play_Circle")
//        button.setImage(image, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.imageView?.contentMode = .scaleAspectFit
//        return button
//    }()
     
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
//        addSubview(playCircle)
        // теперь надо указать какую информацию эти элементы будут принимать в методе cellForItemAt в файле TopChannelsCollectionView
        // и плюс констрейнты
        
        // mainImageView constraints
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        // playCircle constraints
//        playCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -170).isActive = true
//        playCircle.topAnchor.constraint(equalTo: topAnchor, constant: -157).isActive = true
//        playCircle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        playCircle.widthAnchor.constraint(equalTo: widthAnchor, constant: 30).isActive = true
//        playCircle.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        // nameOfChannel constraints
        nameOfChannel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameOfChannel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameOfChannel.topAnchor.constraint(equalTo: topAnchor, constant: 140).isActive = true
        
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
    
    func setCell(_ channel: Channel) {
        
        self.channel = channel
        guard self.channel != nil else { return }
        
        self.nameOfChannel.text = channel.channelName
        
        self.numberOfSubscribers.text = "\(channel.numberOfSubscribers) Подписчиков"
        
        guard self.channel?.channelBanner != nil else { return }
        
        if let cacheData = CacheManager.getChannelCache(self.channel!.channelBanner) {
            self.mainImageView.image = UIImage(data: cacheData)
            return
        }
        
        let url = URL(string: self.channel!.channelBanner)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                CacheManager.setChannelCache(url!.absoluteString, data)
                
                if url!.absoluteString != self.channel!.channelBanner {
                    return
                }
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.mainImageView.image = image
                }
                
            }
            
        }
        dataTask.resume()
    }
        
}
