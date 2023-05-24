//
//  FeedViewController.swift
//  flickFunnies
//
//  Created by Batista Tone on 19/05/23.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource {
    

    
    var data: [PostModel] = [
        PostModel(id:"tuy43",
            user: User(id: "1", username: "punpkineater", email: "test@test.com", avatar: "something.com"),
            title: "when you trying to run", content: "meme", category: "comedy movie", likes: 5, created_at: "1684890842693", image: "meme")
        
    ]
    
    let fetcherController = FetcherController(apiUrl: API_URL)
    
    @IBOutlet weak var tableViewFeed: UITableView!
    @IBOutlet weak var avatarView: UIView!
    
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbarView()
        tableViewFeed.dataSource = self
        fetcherController.delegate = self
        tableViewFeed.rowHeight = PostTableViewCell().frame.size.width
        tableViewFeed.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableCell")
        getPosts()
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
    
    
    
    func getPosts(){
        fetcherController.makeRequest(endpoint: "posts", method: "get", params: [:], model: [PostModel].self)
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
        
        getImageFromUrl(imageURLString: post.image, imageView: cell.postImageContent)
        
        let profileImageView = UIImageView()
        
        profileImageView.frame = CGRect(x: 0, y: 0, width: cell.postAvatar.frame.size.width, height: cell.postAvatar.frame.size.height)
        
        
        getImageFromUrl(imageURLString: post.user.avatar, imageView: profileImageView)
       
        
        cell.postAvatar.addSubview(profileImageView)
        
        profileImageView.layer.cornerRadius = cell.postAvatar.frame.size.width / 2
       
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

extension FeedViewController: FetcherDelegate {
    
    func handleError(data: Any) {
        print("Error", data)
    }
    
    func handleSuccess(data: Any) {
        
        DispatchQueue.main.async {
            let posts = data as! [PostModel]
            self.data = posts
            self.tableViewFeed.reloadData()
        }
        
    }
    
}

