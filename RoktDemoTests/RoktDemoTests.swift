//
//  RoktDemoTests.swift
//  RoktDemoTests
//
//  Copyright 2020 Rokt Pte Ltd
//
//  Licensed under the Rokt Software Development Kit (SDK) Terms of Use
//  Version 2.0 (the "License");
//
//  You may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/

import XCTest
@testable import RoktDemo

class RoktDemoTests: XCTestCase {

    func testLayoutDemoConfigLeavesCatalogItemsToTransactions() throws {
        let viewModel = LayoutDemoViewModel()
        viewModel.preview = PreviewData(
            tagId: "343",
            previewId: "layout-1",
            versionId: "version-1",
            creativeIds: ["creative-1", "creative-2"],
            layoutVariantIds: ["variant-1"],
            language: "en"
        )

        let attributes = viewModel.getAttributes()
        let demoConfig = try XCTUnwrap(attributes["demo_config"])
        let data = try XCTUnwrap(demoConfig.data(using: .utf8))
        let object = try XCTUnwrap(
            JSONSerialization.jsonObject(with: data) as? [String: Any]
        )
        let layouts = try XCTUnwrap(object["layouts"] as? [[String: Any]])
        let layout = try XCTUnwrap(layouts.first)
        let slots = try XCTUnwrap(layout["slots"] as? [[String: Any]])

        XCTAssertEqual(slots.count, 2)
        XCTAssertEqual(slots[0]["layout_variant_id"] as? String, "variant-1")
        XCTAssertEqual(slots[0]["creative_id"] as? String, "creative-1")
        XCTAssertEqual(slots[1]["layout_variant_id"] as? String, "variant-1")
        XCTAssertEqual(slots[1]["creative_id"] as? String, "creative-2")
        XCTAssertTrue(slots.allSatisfy { $0["catalog_items"] == nil })
    }

}
