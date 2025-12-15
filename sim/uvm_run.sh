#!/bin/bash

rm -rf xcelium.d waves.shm xrun.log xrun.history

xrun -64bit -uvm \
     -f filelist.f \
     -access +rwc \
     +UVM_VERBOSITY=UVM_LOW \
     -licqueue

