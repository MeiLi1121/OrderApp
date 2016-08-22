//
//  OAHelpers.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/21/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import Foundation

func titleTextForStyle(style: OAHomeHoursViewStyle) -> String {
  switch style {
  case .OAHomeHoursViewStyleDineIn:
    return "DINE-IN HOURS";
  case .OAHomeHoursViewStyleDelivery:
    return "DELIVERY HOURS";
  }
}

func timeTextsForStyle(style: OAHomeHoursViewStyle) -> [String] {
  switch style {
  case .OAHomeHoursViewStyleDineIn:
    return ["11:00AM - 9:00PM", "10:30AM - 9:00PM", "Closed", "10:30AM - 9:00PM", "10:30AM - 9:00PM", "10:30AM - 9:30PM", "10:30AM - 9:30PM", ];
  case .OAHomeHoursViewStyleDelivery:
    return ["7:00PM - 8:30PM", "7:00PM - 8:30PM", "Closed", "7:00PM - 8:30PM", "7:00PM - 8:30PM", "7:00PM - 8:30PM", "7:00PM - 8:30PM", ];
  }
}


