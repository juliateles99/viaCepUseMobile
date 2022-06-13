import UIKit

struct Address: Decodable {
    let cep: String?
    let logradouro: String?
    let bairro: String?
    let localidade: String?
    let uf: String?
    var complemento: String?
    var destinatario: String?
    var numero: String?
    
}

class HomeViewController: UIViewController {

    var address: Address?
    
    // MARK: Propeties
    let imageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hor-grad")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let textFieldZipCode: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite o CEP"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let buttonSearch: UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 6
        button.setTitle("Buscar", for: .normal)
        button.addTarget(self, action: #selector(handlerButtonSearch), for: .touchUpInside)
        return button
    }()
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }

    // MARK: Methods
    @objc
    private func handlerButtonSearch() {
        goToAddress()
        getAddress()
    }

    // MARK: Setups
    private func setupUI() {
        view.backgroundColor = .white
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        view.addSubview(imageLogo)
        view.addSubview(textFieldZipCode)
        view.addSubview(buttonSearch)
    }
    
    private func setupConstraints() {
        imageLogo.heightAnchor.constraint(equalToConstant: 128).isActive = true
        imageLogo.widthAnchor.constraint(equalToConstant: 128).isActive = true
        imageLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        textFieldZipCode.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFieldZipCode.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 24).isActive = true
        textFieldZipCode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        textFieldZipCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        buttonSearch.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonSearch.topAnchor.constraint(equalTo: textFieldZipCode.bottomAnchor, constant: 24).isActive = true
        buttonSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        buttonSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
    }
    
    private func goToAddress() {
        guard let address = address else { return  }

        let addressViewController = AddressViewCodeViewController(address: address)
        navigationController?.pushViewController(addressViewController, animated: true)
    }
    
    private func getAddress() {
        
        guard let zipCode = textFieldZipCode.text else { return }
        guard zipCode.count == 8 else { return }
        
        guard let url = URL(string: "https://viacep.com.br/ws/\(zipCode)/json/") else { return }
       
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("Status Code", response.statusCode)
            }
            guard let data = data else { return }
            guard let address = try? JSONDecoder().decode(Address.self, from: data) else { return }
            
            self.address = address
            
            DispatchQueue.main.async {
            self.goToAddress()
            }
            
            
            print(address)
            
            
            
            
        }.resume()
    }

}


