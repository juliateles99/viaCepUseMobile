import UIKit

class AddressFormView: UIView {
    
    let labelAddressForm: UILabel = {
        let label = UILabel()
        label.numberOfLines  = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textFieldAddressForm: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
      setupComponentes()
      setupConstraints()
    }
    
    private func setupComponentes() {
        addSubview(labelAddressForm)
        addSubview(textFieldAddressForm)

    }
    
    private func setupConstraints() {
        labelAddressForm.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        labelAddressForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        
        textFieldAddressForm.topAnchor.constraint(equalTo: labelAddressForm.bottomAnchor, constant: 8).isActive = true
        textFieldAddressForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        textFieldAddressForm.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
        textFieldAddressForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        textFieldAddressForm.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    }
}
