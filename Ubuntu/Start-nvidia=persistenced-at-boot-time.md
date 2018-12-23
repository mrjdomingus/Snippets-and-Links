# Template for /etc/init/nvidia-persistenced.conf startup script

# Also see: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions

```
# NVIDIA Persistence Daemon Init Script
#
# Copyright (c) 2013 NVIDIA Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
# This is a sample Upstart init script, designed to show how the NVIDIA
# Persistence Daemon can be started.
#

description "NVIDIA Persistence Daemon"

start on runlevel [2345]
stop on runlevel [016]

env NVPD_BIN=/usr/bin/nvidia-persistenced
env NVPD_RUNTIME=/var/run/nvidia-persistenced
env NVPD_USER=__USER__

expect fork

exec $NVPD_BIN --user $NVPD_USER

post-stop script
    rm -rf $NVPD_RUNTIME
end script
```
