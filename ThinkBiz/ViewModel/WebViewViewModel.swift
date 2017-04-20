//
//  WebViewViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 19/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

class WebViewViewModel {
    
    var title: String?
    var url: String?
    
    init(withWebPage webPage: WebPage) {
        if let url = webPage.url {
            self.url = url
        }
        
        if let title = webPage.title {
            self.title = title
        }
    }
}
