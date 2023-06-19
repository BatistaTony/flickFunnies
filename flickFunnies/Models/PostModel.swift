//
//  PostModel.swift
//  flickFunnies
//
//  Created by Batista Tone on 19/05/23.
//

import Foundation


struct ReactionModel: Decodable {
    let _id: String
    let reactionId: String
    let reactionBody: String
    let username: String
    let createdAt: String
}


struct PostModel: Decodable {
    let _id: String
    let thoughtText: String
    let createdAt: String
    let username: String
    let reactions: [ReactionModel]
    let reactionCount: Int
}


struct User: Decodable {
    let id: String
    let username: String
    let email: String
    let avatar: String
}

