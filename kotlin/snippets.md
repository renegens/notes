### Null Safety Explained
[https://www.raywenderlich.com/436090-null-safety-tutorial-in-kotlin-best-practices](https://www.raywenderlich.com/436090-null-safety-tutorial-in-kotlin-best-practices)

### Run for object execution
```
onStackChangeListener?.run {
  invoke(files)
  println("pushing, calling " + toString())
}
```

### Match a list based on the items in another list and tranform it. Replace the hashcode with the unique identifier
```
fun <T, E> List<T>.matchTo(list: List<E>): List<E> =
    this.flatMap { item -> list.filter { listItem -> (item.hashCode() == listItem.hashCode()) } }
}
```
### Replace an item in a list
```
fun <E> Iterable<E>.replace(old: E, new: E) = map { if (it == old) new else it }
```
### varargs
[https://proandroiddev.com/kotlins-vararg-and-spread-operator-4200c07d65e1?fbclid=IwAR3X04cokkZQoufzt-M16GC2KnIrTHS3vrgl82fCv2bXQVOGtmdG26fTZIg](https://proandroiddev.com/kotlins-vararg-and-spread-operator-4200c07d65e1?fbclid=IwAR3X04cokkZQoufzt-M16GC2KnIrTHS3vrgl82fCv2bXQVOGtmdG26fTZIg)
### Coroutines Explained
[https://geoffreymetais.github.io/code/coroutines/](https://geoffreymetais.github.io/code/coroutines/)

### Wrapping callbacks with coroutines
[https://jacquessmuts.github.io/post/callback_hell/](https://jacquessmuts.github.io/post/callback_hell/)


### Property Delagates for shared logic
[https://proandroiddev.com/kotlin-delegates-in-android-1ab0a715762d](https://proandroiddev.com/kotlin-delegates-in-android-1ab0a715762d)