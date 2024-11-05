# IEEE Verilog Tutorial
TTU Spring 2024 IEEE Verilog Tutorial hosted by Zachary Bonneau
Covers combinational and sequential logic design in verilog using icarus Verilog/Visual Studio Code and Xilinx Vivado

## Visual Studio Code Extensions used
**Name: Verilog-HDL/SystemVerilog/Bluespec SystemVerilog**
Id: mshr-h.veriloghdl
Description: Verilog-HDL/SystemVerilog/Bluespec SystemVerilog support for VS Code
Version: 1.13.2
Publisher: Masahiro Hiramori
VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=mshr-h.VerilogHDL

**Name: Verilog Testbench Runner**
Id: theonekevin.icarusext
Description: Simple solution to run testbench files, includes GTKWave support.
Version: 1.0.3
Publisher: Kevin Dai
VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=theonekevin.icarusext

**Name: WaveTrace**
Id: wavetrace.wavetrace
Description: Interactive VCD waveform viewer for FPGA/RTL developers
Version: 1.1.2
Publisher: wavetrace
VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=wavetrace.wavetrace

Note: Wavetrace basic limits view to 8 signals. Unlimited signal count available with one-time $15 purchase. Good for 2-transferable license keys. Not affiliated with WaveTrace, I just think it is worth it

## Icarus Verilog
If you decide to be efficient with your coding experience and use VS Code, install icarus verilog and add to PATH
Link: https://bleyer.org/icarus/

## A Note on the Display module
The default xdc file has "seg[n]" for the 7 cathodes on the display. This order is:
    seg[0]: a
    ...
    seg[6]: g
The display module has these bits flipped in the submodule "segmentDriver"
    seg[0]: g
    ...
    seg[6]: a
Here are two solutions to this reversed order:
    1. Flip all of the bits in the module "segmentDriver"
    2. Flip the bits in the xdc file
        {seg[0]} -> {seg[6]} ...
    3. There are other ways of solving this problem. I'll let you find them