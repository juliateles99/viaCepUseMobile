import UIKit

struct Address: Decodable {
    let: cep: String?
    let logradouro: String?
    var complememto: String?
    let bairro: String?
    let localidade: String?
    let uf: String?
    var destinatario: String?
    var numero: String?
}

class Api: UIViewController() {
    
    // MARK: Properties
    var address: Address?
  
    // MARK: Outlets
    // @IBOutlet weak var imageLogo: UIImageView!
    // @IBOutlet weak var textFieldAZipCode: UITextField!
    // @IBOutlet weak var buttonSearch: UIButton!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = ""
    }
    
    private func getAddress() {
        guard let zipCode = textFieldAZipCode.text else { return }
        guard zipCode.count == 8 else { return }
        
        guard let url = URL(string: "https://viacep.com.br/ws/\(zipCode)/json/") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response =  response as? HTTPURLResponse {
                print("Status Code: ", response.statusCode)
            }
            
            guard let data = data else { return }
            do {
                let address = try JSONCoder().decode(Address.self, from: data)
                self.address = address
                
            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueu.main.async {
                self.goToAddress()
            
            }
        }.resume()
    }
}
