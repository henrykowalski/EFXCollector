//
//  EFXViewController.swift
//  (nick to nazval GameViewController
//  EFXCollector
//
//  Created by Andrzej Palec on 28/04/2017.
//  Copyright © 2017 Andrzej Palec. All rights reserved.
//

import UIKit

class EFXViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    // Nick to nazval gameImageView:
    @IBOutlet weak var efxImageView: UIImageView!
    
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
    }
    
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        efxImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let effect = Effect(context: context)
        effect.title = titleTextField.text
        effect.image = UIImagePNGRepresentation(efxImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
    }
}
