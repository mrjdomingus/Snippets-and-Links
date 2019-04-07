### Retrieve methods of an object

To retriev all methods of an object you can use this code, replacing 'object' with the object you're interested in:
```
object_methods = [method_name for method_name in dir(object) if callable(getattr(object, method_name))]
print(object_methods)
```
Also see: [https://web.archive.org/web/20180901124519/http://www.diveintopython.net/power_of_introspection/index.html](https://web.archive.org/web/20180901124519/http://www.diveintopython.net/power_of_introspection/index.html)
