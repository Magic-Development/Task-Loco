//
//  UserInfo.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation

struct UserResponse: Response {
    let responseCode: Int
    let message: String
    let data: User?
    let error: ResponseError?
}

struct User: Codable {
	let id: String
	let username: String
	let name: String?
	let email: String?
    let password: String?
    let apiKey: String
	let createdAt: String?
	let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, name, email, password, apiKey, createdAt, updatedAt
    }
}

struct UserHeaderResponse: Response {
	let responseCode: Int
    let message: String
    let data: [UserHeader]?
    let error: ResponseError?
}

struct UserHeader: Codable, Hashable {
	var username: String = General.empty
	var name: String = General.empty
		
	func hash(into hasher: inout Hasher) {
		hasher.combine(username)
	}
}

struct UserProjectResponse: Response {
	let responseCode: Int
    let message: String
    let data: UserProject?
    let error: ResponseError?
}

struct UserProject: Codable {
	let user: User
	let project: [Project]
}
