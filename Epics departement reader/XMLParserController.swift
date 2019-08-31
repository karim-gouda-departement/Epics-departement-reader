
import UIKit

class XMLParserController: NSObject, XMLParserDelegate {
    var parser: XMLParser!
    var currentPost: Post!
    var posts: [Post] = []
    var currentTagParsed = ""
    var isParsingItem = false

    init(url: URL) {
        super.init()
        self.parser = XMLParser.init(contentsOf: url)!
        self.parser.delegate = self
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "item" {
            self.isParsingItem = true
            return
        }
        if self.isParsingItem == true {
            if elementName == "title" || elementName == "link" {
                self.currentTagParsed = elementName
            }
        }

    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentTagParsed {
        case "title":
            self.currentPost.titolo += string
            
        case "link":
            self.currentPost.link += string
            
        default:
            return
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentTagParsed = ""
        if elementName == "item" {
            self.isParsingItem = false
            print("aggiungo: \(self.currentPost.titolo)")
            self.posts.append(currentPost)
            self.currentPost = Post.init()
        }
    }

}
