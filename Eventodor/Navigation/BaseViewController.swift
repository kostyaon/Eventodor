//
//  BaseViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var rootScrollView: UIScrollView!
    var adjustableForKeyboard = false
    var dismissKeyboardOnTap = false
    var hideNavBar = true
    var loadingViewController: UIViewController?
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = hideNavBar
        
        if adjustableForKeyboard {
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        }
        
        if dismissKeyboardOnTap {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        }
        
        handleError()
        handleUpdateUI()
    }
    
    // MARK: - Helper method's
    // Loading view
    func showLoading() {
        if loadingViewController != nil {
            return
        }
        loadingViewController = UIViewController()
        guard let loadingView = loadingViewController?.view else {
            loadingViewController = nil
            return
        }
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        loadingView.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            loadingView.alpha = 1.0
        }
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.2, animations: {
            self.loadingViewController?.view.alpha = 0.0
        }) { [weak self] _ in
            self?.loadingViewController?.view.removeFromSuperview()
            self?.loadingViewController = nil
        }
    }
    
    func showError(title: String = "error_title".localized(), message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "ok_title".localized(), style: .default)
        alert.addAction(actionOk)
        present(alert, animated: true)
    }
}

// MARK: - Error and update ui handler
extension BaseViewController {
    
    @objc func handleError() {
        //empty implementation
    }
    
    @objc func handleUpdateUI() {
      //  fatalError("Must Override")
    }
}

// MARK: - Private method's
private
extension BaseViewController {
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let scrollView = rootScrollView else {
            return
        }
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: scrollView.contentInset.top, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
