//
//  PostTableViewCell.swift
//  flickFunnies
//
//  Created by Batista Tone on 20/05/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

  
    @IBOutlet weak var timeAgo: UILabel!
    var postId: String = ""
    var likes = 0
    var liked = false
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var postImageContent: UIImageView!
    let fetch = FetcherController(apiUrl: API_URL)
    
   
    lazy var userNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor   = UIColor.white
        
        return nameLabel
    }()
    
        lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            let icon = UIImage(named: "meme")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .clear
            imageView.layer.cornerRadius = 25
            imageView.contentMode = .scaleAspectFit
            imageView.image = icon

            return imageView
        }()

        lazy var postContainer: UIView = {
            let backgroundView = UIView()
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
          
            return backgroundView
        }()

        lazy var postText: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.backgroundColor = .clear
            label.textColor = .white

            return label
        }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            layoutViews()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            layoutViews()
        }
    
    func layoutViews() {
           contentView.addSubview(iconImageView)
            contentView.addSubview(userNameLabel)
           contentView.addSubview(postContainer)
            postContainer.addSubview(postText)

           NSLayoutConstraint.activate([
               iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
               iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               iconImageView.widthAnchor.constraint(equalToConstant: 50),
               iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
               iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),
               userNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
               userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
               userNameLabel.heightAnchor.constraint(equalToConstant: iconImageView.frame.size.height),
               userNameLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 0),
               postContainer.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 3),
               postContainer.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
               postContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
               postContainer.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
               postText.trailingAnchor.constraint(lessThanOrEqualTo: postContainer.trailingAnchor, constant: -5),
               postText.topAnchor.constraint(equalTo: postContainer.topAnchor, constant: 5),
               postText.bottomAnchor.constraint(equalTo: postContainer.bottomAnchor, constant: -5),
               postText.leadingAnchor.constraint(equalTo: postContainer.leadingAnchor, constant: 5)
               ])
       }
    
    override func layoutSubviews() {
        super.layoutSubviews()

       // contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    @IBAction func favoritePressed(_ sender: UIButton) {
        
        let currentLikes = Int(postLikes.text ?? "0") ?? 0
        
        if(liked){
            liked = false
            favoriteButton.tintColor = Constants.colors.loveButton
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likes  = currentLikes - 1
        }else{
            liked = true
            favoriteButton.tintColor = Constants.colors.loveButton
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likes  = currentLikes + 1
        }
        
        if likes == 0 {
            postLikes.text = ""
        }else{
            postLikes.text = "\(likes)"
        }
        
        updatePostLikes(id: postId, likes: likes)
        
        
    }
}


extension PostTableViewCell {
    func updatePostLikes(id: String, likes: Int){
//        if(id != ""){
//            fetch.makeRequest(endpoint: "posts/\(id)", method: "put", params: ["likes": "\(likes)"], model: [PostModel].self)
//        }
    }
}
