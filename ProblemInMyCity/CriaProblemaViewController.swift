//
//  CriaProblemaViewController.swift
//  ProblemInMyCity
//
//  Created by Henry Bilby on 09/01/22.
//

import UIKit

class CriaProblemaViewController: UIViewController {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEndereco: UITextField!
    @IBOutlet weak var textFieldDescricao: UITextField!
    @IBOutlet weak var imageViewFoto: UIImageView!
    @IBOutlet weak var buttonFoto: UIButton!
    
    var problem : Problem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let problem = problem {
            setWidgetsValues(problem: problem)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func salvarPressed(_ sender: Any) {
        if !isEditProblem() {
            problem = Problem(context: context)
        }
        
        problem.nome = textFieldNome.text
        problem.endereco = textFieldEndereco.text
        problem.descricao = textFieldDescricao.text
        problem.foto = imageViewFoto.image?.pngData()
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func fotoPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Selecionar imagem", message: "De onde deseja obter a imagem?", preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }

        let bibliotecaAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }

        let albumAction = UIAlertAction(title: "Álbum de Fotos", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(bibliotecaAction)
        alert.addAction(albumAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func isEditProblem() -> Bool {
        return problem != nil
    }
    
    private func setButtonBorder(){
        buttonFoto.layer.borderColor = UIColor.blue.cgColor
        buttonFoto.layer.borderWidth = 1.0
    }
    
    private func setWidgetsValues(problem : Problem) {
        labelTitulo.text = "Editar Problema"
        textFieldNome.text = problem.nome
        textFieldEndereco.text = problem.endereco
        textFieldDescricao.text = problem.descricao
        if let image = problem.foto {
            imageViewFoto.image = UIImage(data: image)
        }
    }
}

extension CriaProblemaViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageViewFoto.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
