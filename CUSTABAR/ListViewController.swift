//
//  ViewController.swift
//  CUSTABAR
//
//  Created by Yudai Takahashi on 2021/05/22.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var itemList: Results<Item>!
    @IBOutlet var collectionView: UICollectionView!
    
    private let photos = ["maccha", "vanilla", "darkmocha", "caramel"]
    private let titles = ["抹茶", "バニラ", "ダークモカ", "キャラメル"]
    private let star = ["★★★★★", "★★★★☆", "★★★☆☆","★★☆☆☆","★☆☆☆☆"]
    private let color: [UIColor] = [UIColor(red: 195/255, green: 232/255, blue: 248/255, alpha: 1.0), UIColor(red: 248/255, green: 240/255, blue: 143/255, alpha: 1.0), UIColor(red: 225/255, green: 248/255, blue: 157/255, alpha: 1.0), UIColor(red: 248/255, green: 199/255, blue: 244/255, alpha: 1.0)]
    private let price = ["¥ 670", "¥ 650", "¥ 720", "¥ 560"]
    private let comment = ["抹茶がいい", "バニラ感が強い", "ダークモカが美味しい", "キャラメル好き"]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }

    // １つのセクションの中に表示するセル（要素）の数。
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    

    // セル（要素）に表示する内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // "Cell" の部分は　Storyboard でつけた cell の identifier。
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //cellの枠線の設定
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 220/255, green: 222/255, blue: 224/255, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 10
        
        // Tag番号を使ってインスタンスをつくる
        let backColorLabel = cell.contentView.viewWithTag(1)  as! UILabel
        backColorLabel.backgroundColor = color[indexPath.row]
        
        let photoImageView = cell.contentView.viewWithTag(2)  as! UIImageView
        let photoImage = UIImage(named: photos[indexPath.row])
        photoImageView.image = photoImage

        let productLabel = cell.contentView.viewWithTag(3) as! UILabel
        productLabel.text = itemList[indexPath.row].Name
        
        let priceLabel = cell.contentView.viewWithTag(4) as! UILabel
        priceLabel.text = price[indexPath.row]
        
        let starLabel = cell.contentView.viewWithTag(5) as! UILabel
        starLabel.text = star[indexPath.row]
        
        let commentLabel = cell.contentView.viewWithTag(6) as! UILabel
        commentLabel.text = comment[indexPath.row]
        
        let HeightLine = cell.contentView.viewWithTag(7)  as! UILabel
        HeightLine.backgroundColor = UIColor(red: 166/255, green: 170/255, blue: 169/255, alpha: 1.0)
        
        return cell
    
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 1.2
        let height: CGFloat = collectionView.frame.height / 7.2
        return CGSize(width: width, height: height)
    }
    
    // 画面が表示される直前にtableViewを更新
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // NavigationBarを表示したい場合
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
            self.navigationController?.navigationBar.titleTextAttributes = [
                // 文字の色
                .foregroundColor: UIColor(red: 5/255, green: 132/255, blue: 144/255, alpha: 1.0),
                NSAttributedString.Key.font: UIFont(name: "VAL",size: 35)!
                    ]
            
            do{
                let realm = try Realm()
                itemList = realm.objects(Item.self)
            }catch{
                print(error)
            }
            
        }


}
