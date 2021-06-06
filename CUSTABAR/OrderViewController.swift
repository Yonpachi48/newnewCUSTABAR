//
//  OrderViewController.swift
//  CUSTABAR
//
//  Created by Yudai Takahashi on 2021/06/02.
//

import UIKit
import RealmSwift
import PopupDialog

class OrderViewController: UIViewController {

    var customString = ""
    var customImage: UIImage?
    var productName = ""
    var productSize = ""
    var productPrice = 0
    var customPrice = 0
    var customName1 = ""
    var customName2 = ""
    var customName3 = ""
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var Image: UIImageView!
    @IBOutlet var productlabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var customLabel1: UILabel!
    @IBOutlet var customLabel2: UILabel!
    @IBOutlet var customLabel3: UILabel!
    @IBOutlet var sumLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var listButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBarを表示しない場合
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        Image.image = customImage
        nameLabel.text = customString
        
        productlabel.text = "・" + productName
        sizeLabel.text = "・" + productSize + "サイズ" + "(¥" + String(productPrice) + ")"
        if customPrice != 0 {
            customLabel1.text = "・" + customName1 + "(+ ¥" + String(customPrice) + ")"
        }
        sumLabel.text = "合計 " + String(productPrice+customPrice) + "円"
        
        
        //ボタンの画像の設定
        backButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15);
        
        listButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15);
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        // NavigationBarを表示する場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func listButtonTapped(_ sender: Any) {
        let item = Item()
        item.Name = customString
        item.Size = productSize
        item.Syrup = customName1
        
        
        // インスタンスをRealmに保存
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(item)
            })
        }catch{
            print(error)
        }
        
        //list画面に戻る
        self.navigationController?.popToRootViewController(animated: true)
        // NavigationBarを表示する場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
