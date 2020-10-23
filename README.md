[![BuyMeACoffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg)](https://www.buymeacoffee.com/WojciechKulik)

## Swift-MVVMC-Demo
Sample iOS application in Swift presenting usage of MVVM-C pattern.

![](https://github.com/wojciech-kulik/Swift-MVVMC-Demo/blob/master/screenshots.png)

If you want to check out just a simple MVVM-C pattern without extra features, please see this repository: [Swift-MVVMC-SimpleExample](https://github.com/wojciech-kulik/Swift-MVVMC-SimpleExample)

## Application Features
- Sign in screen
- Dashboard with sample data fetched from mocked backend
- Onboarding displayed after login
- Settings stored locally
- Drawer menu with: dashboard, settings, sing out

## Implementation features
- Dendency Injection using `Swinject`
- Session management
- Translations fetched from backend
- UI controls with settable translations on Storyboard
- Api endpoints defined in OOP manner by subclassing `BaseApiRequest<T>`
- Logging

## Architecture
This project is POC for MVVM-C pattern where:
- View is represented by `UIViewController` designed in Storyboard
- Model represents state and domain objects
- ViewModel interacts with Model and prepares data to be displayed. View uses ViewModel's data either directly or through bindings (using RxSwift) to configure itself. View also notifies ViewModel about user actions like button tap.
- Coordinator is responsible for handling application flow, decides when and where to go based on events from ViewModel (using RxSwift bindings).

`View` <- `ViewController` <- bindings -> (`ViewModel` -> `Model`) <- bindings -> `Coordinator`


## Coordinators hierarchy
![](https://github.com/wojciech-kulik/Swift-MVVMC-Demo/blob/master/coordinators.png)

## Pros
- View doesn't contain logic, it just configures itself based on ViewModel.
- ViewModel is UIKit independent and fully testable. Thanks to communication through RxSwift it doesn't know about Coordinator nor about View.
- Views and ViewModels are reusable because they are indepdent and doesn't contain knowledge about application's flow.
- Coordinator is able to handle passing data between ViewModels.

## Cons
- Each screen requires a lot of boilerplate. You need to create Coordinator, ViewController, ViewModel and bind all together.
- RxSwift is quite tricky if you are not careful enough. It's easy to cause memory leak, that's why you have to invest more time in debugging.
- Bindings are not supported natively (unlike in Xamarin.Forms), therefore it is required to write a lot of "binding code" each time even when using RxSwift.
- RxSwift may become hard in debugging once code complexity increases.

## Compilation
Project uses [CocoaPods](https://cocoapods.org) for dependencies, so install it first and then run:

    pod install

## Application usage
Sample login screen accepts any e-mail address and password `pass`.

## References
- [MVVM + Coordinators + RxSwift based on sample iOS application with authentication](https://wojciechkulik.pl/ios/mvvm-coordinators-rxswift-and-sample-ios-application-with-authentication)
- [How to use MVVM, Coordinators, and RxSwift](https://hackernoon.com/how-to-use-mvvm-coordinators-and-rxswift-7364370b7b95)
- [Simplified MVVM-C demo](https://github.com/wojciech-kulik/Swift-MVVMC-SimpleExample)

You can also check out my another demo with Redux architecture:
- https://github.com/wojciech-kulik/ReSwiftDemo
