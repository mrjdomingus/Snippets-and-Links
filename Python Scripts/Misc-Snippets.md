### Retrieve methods of an object

To retriev all methods of an object you can use this code, replacing 'object' with the object you're interested in:
```
object_methods = [method_name for method_name in dir(object) if callable(getattr(object, method_name))]
print(object_methods)
```
Also see: [https://web.archive.org/web/20180901124519/http://www.diveintopython.net/power_of_introspection/index.html](https://web.archive.org/web/20180901124519/http://www.diveintopython.net/power_of_introspection/index.html)

### Convert IPYNB-file to PY-file
`jupyter nbconvert --to script notebook.ipynb`

Also see [https://nbconvert.readthedocs.io/en/latest/usage.html](https://nbconvert.readthedocs.io/en/latest/usage.html)
