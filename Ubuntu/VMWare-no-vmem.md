Prevent creation of vmmem files in VmWare

## Issue

VMWare creates `.vmem` files to back the guest RAM. On the host this causes disk thrashing especially during powering on and off the guest.

## Solution

Add the following lines to the `.vmx` file to prevent creation of `.vmem` files. This will reduce disk IO and VM performance will improve especially on non-SSD disks.

```
prefvmx.minVmMemPct = "100"
MemTrimRate = "0"
mainMem.useNamedFile = "FALSE"
sched.mem.pshare.enable = "FALSE"
prefvmx.useRecommendedLockedMemSize = "TRUE"
```

### References

- http://faq.sanbarrow.com/index.php?action=artikel&cat=14&id=50&artlang=en
- http://www.sanbarrow.com/vmx/vmx-config-ini.html
- https://superuser.com/questions/306655/windows-7-kills-vmware-performance-by-disk-caching
- https://gist.github.com/wpivotto/3993502
- https://communities.vmware.com/thread/205396
- https://communities.vmware.com/thread/462098
- https://communities.vmware.com/thread/510562
- https://communities.vmware.com/thread/564465
