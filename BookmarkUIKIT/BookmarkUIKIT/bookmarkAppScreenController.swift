//
//  bookmarkAppScreenController.swift
//  BookmarkUIKIT
//
//  Created by Abylay Duzel on 03.05.2023.
//

import UIKit
import WebKit


struct Post {
    var title: String
    var link: String
   
}

extension Post {
    static var posts = [Post]()
}


class bookmarkAppScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource, WKUIDelegate{
    let addBookmarkButtonSecond = UIButton()
    var myIndex:Int = 0
    var closeWebViewBool = false
    let closeWebViewButton = UIButton()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    var webView: WKWebView!
   
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "List"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationButtonAppScreenSecond()
       
        
        view.backgroundColor = .white
        initializeList()
        
        NSLayoutConstraint.activate ([
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
           
        ])
        
   
    }
    
    
    
    
    
    
    
    
  
    
    func navigationButtonAppScreenSecond(){

        view.addSubview(addBookmarkButtonSecond)

        addBookmarkButtonSecond.configuration = .filled()
        addBookmarkButtonSecond.configuration?.baseBackgroundColor = .black
        addBookmarkButtonSecond.configuration?.title = "Let's start collecting"
        addBookmarkButtonSecond.configuration?.baseForegroundColor = .white
        addBookmarkButtonSecond.translatesAutoresizingMaskIntoConstraints = false
        addBookmarkButtonSecond.addTarget(self, action: #selector(secondAlertBar), for: .touchUpInside)

        addBookmarkButtonSecond.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate ([

            addBookmarkButtonSecond.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBookmarkButtonSecond.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -37),
            addBookmarkButtonSecond.widthAnchor.constraint(equalToConstant: 358),
            addBookmarkButtonSecond.heightAnchor.constraint(equalToConstant: 58),

        ])
    }

    @objc func secondAlertBar(){
        
        
 
        let alertController = UIAlertController(title: "Change", message:nil, preferredStyle:.alert)
        alertController.addTextField()
        alertController.addTextField()

        alertController.textFields![0].placeholder = "Name"
        alertController.textFields![1].placeholder = "link"

        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in

                Post.posts.append(Post(title:alertController.textFields![0].text!, link: alertController.textFields![1].text!))

                self.initializeList()
                self.tableView.reloadData()



        }))


        self.present(alertController, animated: true, completion: nil)


    }
    
    func initializeList(){
       
     
        self.tableView.setDimensions(height: 300)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        self.tableView.fillView(self.view)
        
       
        self.tableView.register(PostCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Post.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostCell else { return UITableViewCell() }
        cell.configureView(post: Post.posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         myIndex = indexPath.row
        
        tableView.isHidden = true
        addBookmarkButtonSecond.isHidden = true
        
        
        closeWebViewButtonFunc()
        let myURL = URL(string:"\(Post.posts[myIndex].link)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        
        
    }
    func closeWebViewButtonFunc(){
        
        closeWebViewButton.configuration = .filled()
        closeWebViewButton.configuration?.baseBackgroundColor = .black
        closeWebViewButton.configuration?.title = "Close Webview"
        
        closeWebViewButton.configuration?.baseForegroundColor = .white
      
        addBookmarkButtonSecond.translatesAutoresizingMaskIntoConstraints = false
        addBookmarkButtonSecond.addTarget(self, action: #selector(toggleBtn), for: .touchUpInside)
        
        addBookmarkButtonSecond.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            
            addBookmarkButtonSecond.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBookmarkButtonSecond.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -37),
            addBookmarkButtonSecond.widthAnchor.constraint(equalToConstant: 358),
            addBookmarkButtonSecond.heightAnchor.constraint(equalToConstant: 58),
         
        ])
    }
    
    @objc func toggleBtn(){
        tableView.isHidden = false
        
        addBookmarkButtonSecond.isHidden = false
        webView.isHidden = true
        closeWebViewButton.isHidden = true
    }
    
    
}
class PostCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
   
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configureView(post: Post) {
        self.nameLabel.text = post.title

        
  
    }

    public func setUI() {
       

        [nameLabel].forEach { self.addSubview($0) }

        nameLabel.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 12, paddingLeft: 16)
        
 
        }
}
