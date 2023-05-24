//
//  PostModel.swift
//  flickFunnies
//
//  Created by Batista Tone on 19/05/23.
//

import Foundation


struct PostModel {
    let user: User
    let title: String
    let content: String
    let category: String
    let likes: Int
    let created_at: String
}


struct User {
    let id: String
    let username: String
    let email: String
    let avatar: String
}
