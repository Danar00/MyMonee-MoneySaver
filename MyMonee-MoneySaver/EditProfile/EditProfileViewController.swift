//
//  EditProfileViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var selesaiButton: UIButton!
    @IBOutlet weak var labelYourName: UILabel!
    
    var fotoEdit: UIImage? = UIImage(named: "foto_profile")
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelYourName.text! = user.username
        imagePicker.delegate = self
        imageProfile.image = user.image
        imageProfile.layer.cornerRadius = 50.5
//        imageProfile.image = passPhoto
        // Do any additional setup after loading the view.
    }
    @IBAction func editNameButton(_ sender: Any) {
        let alert = UIAlertController(title: "Masukan Nama", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your name"
        }
        alert.addAction(UIAlertAction(title: "Simpan", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.labelYourName.text = textField!.text
            user.username = textField!.text!
        }))
        alert.addAction(UIAlertAction(title: "Kembali", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.image = chosenImage
        user.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func editImageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = .popover
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func selesaiButton(_ sender: Any) {
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
//        profileViewController.passPhoto = imageProfile.image
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
}
