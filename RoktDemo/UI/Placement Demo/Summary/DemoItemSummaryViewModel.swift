//
//  DemoItemSummaryViewModel.swift
//  RoktDemo
//
//  Copyright 2020 Rokt Pte Ltd
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import Foundation
import Rokt_Widget

class DemoItemSummaryViewModel: ObservableObject {
    @Published var summaryModel: DemoItemSummaryModel
    var model: DemoItemModel
    init(_ model: DemoItemModel) {
        self.summaryModel =
        DemoItemSummaryModel(title: model.title,
                             longDescription: model.longDescription,
                             iconURL: model.iconURL,
                             disclaimerMessage: DemoItemSummaryViewModel.getDisclaimerMessage(model),
                             descriptions: DemoItemSummaryViewModel.getDescriptions(model))
        self.model = model
    }
    
    func initializeRokt() {
        if let tagID = getTagId() {
            Rokt.initWith(roktTagId: tagID)
        }
    }
    
    func getTagId() -> String? {
        if let model = model as? DefaultPlacementExamplesModel {
            return model.tagID
        } else if let model = model as? PreDefinedScreenModel {
            return model.tagID
        }
        return nil
    }
    
    class func getDisclaimerMessage (_ model: DemoItemModel) -> String {
        if model as? DefaultPlacementExamplesModel != nil {
            return AlertView.template2
        }
        return AlertView.template1
    }
    
    class func getDescriptions(_ model: DemoItemModel) -> [DescriptionItem] {
        if let preDefinedScreen = model as? PreDefinedScreenModel {
            return preDefinedScreen.descriptions
        }
        return []
    }
}

struct DemoItemSummaryModel {
    let title: String
    let longDescription: String?
    let iconURL: String
    let disclaimerMessage: String
    let descriptions: [DescriptionItem]
}
