//
//  EurekaViewController.swift
//  CUSTABAR
//
//  Created by Yudai Takahashi on 2021/05/31.
//

import UIKit
import Eureka
import ViewRow


class EurekaViewController: FormViewController {
    var alertController: UIAlertController!
    
    var CustomName : String = ""
    var Size : String = ""
    var Syrups: String = "0"
    var productImage: UIImage?
    var name: String = ""
    var sizePrice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBar設定
        self.navigationController?.navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor(red: 5/255, green: 132/255, blue: 144/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont(name: "VAL",size: 35)!]
        
        form
            
            +++ Section() {
                    $0.header = {
                        let header = HeaderFooterView<UIView>(.callback({   // (1)
                            let view = UIView(frame: CGRect(x: 0, y: 0,
                                width: self.view.frame.width, height: 100)) // (2)
                            view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
                            return view
                        }))
                        return header
                    }()
                }
            
            +++ Section("Section 1")
        
                <<< TextRow() { (row) in
                    row.title = "カスタム名"
                    row.placeholder = "カスタム名を記入"
                }.onChange{[unowned self] listrow in
                    self.CustomName = listrow.value ?? "選択なし"
                }

                <<< ViewRow<UIImageView>()
                .cellSetup { (cell, row) in
                    //  Construct the view for the cell
                    cell.view = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width ))
                    cell.contentView.addSubview(cell.view!)
                            
                    //  Get something to display
                    let image = self.productImage
                    cell.view!.image = image
                    cell.backgroundColor = UIColor.white
                            
                            
                    //  Define the cell's height
                    cell.height = { return CGFloat(500) }
                }
        
        
        form
            +++ SelectableSection<ListCheckRow<String>>("サイズ", selectionType: .singleSelection(enableDeselection: true))
                let continents = ["Short", "Tall", "Grande", "Venti"]
                for option in continents {
                    form.last! <<< ListCheckRow<String>(option){ listRow in
                        listRow.title = option
                        listRow.selectableValue = option
                        listRow.value = nil
                    }.onChange{[unowned self] listrow in
                        self.Size = listrow.value ?? "選択なし"
                        
                    }
                }
        
        form
            +++ SelectableSection<ListCheckRow<String>>("シロップ", selectionType: .singleSelection(enableDeselection: true))
                let syrup = ["バニラシロップ", "キャラメルシロップ", "シンプルクラシックシロップ", "アーモンドトフィーシロップ", "モカシロップ", "ホワイトモカシロップ","チャイシロップ"]
                for option in syrup {
                    form.last! <<< ListCheckRow<String>(option){ listRow in
                        listRow.title = option
                        listRow.selectableValue = option
                        listRow.value = nil
                    }.onChange{[unowned self] listrow in
                        self.Syrups = listrow.value ?? ""
                    }
                }
        
        form
            +++ Section("注文")
            <<< ButtonRow("カスタムを保存") {row in
            row.title = "注文"
            row.onCellSelection{[unowned self] ButtonCellOf, row in
                
                performSegue(withIdentifier: "toOrder", sender: nil)
                }
            }
    }
    
    //データを受け渡す。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "toOrder" {
        let orderView = segue.destination as! OrderViewController
        
        orderView.customString = CustomName
        orderView.customImage = productImage
        orderView.productName = name
        orderView.productSize = Size
        
        // サイズごとの価格を渡す
        if Size == "Short" {
            orderView.productPrice = sizePrice - 44
        }
        else if Size == "Tall" {
            orderView.productPrice = sizePrice
        }else if Size == "Grande" {
            orderView.productPrice = sizePrice + 44
        }
        else if Size == "Venti" {
            orderView.productPrice = sizePrice + 88
        }
        else {
            func alert(title:String, message:String) {
                alertController = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK",
                                               style: .default,
                                               handler: nil))
                present(alertController, animated: true)
            }

            func tapButton(_ sender: Any) {
                alert(title: "サンプル",
                      message: "メッセージ表示")
            }
        }
        
        orderView.customName1 = Syrups
        // シロップの追加がない時
        if Syrups != "0" {
            orderView.customPrice = 55
        }
      }
    }
}
