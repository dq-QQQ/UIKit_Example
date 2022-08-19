//
//  ViewController.swift
//  day03
//
//  Created by kyujin on 2022/08/19.
//

import UIKit

class ImageViewController: UIViewController {
    var parentView: UIViewController?
    @IBOutlet weak var scrollView: UIScrollView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ho")
    }
}


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectCell", for: indexPath) as?
                Cell else { //내가 지정한 collectcell을 하나씩 가져와서 cell에 저장한다. 저장하기전에 Cell로 downcasting
            return UICollectionViewCell()
        }
        cell.startAni()
        cell.layer.backgroundColor = UIColor(ciColor: .black).cgColor;
        if urlToUIImage(imageURL: imagesArr[indexPath.row]) != nil {
            DispatchQueue.global().async {[self] in
                let img = urlToUIImage(imageURL: imagesArr[indexPath.row])
                DispatchQueue.main.async {
                    cell.activity.hidesWhenStopped = true
                    cell.activity.stopAnimating()
                    cell.imgcell?.image = img
                }
            }
        }
        else {
            print("ho")
            let alertController = UIAlertController(title: "Error", message: "Cannot load data from URL" , preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10 // 가로에서 cell과 cell 사이의 거리
        //            let textAreaHeight: CGFloat = 65 // textLabel이 차지하는 높이
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2 // 셀 하나의 너비
        let height: CGFloat = width * 1 //셀 하나의 높이
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "ImageView") as? ImageViewController else {
                        print("error")
                            return
                }
                //instantiateViewController(withIdentifier:)는 스토리보드에서 특정 identifier를 받아 뷰 컨트롤러를 생성하고 데이터를 초기화하는 메소드입니다. identifier는 string 타입으로, 스토리보드에서 고유하게 뷰 컨트롤러를 구별할 수 있는 문자열입니다. 인터페이스 빌더에서 Storyboard ID 어트리뷰트와 같은 값을 넣으면 됩니다. 이 identifier는 뷰 컨트롤러 객체 자체 프로퍼티는 아닙니다. 스토리보드는 뷰 컨트롤러에 데이터를 놓을 위치를 찾는 데에 이 identifier를 사용합니다. 만약 스토리보드에 해당 identifier가 없다면 exception이 일어납니다. 반환값은 뷰 컨트롤러이며, 찾지 못하면 exception이 발생합니다.
                print("vc created")
                vc.parentView = self
                // sub view에 있는 parentView를 현재 view로 설정한다.
                self.navigationController?.pushViewController(vc, animated: true)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func urlToUIImage(imageURL: URL) -> UIImage? {
        if let imageData: NSData = NSData(contentsOf: imageURL) {
            return UIImage(data: imageData as Data)
        }
        return nil
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            // Get the new view controller using segue.destination.
//            // Pass the selected object to the new view controller.
//            if segue.identifier == "sgDetail" {
//                let cell = sender as! UICollectionView
//                let indexPath = tableViewPeople.indexPath(for: cell)
//                let detailView = segue.destination as! DetailViewController
//                detailView.receiveSubject(subject[((indexPath as NSIndexPath?)?.row)!])
//            }
//        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            guard let dest = segue.destination as? ImageViewController,
                let cell = sender as? Cell,
                  cell.imgcell.image != nil else {return}
            dest.image = cell.imgcell.image
        }
    }
}


class Cell : UICollectionViewCell{
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var imgcell: UIImageView!
    func startAni() {
        activity.startAnimating()
    }
    
    
}


let imagesArr : [URL] = [
    URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/florence.jpeg")!,
    URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/45025340661_7b9f8f9402_k.jpg")!,
    URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/8.22-396o5017lane.jpg")!,
    URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/43656168861_3c30e55b14_o.jpg")!
]
