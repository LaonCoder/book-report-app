import ProjectDescription

let project = Project(
    name: "BookReportApp",
    targets: [
        .target(
            name: "BookReportApp",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.BookReportApp",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["BookReportApp/Sources/**"],
            resources: ["BookReportApp/Resources/**"],
            dependencies: []
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
