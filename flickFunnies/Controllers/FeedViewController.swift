//
//  FeedViewController.swift
//  flickFunnies
//
//  Created by Batista Tone on 19/05/23.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource {
    
    var data: [PostModel] = []
    
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
        
        tableViewFeed.estimatedRowHeight = 50
        tableViewFeed.rowHeight = UITableView.automaticDimension
       
    
        
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
        fetcherController.makeRequest(endpoint: "thoughts", method: "get", params: [:], model: [PostModel].self)
    }
    
}



extension FeedViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = data[indexPath.row]
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "PostTableCell", for: indexPath) as! PostTableViewCell
        
        
        
//        cell.username.text = post.username
//        cell.postLikes.text =  0; //"\(post.likes)"
//
       // getImageFromUrl(imageURLString: post.image, imageView: cell.postImageContent)
        
        //let profileImageView = UIImageView()
        
       // profileImageView.frame = CGRect(x: 0, y: 0, width: cell.postAvatar.frame.size.width, height: cell.postAvatar.frame.size.height)
        
        
       // getImageFromUrl(imageURLString: post.user.avatar, imageView: profileImageView)
       
        
       // cell.postAvatar.addSubview(profileImageView)
        
        
//        let timeAgo = post.createdAt
//
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        let date = dateFormatter.date(from: timeAgo)
//
//        cell.timeAgo.text = Date().timeAgoDisplay(date: date!)
        
      //  cell.postId = post.id
        
        cell.postText.text = post.thoughtText
        
        
//        let username = post.user.username.uppercased()
//        let firstChar  = username[username.startIndex]
//        let lastChar =  username.last
//
        cell.userNameLabel.text = "\(post.username)"
//
//
        
        
        return cell
    }
    
}

extension FeedViewController: FetcherDelegate {
    
    func handleError(data: Any) {
        print("Error ==>", data)
    }
    
    func handleSuccess(data: Any) {
        
        DispatchQueue.main.async {
            let posts = data as! [PostModel]
            self.data = posts
            self.tableViewFeed.reloadData()
        }
        
    }
    
}


extension Date {
    func timeAgoDisplay(date: Date)-> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: date)
    }
}

