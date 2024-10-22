LLC ?= llc
CLANG ?= clang

BPF_CFLAGS ?= -I/usr/include/x86_64-linux-gnu

xdp_pass.o: xdp_pass.c
	$(CLANG) -S \
		-target bpf \
		-D __BPF_TRACING__ \
		$(BPF_CFLAGS) \
		-Wall \
		-Wno-unused-value \
		-Wno-pointer-sign \
		-Wno-compare-distinct-pointer-types \
		-Werror \
		-O2 -emit-llvm -c -g -o ${@:.o=.ll} $<
	$(LLC) -march=bpf -filetype=obj -o $@ ${@:.o=.ll}

load: xdp_pass.o
	sudo ip link set dev veth0 xdp obj xdp_pass.o sec xdp

unload:
	sudo ip link set dev veth0 xdp off

.PHONY: load unload