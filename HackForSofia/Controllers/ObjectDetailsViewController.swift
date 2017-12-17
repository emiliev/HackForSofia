//
//  ObjectDetailsViewController.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/16/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import UIKit
import FirebaseAuth
import WebKit

class ObjectDetailsViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var webViewKit: WKWebView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var object: Object? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        
        let request = URLRequest(url: URL(string: "https://www.youtube.com/watch?v=DtQc06L7Z4M")!)
        webViewKit.load(request)
        descriptionLabel.text = "FMI{Codes} е хакатонът, който се провежда във Факултета по Математика и Информатика на Софийски университет. Участието е отворено за студенти от цялата страна и е напълно безплатно. Състезанието е отборно като всяко издание има своя тема, по която отборът разработва своя проект. Тази година темата е “Code for Sofia”. Ние от ФСС при ФМИ искаме да дадем поле за изява на всички, които имат идея как да подобрят заобикалящата ни среда. Иновации. Образование. Култура. Екология. Достъпност. Транспорт. Качеството на живот. Ти избираш в коя насока да бъде твоят проект!"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func manageObject(){
        guard let unwarpedObj = object else { return }
    
        self.descriptionLabel.text = unwarpedObj.desc
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
