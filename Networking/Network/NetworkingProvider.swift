//
//  NetworkingProvider.swift
//  Networking
//
//  Created by Oscar Cabanillas on 11/04/2022.
//

import Foundation
import Alamofire

final class NetworkingProvider {

  static let shared = NetworkingProvider()

  private let kBaseUrl = "https://gorest.co.in/public/v2/"
  private let kStatusOk = 200...299
  private let kToken = "31f109f5f6b8cffd0fa306c1a3ae83fd5b3e8eb28b21e62b1b26b5d8709b6744"

  
  func getUser(id: Int, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {

    let url = "\(kBaseUrl)users/\(id)"

    let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]

    AF.request(url, method: .get, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: User.self) { response in

      if let user = response.value {
        success(user)
      } else {
        failure(response.error)
      }
    }
  }

  func addUser(user: NewUser, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {

    let url = "\(kBaseUrl)users"

    let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]


    AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: User.self) { response in

      if let user = response.value, user.id != nil {
        success(user)
      } else {
        failure(response.error)
      }
    }
  }

  func updateUser(id: Int, user: NewUser, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {

    let url = "\(kBaseUrl)users/\(id)"

    let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]

    AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: User.self) { response in

      if let user = response.value, user.id != nil {
        success(user)
      } else {
        failure(response.error)
      }
    }
  }

  func deleteUser(id: Int, success: @escaping () -> (), failure: @escaping (_ error: Error?) -> ()) {

    let url = "\(kBaseUrl)users/\(id)"

    let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]

    AF.request(url, method: .delete, headers: headers).validate(statusCode: kStatusOk).response { (response) in

      if let error = response.error {
        failure(error)
      } else {
        success()
      }
    }
  }



}
