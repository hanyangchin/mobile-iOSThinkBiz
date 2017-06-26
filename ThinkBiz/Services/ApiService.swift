//
//  ApiService.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()

final class ApiService {
    
    // MARK: - Shared Instance
    
    static let sharedInstance: ApiService = ApiService()
    
    // MARK: - Database reference
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_IDEAS = DB_BASE.child("ideas")
    
    // Singleton
    private init() { }
    
    // MARK: - Properties
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference? {
        // Only return ref if user is logged in
        if let uid = KeychainWrapper.standard.string(forKey: KEY_UID) {
            return REF_USERS.child(uid)
        }
        return nil
    }
    
    // Reference to path /ideas/{userID}
    var REF_USER_IDEAS: FIRDatabaseReference? {
        // Only return ref if user is logged in
        if let uid = KeychainWrapper.standard.string(forKey: KEY_UID) {
            return REF_IDEAS.child(uid)
        }
        return nil
    }
    
    var REF_IDEAS: FIRDatabaseReference {
        return _REF_IDEAS
    }
    
    // MARK: - Functions
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
