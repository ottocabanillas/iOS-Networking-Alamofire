//
//  User.swift
//  Networking
//
//  Created by Oscar Cabanillas on 11/04/2022.
//

import Foundation

//struct UserResponse: Decodable {
//
//  let code: Int?
//  let meta: Meta?
//  let data: User?
//
//}

struct User: Decodable {

  let id: Int?
  let name: String?
  let email: String?
  let gender: String?
  let status: String?

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case email = "email"
    case gender = "gender"
    case status = "status"
  }

}

//struct Meta: Decodable {
//
//}

//{
//  "code": 200,
//  "meta": null,
//  "data": {
//    "id": 2909,
//    "name": "Anagh Nambeesan",
//    "email": "nambeesan_anagh@buckridge-harber.org",
//    "gender": "male",
//    "status": "inactive"
//  }
//}
