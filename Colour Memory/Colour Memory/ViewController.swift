//
//  ViewController.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 22/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CMCardCollectionViewCellDelegate,UICollectionViewDelegateFlowLayout {

    var arrIndexPaths:Array<IndexPath> = Array()
    
    @IBOutlet weak var collectionViewGameBoard:UICollectionView!
    @IBOutlet weak var lblPoint:UILabel!
    var viewPopUp:UIView?
    
    let objManager = CMCardBoardLogicManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblPoint.layer.cornerRadius = 5
        self.lblPoint.layer.borderWidth = 1
        self.lblPoint.layer.borderColor = UIColor.lightGray.cgColor
        
        self.title = "Game Board"
        
        self.collectionViewGameBoard.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UIDevice.current.orientation.isLandscape == false{
        
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
            
        }else{
            
        UIDevice.current.setValue(UIInterfaceOrientation.portraitUpsideDown.rawValue, forKey: "orientation")
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.collectionViewGameBoard.collectionViewLayout.invalidateLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.objManager.arrCards?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CMCardCollectionViewCell{
            
            self.objManager.arrCards![indexPath.row].index = indexPath.row
            
            cell.delegate = self
            
            cell.fillCard(objCard: (self.objManager.arrCards![indexPath.row]),index:indexPath)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var viewWidth  = 70
        var viewHeight = 70
        
        let screenSizeWidth = UIScreen.main.bounds.size.width
        
        if screenSizeWidth <= 320{ // iPhone 4, iPhone 5, iPhone SE
            
            viewWidth = 70
            viewWidth = 70
            
        }else if screenSizeWidth > 320 && screenSizeWidth < 414 {
            
            viewWidth  = 80
            viewHeight = 80
            
        }else if screenSizeWidth >= 414{ // iPhone 6+
            
            viewWidth  = 90
            viewHeight = 90
        }
        
        return CGSize(width: viewWidth, height: viewHeight)
    }
    
    //MARK: - CMCardCollectionViewCellDelegate
    func sendPoint(_ point: Int) {
        
        if let lblVal = self.lblPoint.text{
            
            self.lblPoint.text = String(format: "%d", Int(lblVal)!+point)
        }
        
        weak var ___weakSelf = self
        
        self.objManager.updateCardObjects(arr: self.objManager.arrSelectedCards!, points: point, handler: {(needtoCardFlipped, allCardHasBeenFlipped) in
        
            if needtoCardFlipped == true{
                
                ___weakSelf?.collectionViewGameBoard.reloadItems(at: self.arrIndexPaths)
                
            }
            
            if allCardHasBeenFlipped == true{
                
                ___weakSelf?.showAlert()
            }
            
            ___weakSelf?.arrIndexPaths.removeAll()
            ___weakSelf?.openPopUp(point: Int16(point))

        })
        
        
    }
    
    func openPopUp(point:Int16) -> Void {
        
       let nib = Bundle(for: CMCardDecisionPopUp.self)
       let arr = nib.loadNibNamed("CMCardDecisionPopUp", owner: nil, options: nil)
        if let view = arr?.last as? UIView{
            
            let objClass = arr?[0] as! CMCardDecisionPopUp
            objClass.loadUI(score: point)
            
            self.view.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            let topConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
            self.view.addConstraint(topConstraint)
            
            let bottomConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute:NSLayoutAttribute.bottom , multiplier: 1.0, constant: 0)
            self.view.addConstraint(bottomConstraint)
            
            let leftConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
            self.view.addConstraint(leftConstraint)
            
            let rightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
            self.view.addConstraint(rightConstraint)
            
            self.view.layoutIfNeeded()
            
            self.viewPopUp = view
            
            self.perform(#selector(ViewController.removePopUp), with: nil, afterDelay: 1.0)
            

        }
    }
    
    func removePopUp() -> Void {
        
        self.viewPopUp?.removeFromSuperview()
        
    }
    
    func updateCellIndex(_ index:IndexPath) -> Void{
        
        self.objManager.arrSelectedCards?.append((self.objManager.arrCards?[index.row])!)
        
        self.arrIndexPaths.append(index)
        
    }
    
    @IBAction func movetoPlayerListVC(){
        
        self.navigatetoPlayerVC()
    }
    
    func showAlert() -> Void {
        
        weak var ___weakSelf = self
        
        let alert = UIAlertController(title: "Alert", message: "Game has been completed, Please Enter Your Name", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler:{(textField:UITextField?)->Void in
        
        
        })
        
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(alertAction:UIAlertAction)->Void in
        
            if let textField = alert.textFields?[0], (alert.textFields?[0].text?.characters.count)! > 0 {
            
                CMDataBaseManager.sharedManager.savePlayerInformation(name: textField.text!, score: Int(self.lblPoint.text!)!)
                CMDataBaseManager.sharedManager.updatePlayerRank()
                ___weakSelf?.navigatetoPlayerVC()

                
            }else{
                
                ___weakSelf?.showAlert()
            }
            
        })
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func navigatetoPlayerVC() -> Void {
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PlayerListVC")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
