import UIKit

class TagViewController: UIViewController {

    let fullAddress: String?
    
    @IBOutlet weak var buttonLabelEndereco: UILabel!
    
    init(fullAddress: String) {
        self.fullAddress = fullAddress
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var viewTag: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = UIColor.blue
    }

    
    
    private func setupUI() {
        viewTag?.layer.cornerRadius = 6
        buttonLabelEndereco.text = fullAddress
    }
    
}
