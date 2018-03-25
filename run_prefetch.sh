#!/bin/bash

## Modify the following paths appropriately
PARSEC_PATH="/home/dinos/Desktop/AdvCompArc/parsec-3.0"
PIN_EXE="/home/dinos/Desktop/AdvCompArc/pin-3.6-97554-g31f0a167d-gcc-linux/pin"
PIN_TOOL="/home/dinos/Desktop/AdvCompArc/advcomparch-2017-18-ex1-helpcode/pintool/obj-intel64/simulator.so"

CMDS_FILE=/home/dinos/Desktop/AdvCompArc/advcomparch-2017-18-ex1-helpcode/cmds_simlarge.txt
outDir="./outputs_prefetch/"

if [ ! -d "$outDir" ]; then
	echo "output directory does not exists. Creating..."
	mkdir -p $outDir
fi

export LD_LIBRARY_PATH=$PARSEC_PATH/pkgs/libs/hooks/inst/amd64-linux.gcc-serial/lib/

## Values for number of blocks to prefetch
CONFS="1 2 4 8 16 32 64"

L1size=32
L1assoc=8
L1bsize=64
L2size=1024
L2assoc=8
L2bsize=128
TLBe=64
TLBp=4096
TLBa=4

for BENCH in $@; do
	cmd=$(cat ${CMDS_FILE} | grep "$BENCH")
for L2prf in $CONFS; do
	outFile=$(printf "%s.prefetch_cslab_%02d.out" $BENCH ${L2prf})
	outFile="$outDir/$outFile"

	pin_cmd="$PIN_EXE -t $PIN_TOOL -o $outFile -L1c ${L1size} -L1a ${L1assoc} -L1b ${L1bsize} -L2c ${L2size} -L2a ${L2assoc} -L2b ${L2bsize} -TLBe ${TLBe} -TLBp ${TLBp} -TLBa ${TLBa} -L2prf ${L2prf} -- $cmd"
	time $pin_cmd
done
done
