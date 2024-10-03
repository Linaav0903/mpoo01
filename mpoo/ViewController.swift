import UIKit

class ViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var agregarImagenButton: UIButton!

    var usuarios: [Usuario] = []
    var imagenSeleccionada: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaTableViewCell
        let usuario = usuarios[indexPath.row]
        cell.nombre.text = usuario.nombre
        cell.imagen.image = usuario.imagen
        return cell
    }

    @IBAction func agregarUsuario(_ sender: UIButton) {
        guard let nombre = nombreTextField.text, !nombre.isEmpty else {
            print("Escribe un nombre, por favor.")
            return
        }
        
        let nuevaImagen = imagenSeleccionada ?? UIImage(named: "imagenPorDefecto")
        let nuevoUsuario = Usuario(nombre: nombre, imagen: nuevaImagen)
        usuarios.append(nuevoUsuario)
        tableView.reloadData()
        nombreTextField.text = ""
    }

    @IBAction func seleccionarImagen(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagenSeleccionada = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}