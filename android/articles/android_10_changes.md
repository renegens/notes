# Get Ready for Android Q status bar and navigation bar

### Read this about windows 
[https://medium.com/androiddevelopers/windowinsets-listeners-to-layouts-8f9ccc8fa4d1](https://medium.com/androiddevelopers/windowinsets-listeners-to-layouts-8f9ccc8fa4d1)

[https://proandroiddev.com/draw-under-status-bar-like-a-pro-db38cfff2870](https://proandroiddev.com/draw-under-status-bar-like-a-pro-db38cfff2870)

### You will need this in fragments
[https://medium.com/androiddevelopers/windows-insets-fragment-transitions-9024b239a436](https://medium.com/androiddevelopers/windows-insets-fragment-transitions-9024b239a436)

[https://www.youtube.com/watch?v=_mGDMVRO3iE&t=1451s](https://www.youtube.com/watch?v=_mGDMVRO3iE&t=1451s)

### Add inside your activity to draw behind the system navigation and status
```kotlin
window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
```
### Dark Theme Guide
[https://medium.com/q42-engineering/android-dark-theme-b4d695f78c4f](https://medium.com/q42-engineering/android-dark-theme-b4d695f78c4f)

[https://proandroiddev.com/android-dark-theme-implementation-recap-4fcffb0c4bff](https://proandroiddev.com/android-dark-theme-implementation-recap-4fcffb0c4bff)

[https://medium.com/snapp-mobile/design-for-the-dark-theme-9a2185bbb1d5](https://medium.com/snapp-mobile/design-for-the-dark-theme-9a2185bbb1d5)

[https://arturdryomov.online/posts/midnight-in-android-themes/](https://arturdryomov.online/posts/midnight-in-android-themes/)

### Add inside your style
```xml
<item name="android:navigationBarColor">@android:color/transparent</item>
<item name="android:statusBarColor">@android:color/transparent</item>
```

### If you need to make it semi transparent use this
```xml
<color name="black_transparent">#99000000</color>
```

### Change color of Status bar icons, add in your styles
```xml
<item name="android:windowLightStatusBar">true</item>
```

### Navigation
[https://medium.com/androiddevelopers/gesture-navigation-going-edge-to-edge-812f62e4e83e](https://medium.com/androiddevelopers/gesture-navigation-going-edge-to-edge-812f62e4e83e)

### Apply windows insets for status bar if needed
```kotlin
fun View.applyWindowsInsets() {
    ViewCompat.setOnApplyWindowInsetsListener(this) { v, insets ->
        val params = v.layoutParams as ViewGroup.MarginLayoutParams
        params.topMargin = insets.systemWindowInsetTop
        insets.consumeSystemWindowInsets()
    }
}
```

