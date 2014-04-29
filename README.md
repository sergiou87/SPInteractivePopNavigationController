## SPInteractivePopNavigationController

SPInteractivePopNavigationController is navigation controller with an interactive transition which tries to mimic the default behavior of iOS 7.

![SPInteractivePopNavigationController example](https://raw.github.com/sergiou87/SPInteractivePopNavigationController/master/Example/InteractivePop.gif)

## Why?

On iOS 7, if you want a custom back button for your navigation controller, you must forget about the nice and out-of-the-box interactive gesture to pop the current view controller. There is a workaround to circumvent this:

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

## Install SPInteractivePopNavigationController

1. **Using CocoaPods**

  Add SPInteractivePopNavigationController to your Podfile:

  ```ruby
  platform :ios, "7.0"
  pod 'SPInteractivePopNavigationController'
  ```

  Run the following command:

  ```
  pod install
  ```

2. **Manually**

  Clone the project or add it as a submodule. Drag the whole SPInteractivePopNavigationController folder to your project.
  
  Then, you can simply do:

    ```objective-c
    #import "SPInteractivePopNavigationController.h"
    ```

## Usage of SPInteractivePopNavigationController

### The easy way

Just use the **SPInteractivePopNavigationController** (directly or inheriting it) as your navigation controller:

```objective-c
SPMyViewController *myViewController = [[SPMyViewController alloc] init];

SPInteractivePopNavigationController *navigationController = [[SPInteractivePopNavigationController alloc] initWithRootViewController:myViewController];
```

### The flexible way

You don't want to use SPInteractivePopNavigationController in your code? Don't worry, it's still easy: just wire **SPPopAnimationController** and **SPHorizontalSwipeInteractionController** with your navigation controller and view controllers. An example of this wiring can be found in the class **SPInteractivePopNavigationController**.

## Contact

SPInteractivePopNavigationController was created by Sergio Padrino: [@sergiou87](https://twitter.com/sergiou87), based on [VCTransitionsLibrary](https://github.com/ColinEberhardt/VCTransitionsLibrary).

## Contributing

If you want to contribute to the project just follow this steps:

1. Fork the repository.
2. Clone your fork to your local machine.
3. Create your feature branch.
4. Commit your changes, push to your fork and submit a pull request.

## Apps using SPInteractivePopNavigationController

* [Fever](https://itunes.apple.com/us/app/fever-event-discovery-app/id497702817?mt=8)

## License

SPInteractivePopNavigationController is available under the MIT license. See the [LICENSE file](https://github.com/sergiou87/SPInteractivePopNavigationController/blob/master/LICENSE) for more info.
