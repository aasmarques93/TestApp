## TestApp

#Brief Description
The purpose of this app is to share movies and TV shows information to make you aware of what's is happening at the theaters world.

#API
TheMovieDB api is the provider of TestApp content data, https://developers.themoviedb.org. 

#Code
The app was made with Swift 4 and followed the Apple guide lines best practices. 
It was used MVVM as design/architectural pattern, which makes the app clean and improved testability, better separation of concerns and transparent communication.
All classes implemented, except third party content, passed through Test Cases and UI Test Cases.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

# Prerequisites

* Have cocoapods installed on your machine
* Run and install cocoapods via terminal: 
  - $ cd /{your-project-directory-path}
  - $ pod install
* Open the .workspace file at a version of xcode that runs Swift 4.

## Third-party

Moya was used for all REST API calls.

SwiftyJSON is a Mac application which can generate Models classes for swift latest version from a JSON raw data. This API was introduced to the project to controls of model objects handle.

Bond was the responsible for data binding and made possible the use MVVM as architecture.

RAMAnimatedTabBarController was used for creating a interactive animation to tab bar item.

SDWebImage helps to handle presented images at screen.

FCAlertView custom alerts.

NVActivityIndicatorView shows a huge kind of activity indicator animations.

CollectionViewSlantedLayout allows the display of slanted cells in a UICollectionView.

ViewAnimator used for UIView animations.

CRRefresh used for pull-to-refresh with a customized UI style.

iCarousel is the component view that makes the carousel animations.

## Author

* Arthur Augusto Sousa Marques**

