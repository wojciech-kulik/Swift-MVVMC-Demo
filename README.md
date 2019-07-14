## Swift-MVVMC-Demo
Sample iOS application in Swift presenting usage of MVVM-C pattern.

![](https://github.com/wojciech-kulik/Swift-MVVMC-Demo/blob/master/screenshots.png)

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
Project uses [Carthage](https://github.com/Carthage/Carthagehttp:// "Carthage") for dependencies, so install it first and then run:

    carthage update --platform iOS --no-use-binaries

## Application usage
Sample login screen accepts any e-mail address and password `pass`.

## References
Read more about MVVM-C: 
- [How to use MVVM, Coordinators, and RxSwift](https://hackernoon.com/how-to-use-mvvm-coordinators-and-rxswift-7364370b7b95)

You can also check out my another demo with Redux architecture:
- https://github.com/wojciech-kulik/ReSwiftDemo
