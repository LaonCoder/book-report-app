import ProjectDescription

let project = Project(
    name: "BookReportApp",
    targets: [
        .target(
            name: "BookReportApp",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.BookReportApp",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["BookReportApp/Sources/**"],
            resources: ["BookReportApp/Resources/**"],
            dependencies: [
                .external(name: "Alamofire", condition: .none),
                .external(name: "Realm", condition: .none),
                .external(name: "RealmSwift", condition: .none)
            ]
        ),
        .target(
            name: "BookReportSampleApp",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.BookReportSampleApp",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["BookReportApp/Sources/**"],
            resources: ["BookReportApp/Resources/**"],
            dependencies: [
                .external(name: "Alamofire", condition: .none),
                .external(name: "Realm", condition: .none),
                .external(name: "RealmSwift", condition: .none)
            ]
        ),
        .target(
            name: "BookReportAppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.BookReportAppTests",
            infoPlist: .default,
            sources: ["BookReportApp/Tests/**"],
            resources: [],
            dependencies: [.target(name: "BookReportApp")]
        ),
    ]
)
