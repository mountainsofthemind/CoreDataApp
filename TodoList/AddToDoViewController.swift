//
//  AddToDoViewController.swift
//  TodoList
//
//  Created by Field Employee on 12/26/20.
//

import UIKit

class AddToDoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var pickerController = UIImagePickerController()
    var toDoTableViewController:ToDoTableViewController?=nil
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        
    }
    
    @IBAction func mediaFolderTapped(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController,animated: true,completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender:Any) {
        if let context = (UIApplication.shared.delegate as?AppDelegate)?.persistentContainer.viewContext
        {
            let newToDo = ToDoCD(context:context)
            newToDo.priority = Int32(prioritySegment.selectedSegmentIndex)
            
            if let name = nameTextField.text
            {
                newToDo.name = name
            }
            newToDo.image = imageView.image?.jpegData(compressionQuality: 1.0)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated:true)
    }
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addToDoViewController=segue.destination as? AddToDoViewController{
            addToDoViewController.toDoTableViewController = self
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}



//let newToDo = ToDo()
//newToDo.priority = prioritySegment.selectedSegmentIndex
//if let name = nameTextField.text {
//    newToDo.name = name
//}
//toDoTableViewController?.toDos.append(newToDo)
//toDoTableViewController?.tableView.reloadData()
//navigationController?.popViewController(animated: true)
