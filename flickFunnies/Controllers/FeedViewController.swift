//
//  FeedViewController.swift
//  flickFunnies
//
//  Created by Batista Tone on 19/05/23.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource {
    

    
    var data: [PostModel] = [
        
        PostModel(
            user: User(id: "1", username: "punpkineater", email: "test@test.com", avatar: "something.com"),
            title: "when you trying to run", content: "meme", category: "comedy movie", likes: 5, created_at: "1684890842693")
        
    ]
    
    @IBOutlet weak var tableViewFeed: UITableView!
    @IBOutlet weak var avatarView: UIView!
    
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbarView()
        tableViewFeed.dataSource = self
        tableViewFeed.rowHeight = PostTableViewCell().frame.size.width
        tableViewFeed.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableCell")
    }
    
    
    

    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
    }
    
    
    func setupNavbarView(){
        
        let avatarLabel = UILabel()
        
        avatarView.layer.cornerRadius = avatarView.frame.width / 2
        avatarView.backgroundColor = Constants.colors.avatar
        
        avatarView.addSubview(avatarLabel)
        
        avatarLabel.text = "BO"
        avatarLabel.font = .boldSystemFont(ofSize: 20)
        avatarLabel.textColor = Constants.colors.text1
    }
    
    
    
}



extension FeedViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = data[indexPath.row]
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "PostTableCell", for: indexPath) as! PostTableViewCell
        
        
        
        cell.username.text = post.user.username
        cell.postLikes.text = "\(post.likes)"
        cell.postImageContent.image = UIImage(named: post.content)
        
        //TODO: create a function to develop time ago
        
        let timeAgo = post.created_at
        print("make some func to show times ago of \(timeAgo)")
        cell.timeAgo.text = "5min"
        let username = post.user.username.uppercased()
        let firstChar  = username[username.startIndex]
        let lastChar =  username.last
      
        cell.userNameLabel.text = "\(firstChar)\(lastChar!)"
        
        
        
        
        return cell
    }
    
}

