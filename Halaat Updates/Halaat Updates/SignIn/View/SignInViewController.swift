//
//  LoginViewController.swift
//  Friend Finder
//
//  Created by inVenD on 20/03/2018.
//  Copyright © 2018 inVenD. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController , SegueHandlerType  {
    enum SegueIdentifier  : String {
        case mainview
    }
    
    @IBOutlet fileprivate weak var tfEmail : UITextField!
    @IBOutlet fileprivate weak var tfPassword : UITextField!
    
    var viewModel : SignInViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInViewModelImp(webManager: WebManagerImp())
        bindUI()
    }
    
    private func bindUI(){
        viewModel.showAlert = {[weak self] (title , message) in
            guard let this = self else {return}
            this.showAlertControllerWithOkTitle(title: title, message: message)
        }
        viewModel.showLoader = { [weak self] in
            guard let this = self else {return}
            this.view.makeToastActivity(.center)
        }
        viewModel.hideLoader = { [weak self] in
            guard let this = self else {return}
            this.view.hideToastActivity()
        }
        viewModel.success = { [weak self]  in
            guard let this = self else {return}
            this.performSegueWithIdentifier(segueIdentifier: .mainview, sender: self)
        }
        viewModel.returnPressed = { [weak self] in
            guard let this = self else {return}
            this.view.endEditing(true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func didTapOnLogin(sender : UIButton){
        viewModel.didTapOnLogin(email: tfEmail.text!, password: tfPassword.text!)
    }
    
    @IBAction func returnPressed(sender: UITextField) {
        viewModel.didReturnPressed()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segueIdentifierForSegue(segue: segue)
        if(identifier == .mainview){
            let destVC = (segue.destination as! UINavigationController).viewControllers.first as! HalatFeedsViewController
            
            destVC.inject(viewModel.getHalatFeedsViewModel(user: viewModel.user!))
        }
        
    }
}
