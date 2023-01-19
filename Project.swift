import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains MorningBear App target and MorningBear unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "MorningBear",
                          platform: .iOS,
                          additionalTargets: ("MorningBearKit",
                                              "MorningBearUI",
                                              "MorningBearNetwork",
                                              "MorningBearStorage",
                                              "MorningBearImage",
                                              "MorningBearData",
                                              "MorningBearDataProvider"
                                             ))
