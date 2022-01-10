//
//  UIViewController+Context.swift
//  ProblemInMyCity
//
//  Created by Henry Bilby on 09/01/22.
//

import UIKit
import CoreData

extension UIViewController {
    var context : NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
