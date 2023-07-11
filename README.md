### AnimatedBuilder
Despite the name, AnimatedBuilder is not limited to Animations, any subtype of Listenable (such as ChangeNotifier or ValueNotifier) can be used to trigger rebuilds.

### No need to manually remove the listener before disposing the widget
```dart
    @override
    void initState() {
      super.initState();
    
      // Start listening to changes.
      myController.addListener(_printLatestValue);
    }

    @override
    void dispose() {
      // Clean up the controller when the widget is removed from the widget tree.
      // This also removes the _printLatestValue listener.
      myController.dispose();
      super.dispose();
    }
```
