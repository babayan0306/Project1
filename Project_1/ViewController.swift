//
//  ViewController.swift
//  Project_1
//
//  Created by Valodya Galstyan on 11.02.23.
//

import UIKit

var a = 4
var b = 7
var c = 0


class ViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var filteredProducts: [Product] = []
    var allProducts: [Product] = []
    var favoriteList: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let st = UIStoryboard(name: "Main", bundle: .main)
//        let nextVC = st.instantiateViewController(withIdentifier: "ViewController") as? ViewController
//        nextVC?.modalPresentationStyle = .formSheet
//        nextVC?.modalTransitionStyle = .flipHorizontal
//
//        self.present(nextVC!, animated: true)
//
        
        generateProducts()
        registerCells()
        configDelegates()
    }

    // Register  Cellsfrom XIB
    private func registerCells() {
        let myXib = UINib(nibName: "ProductCell", bundle: .main)
        productTableView.register(myXib, forCellReuseIdentifier: "ProductCell")
    }
    
    // Configre all delegates
    private func configDelegates() {
        searchTextField.delegate = self
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
    
    
    
    // Configure UI style
    private func configUI() {
        
    }
    
    // Generate hardcoded product list
    private func generateProducts() {
        allProducts.append(Product(icon: "barbeque", title: "Barbeque", isFavorite: false))
        allProducts.append(Product(icon: "dolma", title: "Dolma", isFavorite: false))
        allProducts.append(Product(icon: "qeabab", title: "Qeabab", isFavorite: false))
        allProducts.append(Product(icon: "xash", title: "Xash", isFavorite: false))
        
        filteredProducts = allProducts
    }
    
    // Update tableview
    @IBAction func updateListsAction(_ sender: UIButton) {
       
        switch sender.tag {
        case 0:
            filteredProducts = allProducts
        case 1:
            filteredProducts = favoriteList
        default: break
        }
        
        productTableView.reloadData()
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        textField.text "Do"
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}

//protocol MYUITextFieldDelegate: AnyObject {
//    func aaa()
//}
//
//class MYUITextField {
//    
//    weak var delegate: MYUITextFieldDelegate?
//    
//    func action() {
//        delegate?.aaa()
//    }
//    
//}
//
//class BVC: MYUITextFieldDelegate {
//    
//    var searchTF: MYUITextField  = MYUITextField()
//    
//    init() {
//        searchTF.delegate = self
//    }
//    
//    func aaa() {
//        
//    }
//}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell
        
        cell?.setData(filteredProducts[indexPath.row], index: indexPath.row)
        
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension ViewController: ProductCelldelegate {
    func didSelectFavorite(selectedIndex: Int) {
        for i in 0..<allProducts.count {
            allProducts[i].isFavorite = false
            if i == selectedIndex {
                allProducts[i].isFavorite = true
                favoriteList.append(allProducts[i])
            }
        }
        
        filteredProducts = allProducts
        
        productTableView.reloadData()
    }
}

//enum Status {
//    case fav, list
//}
