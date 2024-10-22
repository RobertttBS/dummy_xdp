# XDP Program Loading Instructions

This README provides instructions on how to load an XDP (eXpress Data Path) program onto a veth0 interface.

## Prerequisites

- Ensure you have the necessary permissions to run these commands (root or sudo access).
- Make sure you have the `ip` command available (usually part of the `iproute2` package).
- Ensure your kernel supports XDP and the veth0 interface exists.

## Steps to Load XDP Program

1. Compile your XDP program (assuming it's already done and the object file is named `xdp_prog.o`).

2. Use the following command to load the XDP program onto the veth0 interface:

   ```bash
   sudo ip link set dev veth0 xdp obj xdp_prog.o sec xdp
   ```

   This command does the following:
   - `sudo`: Run the command with root privileges.
   - `ip link set dev veth0`: Modify the veth0 interface.
   - `xdp obj xdp_prog.o`: Specify the XDP object file to load.
   - `sec xdp`: Specify the section in the object file that contains the XDP program.

3. Verify that the XDP program is loaded:

   ```bash
   sudo ip link show dev veth0
   ```

   Look for a line that says `xdp` in the output to confirm the program is loaded.

## Unloading the XDP Program

If you need to unload the XDP program from the interface, use this command:

```bash
sudo ip link set dev veth0 xdp off
```

## Troubleshooting

- If you encounter errors, check your kernel logs (`dmesg`) for more information.
- Ensure that your XDP program is compatible with your kernel version.
- Verify that the veth0 interface exists and is up.

Remember to replace `xdp_prog.o` with the actual name of your XDP program object file if it's different.