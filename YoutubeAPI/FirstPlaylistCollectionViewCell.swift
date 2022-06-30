//
//  FirstPlaylistCollectionViewCell.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 27.06.2022.
//

import UIKit

class FirstPlaylistCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "FirstPlaylistCollectionViewCell"
    
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
    
    var video: Video?
    
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
        
        // Set thumbnail
        guard self.video?.thumbnail != nil else { return }
        let url = URL(string: self.video!.thumbnail)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                if url!.absoluteString != self.video?.thumbnail {
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
