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
    var effect : Effect? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        if effect != nil {
            efxImageView.image = UIImage(data: effect!.image as! Data)
            titleTextField.text = effect!.title
            addupdatebutton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
            
            
            
        }
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
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var addupdatebutton: UIButton!
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        
            // Nick rika ze staci ta radka predtim al enic se na iphonu nedelo... tak jsem jeste zkopiroval tu dalsi cast kodu a konecne se to zeptalo na souhlas s pouzivanim kamery a nechalo to vyfotit
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if effect != nil {
            
            effect!.title = titleTextField.text
            effect!.image = UIImagePNGRepresentation(efxImageView.image!) as NSData?
            
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let effect = Effect(context: context)
            effect.title = titleTextField.text
            effect.image = UIImagePNGRepresentation(efxImageView.image!) as NSData?
            
        }
        
      
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
    }
    @IBAction func deleteTapped(_ sender: Any) {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(effect!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
}
