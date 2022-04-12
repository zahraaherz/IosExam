//
//  ViewController.swift
//  IOSExam
//
//  Created by Zahraa Herz on 05/04/2022.
//

import UIKit

class ViewController: UIViewController  {

    @IBOutlet var PageControl: UIPageControl!
    
    @IBOutlet var CollectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    var imageArr = [  "1", "2", "3" , "4"]
    var tData = ["Tree1" , "Queen" , "King" , "Game" , "first 1" ]
    var timer : Timer?
    //Image.isUserInteractionEnabled = true

    @IBOutlet var SearchBar: UISearchBar!
    var filteredData: [String]!
    
    
    var i = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil , repeats: true)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        SearchBar.delegate = self
        filteredData = tData
        CollectionView.delegate = self
        CollectionView.dataSource = self

        PageControl.numberOfPages = imageArr.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @objc func scrollToNextCell(){

        if i < imageArr.count-1
        {
          i = i + 1
            PageControl.currentPage = i


        }else
        {
            i = 0
            PageControl.currentPage = i

        }

        let cellSize = CGSize(width: self.view.frame.width, height:  self.view.frame.height);
        let contentOffset = CollectionView.contentOffset;

        CollectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true )
        
        CollectionView.reloadData()
        CollectionView.layoutIfNeeded()

    }
    
 /*
    func stopTimerTest() {
      timer?.invalidate()
      timer = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        super.touchesBegan(touches, with: event)
            
        let touch: UITouch = touches.first!
            
            if (touch.view == CollectionView){
                print("touchesBegan | This is an ImageView")
                
            }else{
                print("touchesBegan | This is not an ImageView")
            }
        }
    

  */

}

extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource  , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.Image.image = UIImage(named: imageArr[indexPath.row])
        return cell
    }
    

    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout: UICollectionViewLayout , sizeForItemAt indexPath : IndexPath) -> CGSize {
        return CGSize(width: CollectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.filteredData[indexPath.row]
        
        return cell
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.SearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = searchText.isEmpty ? tData : tData.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
    
}
// , UICollectionViewDelegateFlowLayout
