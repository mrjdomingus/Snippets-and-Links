### Retrieve methods of an object

To retrieve all methods of an object you can use this code, replacing 'object' with the object you're interested in:
```
object_methods = [method_name for method_name in dir(object) if callable(getattr(object, method_name))]
print(object_methods)
```
Also see: [https://web.archive.org/web/20180901124519/http://www.diveintopython.net/power_of_introspection/index.html](https://web.archive.org/web/20180901124519/http://www.diveintopython.net/power_of_introspection/index.html)

### Convert IPYNB-file to PY-file
`jupyter nbconvert --to script notebook.ipynb`

Also see [https://nbconvert.readthedocs.io/en/latest/usage.html](https://nbconvert.readthedocs.io/en/latest/usage.html)

### CUDA wrapper for cudf _apply_chunks_ function

A call of apply_chunks like this...
```
groups.apply_chunks(grpfunc,
  incols=['in1', 'in2'],
  outcols={'out1': np.float64, 'out2': np.float64},
  kwargs={},
  chunks=df_groups[1],
  # threads per block
  tpb=1)
```
will generate below wrapper:

```
def chunk_wise_kernel(nrows, chunks, __user_in1, __user_in2, __user_out1, __user_out2):
    blkid = cuda.blockIdx.x
    nblkid = cuda.gridDim.x
    tid = cuda.threadIdx.x
    ntid = cuda.blockDim.x
    for curblk in range(blkid, chunks.size, nblkid):
        start = chunks[curblk]
        stop = chunks[curblk + 1] if curblk + 1 < chunks.size else nrows
        inner(__user_in1[start:stop], __user_in2[start:stop], __user_out1[start:stop],
              __user_out2[start:stop])
```
where the Python function signature is:
```
def func(in1, in2, out1, out2):
```
The Python function will be called via proxy function `inner` by the wrapper.

### List of dictionaries (LD) to dictionary of lists (DL) and vice versa

Via [https://stackoverflow.com/questions/5558418/list-of-dicts-to-from-dict-of-lists](https://stackoverflow.com/questions/5558418/list-of-dicts-to-from-dict-of-lists)

Here is DL to LD:
```
v = [dict(zip(DL,t)) for t in zip(*DL.values())]
print(v)
```
and LD to DL:
```
v = {k: [dic[k] for dic in LD] for k in LD[0]}
print(v)
```
### Step into user-defined and pip-installed modules while debugging

To step into user-defined and pip-installed modules, add `"justMyCode": false` to `launch.json`.<br>
This option now supersedes `"debugStdLib": true` which superseded `"debugOptions": ["DebugStdLib"]`.

