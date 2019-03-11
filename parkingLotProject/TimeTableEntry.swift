//
//  TimeTableEntry.swift
//  parkingLotProject
//
//  Created by Phanuvich Hirunsirisombut on 17/12/2560 BE.
//  Copyright © 2560 Phanuvich Hirunsirisombut. All rights reserved.
//

import UIKit

class TimeTableEntry: NSObject {
    var id: String?
    var endTime: String?
    init(ids:String? , endTime:String?) {
        self.endTime = endTime
        self.id = ids
     
    }
}
