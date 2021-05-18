//
//  ProfileViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var testImage: UIImageView!
    
    var passPhoto: UIImage? = UIImage(named: "foto_profile")
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text! = user.username
        testImage.image = user.image
        testImage.layer.cornerRadius = 50.5
        testImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
        let editProfile = EditProfileViewController(nibName: String(describing: EditProfileViewController.self), bundle: nil)
        editProfile.fotoEdit = testImage.image
        navigationController?.pushViewController(editProfile, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
