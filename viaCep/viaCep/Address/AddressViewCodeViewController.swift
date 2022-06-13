import UIKit

class AddressViewCodeViewController: UIViewController {
    
    var address: Address?
    var fullAddress: String?
    
    @IBOutlet weak var textFieldNumber: UITextField!
    @IBOutlet weak var textFieldRecipient: UITextField!
    @IBOutlet weak var textFieldComplement: UITextField!
    
    init(address: Address) {
        super.init(nibName: nil, bundle: nil)
        self.address = address
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    let scrollViewAddressForm: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackViewAddressFrom: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let viewAddressee: AddressFormView = {
        let view = AddressFormView()
        view.labelAddressForm.text = "Destinatario"
        view.textFieldAddressForm.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewZipCode: AddressFormView = {
        let view = AddressFormView()
        view.labelAddressForm.text = "Rua"
        view.textFieldAddressForm.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewBairroCode: AddressFormView = {
        let view = AddressFormView()
        view.labelAddressForm.text = "Bairro"
        view.textFieldAddressForm.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewNumeroCode: AddressFormView = {
        let view = AddressFormView()
        view.labelAddressForm.text = "Numero"
        view.textFieldAddressForm.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewComplementoCode: AddressFormView = {
        let view = AddressFormView()
        view.labelAddressForm.text = "Complemento"
        view.textFieldAddressForm.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewCidadeCode: AddressFormView = {
        let view = AddressFormView()
        view.labelAddressForm.text = "Cidade"
        view.textFieldAddressForm.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewEstadoCode: AddressFormView = {
        let view = AddressFormView()
        view.labelAddressForm.text = "Estado"
        view.textFieldAddressForm.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewCepCode: AddressFormView = {
        let view = AddressFormView()
        view.labelAddressForm.text = "CEP"
        view.textFieldAddressForm.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonGenerator: UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 6
        button.setTitle("Gerar Etiqueta", for: .normal)
        button.addTarget(self, action: #selector(handlerButtonGenerateTag), for: .touchUpInside)
        return button
    }()
    
    
    
    @objc
    private func handlerButtonGenerateTag() {
        address?.destinatario = viewAddressee.textFieldAddressForm.text
        address?.numero = viewNumeroCode.textFieldAddressForm.text
        address?.complemento = viewComplementoCode.textFieldAddressForm.text
        
        createFullAddress()
        
        goToTag()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       fillTextFields()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupComponents()
        setupContraints()
    }
    
    private func setupComponents() {
        view.addSubview(scrollViewAddressForm)
        view.addSubview(buttonGenerator)
        scrollViewAddressForm.addSubview(stackViewAddressFrom)
        stackViewAddressFrom.addArrangedSubview(viewAddressee)
        stackViewAddressFrom.addArrangedSubview(viewZipCode)
        stackViewAddressFrom.addArrangedSubview(viewBairroCode)
        stackViewAddressFrom.addArrangedSubview(viewNumeroCode)
        stackViewAddressFrom.addArrangedSubview(viewComplementoCode)
        stackViewAddressFrom.addArrangedSubview(viewCidadeCode)
        stackViewAddressFrom.addArrangedSubview(viewEstadoCode)
        stackViewAddressFrom.addArrangedSubview(viewCepCode)
        
    }

    private func setupContraints()  {
        scrollViewAddressForm.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollViewAddressForm.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollViewAddressForm.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollViewAddressForm.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        stackViewAddressFrom.topAnchor.constraint(equalTo: scrollViewAddressForm.topAnchor).isActive = true
        stackViewAddressFrom.leadingAnchor.constraint(equalTo: scrollViewAddressForm.leadingAnchor).isActive = true
        stackViewAddressFrom.bottomAnchor.constraint(equalTo: scrollViewAddressForm.bottomAnchor).isActive = true
        stackViewAddressFrom.trailingAnchor.constraint(equalTo: scrollViewAddressForm.trailingAnchor).isActive = true
        stackViewAddressFrom.centerXAnchor.constraint(equalTo: scrollViewAddressForm.centerXAnchor).isActive = true
        
        
        buttonGenerator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonGenerator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        buttonGenerator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        buttonGenerator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
    
        
    }
    
    
 
    private func fillTextFields() {
        viewZipCode.textFieldAddressForm.text = address?.cep
        viewBairroCode.textFieldAddressForm.text = address?.bairro
        viewComplementoCode.textFieldAddressForm.text = address?.complemento
        viewCidadeCode.textFieldAddressForm.text = address?.localidade
        viewEstadoCode.textFieldAddressForm.text = address?.uf
        viewCepCode.textFieldAddressForm.text = address?.cep    
    }
    
    private func createFullAddress() {
        let fullAddress = """

        Destinatário: \(address?.destinatario ?? "").
                Endereco: \(address?.logradouro ?? ""), \(address?.numero ?? ""), \(address?.localidade ?? ""), \(address?.uf ?? ""), \(address?.bairro ?? "")
        """
        
        self.fullAddress = fullAddress
        
    }

    
    private func goToTag() {
        guard let fullAddress = fullAddress else { return }

        
        let tagViewController = TagViewController(fullAddress: fullAddress)
        navigationController?.pushViewController(tagViewController, animated: true)
    }
}
