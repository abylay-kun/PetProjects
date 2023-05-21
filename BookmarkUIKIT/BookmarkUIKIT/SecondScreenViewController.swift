//
//  SecondScreenViewController.swift
//  BookmarkUIKIT
//
//  Created by Abylay Duzel on 02.05.2023.
//

import UIKit

class SecondScreenViewController: UIViewController {
    
    let addBookmarkButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
      
       bookmark()
       navigationButtonAppScreen()
       headerLabelFunc()
    
 

    }
    
    func bookmark(){
    
        
        lazy var label:UILabel = {

            let label = UILabel()
            label.text = "Save Your First Bookmark"
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.font = label.font.withSize(36)
            label.numberOfLines = 2
            label.textAlignment = .center
            //label.lineBreakMode = .byWordWrapping
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            return label
            
        }()
        

        
        NSLayoutConstraint.activate ([
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
//            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
           
        ])

    }
    
    func headerLabelFunc(){
        lazy var headerLabel:UILabel = {

            let headerLabel = UILabel()
            headerLabel.text = "Bookmark App"
            headerLabel.textColor = .black
            headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
            headerLabel.font = headerLabel.font.withSize(17)
           
            headerLabel.textAlignment = .center
            //label.lineBreakMode = .byWordWrapping
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(headerLabel)
            return headerLabel
            
        }()
        
        NSLayoutConstraint.activate ([
        headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        headerLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 84),
        ])
    }
    
    func navigationButtonAppScreen(){
        
       
        
        view.addSubview(addBookmarkButton)

        addBookmarkButton.configuration = .filled()
        addBookmarkButton.configuration?.baseBackgroundColor = .black
        addBookmarkButton.configuration?.title = "Let's start collecting"
        addBookmarkButton.configuration?.baseForegroundColor = .white
        addBookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        addBookmarkButton.addTarget(self, action: #selector(alertBar), for: .touchUpInside)
        
        addBookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            addBookmarkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBookmarkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -37),
            addBookmarkButton.widthAnchor.constraint(equalToConstant: 358),
            addBookmarkButton.heightAnchor.constraint(equalToConstant: 58),
         
            
        
        ])
    }
    @objc func alertBar(){
        let bc = bookmarkAppScreenController()
        let alertController = UIAlertController(title: "Change", message:nil, preferredStyle:.alert)
        alertController.addTextField()
        alertController.addTextField()
        
        alertController.textFields![0].placeholder = "Name"
        alertController.textFields![1].placeholder = "link"
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            
            Post.posts.append(Post(title:alertController.textFields![0].text!, link: alertController.textFields![1].text!))
            bc.initializeList()
            self.goToBookmarkAppScreen()
            
        }))
        
        

        self.present(alertController, animated: true, completion: nil)


    }
    
    @objc func goToBookmarkAppScreen(){
        
        let bookmarkAppScreen = bookmarkAppScreenController()
        bookmarkAppScreen.title = "Alert screen"
        navigationController?.pushViewController(bookmarkAppScreen, animated: true)
        
        
    }

    
    
}
