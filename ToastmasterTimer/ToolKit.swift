//
//  ToolKit.swift
//  ToastmasterTimer
//
//  Created by April Yang on 2020/9/4.
//  Copyright © 2020 April Yang. All rights reserved.
//

import Foundation

func formatTimeString(second: Int) -> String {
    let isMinus = second < 0
    let absSecond = isMinus ? -second : second
    let min = absSecond / 60
    let sec = absSecond % 60
    return String(format: "%@%02d:%02d", isMinus ? "-": "", min, sec)
}
