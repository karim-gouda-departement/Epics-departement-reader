
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parserController.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let currentPost = self.parserController.posts[indexPath.row]
        
        cell.textLabel?.text = currentPost.titolo
        cell.detailTextLabel?.text = currentPost.link
        
        return cell

    }
    
    @IBOutlet var tableView: UITableView!
    let parserController = XMLParserController.init(url: URL.init(string: "https://applenewsroom.home.blog/feed/")!)

    override func viewDidLoad() {
        super.viewDidLoad()
tableView.dataSource = self
tableView.delegate = self
        let risultato = self.parserController.parser.parse()
        
        if risultato == true {
            self.tableView.reloadData()
        }

    }

}

