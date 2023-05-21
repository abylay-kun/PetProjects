//
//  ViewController.swift
//  BookmarkUIKIT
//
//  Created by Abylay Duzel on 02.05.2023.
//

import UIKit

class ViewController: UIViewController {
   
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.backgroundColor = .black
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "backImage.png")!)
        
        //view.largeContentImage = UIImage(named: "backImage.png")
        //view.Image(UIImage(named: "backImage.png"), for: UIControl.State.normal)
      
        mainLabel()
      
        navigationButton()
        parseNameAndLinkFromApi()
 
       
    }
    
    func parseNameAndLinkFromApi(){
        
        let url = String(format: "https://api.nobelprize.org/2.1/laureates")
        
        guard let formatUrl = URL(string: url) else {return}
        let request = URLRequest(url: formatUrl)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                if let error = error{
                    print(error)
                }
                if let data = data{
                    let jsonFile = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] // Serialize JSON
                    if let laureates = jsonFile?["laureates"] as? [[String:Any]]{
                        for laureat in laureates{
                            
                            let name = laureat["fullName"] as! [String:Any]
                            let nameInEng = name["en"] as! String
                            
                            let wiki = laureat["wikipedia"] as! [String:Any]
                            let wikipediaLink = wiki["english"] as! String
                            
                            Post.posts.append(Post(title: nameInEng, link: wikipediaLink))
                            print(Post.posts)
                        }
                        
                       
                    }
                   
                    //nameAndLinksArray.append(nameAndLink(name: "something", link: "someLink"))
                }

            }
            catch {
                print(error)
            }
            
        }.resume()
        
        
                
    }
    
    func mainLabel(){
    
        
        lazy var label:UILabel = {

            let label = UILabel()
            label.text = "Save all interesting links in one app"
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.font = label.font.withSize(36)
            label.numberOfLines = 2
            //label.lineBreakMode = .byWordWrapping
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            return label
            
        }()
        
        
        let imageName = "backImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        view.addSubview(imageView)
        
        
        NSLayoutConstraint.activate([

            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -132),
            
 
        ])
     
    }
    

    
    
    func navigationButton(){
        
       
        
        view.addSubview(nextButton)

        nextButton.configuration = .filled()
        nextButton.configuration?.baseBackgroundColor = .white
        nextButton.configuration?.title = "Let's start collecting"
        nextButton.configuration?.baseForegroundColor = .black
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -37),
            nextButton.widthAnchor.constraint(equalToConstant: 358),
            nextButton.heightAnchor.constraint(equalToConstant: 58),
         
            
        
        ])
    }
    
    @objc func goToNextScreen(){
        //let bc = bookmarkAppScreenController()
        
        if Post.posts.isEmpty{
            let nextScreen = SecondScreenViewController()
            nextScreen.title = "second screen"
            navigationController?.pushViewController(nextScreen, animated: true)
        } else{
            let nextScreen = bookmarkAppScreenController()
            nextScreen.title = "bookmark screen"
            navigationController?.pushViewController(nextScreen, animated: true)
        }
       
        
        
    }
    
//

}


  
