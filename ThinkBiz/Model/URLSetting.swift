//
//  URLSetting.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 16/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

class URLSetting: Setting {
    
    var url: String!
    
    required init(name: String, url: String) {
        super.init(name: name)
        
        self.url = url
    }
}
