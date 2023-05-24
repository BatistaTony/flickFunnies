//
//  PostTableViewCell.swift
//  flickFunnies
//
//  Created by Batista Tone on 20/05/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postAvatar: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timeAgo: UILabel!
    var likes = 0
    var liked = false
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var postImageContent: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favoriteButton.imageView?.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        setupPostAvatar()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

       // contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupPostAvatar(){
        postAvatar.layer.cornerRadius = postAvatar.frame.width / 2
        postAvatar.backgroundColor = Constants.colors.avatar
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
        
    }
}
