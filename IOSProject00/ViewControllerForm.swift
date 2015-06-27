//
//  ViewControllerForm.swift
//  IOSProject00
//
//  Created by internet on 5/21/15.
//  Copyright (c) 2015 internet. All rights reserved.
//

import UIKit
import CoreData


class ViewControllerForm: UIViewController {

    @IBOutlet weak var TxtNombre: UITextField!
    @IBOutlet weak var TxtDireccion: UITextField!
    @IBOutlet weak var TxtPedido: UITextField!
    @IBOutlet weak var TxtDetalle: UITextView!
   
    
    
    @IBAction func BtnRegistrarPedido(sender: AnyObject) {
        //Guardar datos
        if(!TxtNombre.text.isEmpty){
            
            var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            
            
            let ent = NSEntityDescription.entityForName("Pedidos", inManagedObjectContext: context)!
            
            //Instance of our custom class, reference to entity
            var newData = ManageDataBase(entity: ent, insertIntoManagedObjectContext: context)
            
            //Fill in the Core Data
            
            newData.nombre = TxtNombre.text
            newData.direccion = TxtDireccion.text
            newData.pedido = TxtPedido.text
            newData.pedido = TxtDetalle.text
            
            let dateFormatter = NSDateFormatter()
            var curLocale: NSLocale = NSLocale.currentLocale()
            var formatString: NSString = NSDateFormatter.dateFormatFromTemplate("EdMMM h:mm a", options: 0, locale: curLocale)!
            dateFormatter.dateFormat = formatString as String
            newData.fecha = dateFormatter.stringFromDate(NSDate())
            
            context.save(nil)
            TxtNombre.text = ""
            TxtDireccion.text = ""
            TxtPedido.text = ""
            TxtDetalle.text = "Siagard = , Malarata = , Beccon = , FertiFol = , Cucaxan = "
            
            
            println(newData)
            println(NSDate())
            
        }else{
            //Datos en blanco
            var alert:UIAlertController = UIAlertController(title: "Datos en blanco", message: "Es necesario ingresar los datos del pedido.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(result)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
}
