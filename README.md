## SPInteractivePopTransition

SPInteractivePopTransition is an interactive transition for navigation controllers which tries to mimic the default behavior of iOS 7.

## Why?

On iOS 7, if you want a custom back button for your navigation controller, you must forget about the nice and out-of-the-box interactive gesture to pop the current view controller. There is a workaround to fix this:

```objective-c
self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
```

However, this may lead to some weird behavior of your app, including glitches and random crashes.

Therefore, the only way I found to preserve the original behavior while having custom back buttons is [writing your own transition](http://www.objc.io/issue-5/view-controller-transitions.html).

## Features

- Works with custom back buttons.
- Works with navigation bar title text custom attributes.
- Transitions properly between view controllers with the navigation bar visible and invisible.

## Limitations

- It requires that you apply some attributes to the navigation bar title text.
- It doesn't work with custom title views (yet…).

## Install SPInteractivePopTransition

1. **Using CocoaPods**

  Add SPInteractivePopTransition to your Podfile:

  ```
  platform :ios, "7.0"
  pod 'SPInteractivePopTransition'
  ```

  Run the following command:

  ```
  pod install
  ```

2. **Static Library**

    Clone the project or add it as a submodule. Drag *SPInteractivePopTransition.xcodeproj* to your project, add it as a target dependency and link *libSPInteractivePopTransition.a*.
    Then, you can simply do:

    ```
    #import <SPInteractivePopTransition/SPInteractivePopTransition.h>
    ```

3. **Manually**

  Clone the project or add it as a submodule. Drag the whole SPInteractivePopTransition folder to your project.

## Usage of SPInteractivePopTransition

In order to integrate SPInteractivePopTransition in your app you only have to wire SPPopAnimationController and SPHorizontalSwipeInteractionController with your navigation controller and view controllers.

An example of this wiring can be found in the class SPInteractivePopNavigationController, which can also be inherited or used directly in your app as any other UINavigationController instance.

## Contact

SPInteractivePopTransition was created by Sergio Padrino: [@sergiou87](https://twitter.com/sergiou87).

## Contributing

If you want to contribute to the project just follow this steps:

1. Fork the repository.
2. Clone your fork to your local machine.
3. Create your feature branch.
4. Commit your changes, push to your fork and submit a pull request.

## Apps using SPInteractivePopTransition

* [Fever](https://itunes.apple.com/us/app/fever-event-discovery-app/id497702817?mt=8)

## License

SPInteractivePopTransition is available under the MIT license. See the [LICENSE file](https://github.com/sergiou87/SPInteractivePopTransition/blob/master/LICENSE) for more info.
