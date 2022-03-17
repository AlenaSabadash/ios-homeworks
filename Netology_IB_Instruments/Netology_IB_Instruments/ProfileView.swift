//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Alena Sabadash on 27.02.2022.
//  Copyright © 2022 Alena Sabadash. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var city: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "ProfileView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        avatar.image = UIImage(named: "catAvatar")
        name.text = "Эшли"
        dateOfBirth.text = "13-08-2015"
        city.text = "Тюмень"
    }

}
