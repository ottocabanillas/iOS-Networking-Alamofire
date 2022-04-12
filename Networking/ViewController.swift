//
//  ViewController.swift
//  Networking
//
//  Created by Oscar Cabanillas on 11/04/2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var idLabel: UILabel!

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var downloadImageButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    nameLabel.text = ""
    nameLabel.numberOfLines = 0
    emailLabel.text = ""
    idLabel.text = ""

    activityIndicator.hidesWhenStopped = true
    activityIndicator.stopAnimating()

  }

  @IBAction func getUserAction(_ sender: Any) {

    activityIndicator.startAnimating()

    NetworkingProvider.shared.getUser(id: 3081) { (user) in

      self.activityIndicator.stopAnimating()

      self.setupUser(user: user)

    } failure: { (error) in

      self.activityIndicator.stopAnimating()

      print(error.debugDescription)
      self.nameLabel.text = ""
      self.emailLabel.text = ""
      self.idLabel.text = ""
      
    }

  }

  @IBAction func addUserAction(_ sender: Any) {

    let newUser = NewUser(name: "Otto", email: "osk@test.com", gender: "male", status: "inactive")

    activityIndicator.startAnimating()

    NetworkingProvider.shared.addUser(user: newUser) { (user) in

      self.activityIndicator.stopAnimating()

      self.setupUser(user: user)

    } failure: { (error) in

      self.activityIndicator.stopAnimating()

      self.nameLabel.text = error.debugDescription

    }
  }

  @IBAction func updateUserAction(_ sender: Any) {

    let newUser = NewUser(name: "Otto", email: nil, gender: nil, status: nil)

    activityIndicator.startAnimating()

    let id: Int = 3035

    NetworkingProvider.shared.updateUser(id: id, user: newUser) { (user) in

      self.activityIndicator.stopAnimating()

      self.setupUser(user: user)

    } failure: { (error) in

      self.activityIndicator.stopAnimating()

      self.nameLabel.text = error.debugDescription

    }

  }

  
  @IBAction func deleteUserAction(_ sender: Any) {

    let id: Int = 3035

    activityIndicator.startAnimating()

    NetworkingProvider.shared.deleteUser(id: id) {

      self.activityIndicator.stopAnimating()

      self.nameLabel.text = "Se ha borrado el usuario con ID: \(id)"
      self.emailLabel.text = ""
      self.idLabel.text = ""


    } failure: { (error) in

      self.activityIndicator.stopAnimating()

      self.nameLabel.text = error.debugDescription

    }
  }


  @IBAction func downloadImageAction(_ sender: Any) {

    downloadImageButton.isHidden = true
    logoImageView.kf.setImage(with: URL(string: "https://www.apple.com/v/swift/c/images/overview/icon_swift_hero_large.png"))
  }

  private func setupUser(user: User) {

    self.nameLabel.text = user.name
    self.emailLabel.text = user.email
    self.idLabel.text = user.id?.description

  }
  

}

