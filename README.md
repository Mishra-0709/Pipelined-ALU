# 🔧 Custom ALU with Pipelining – Verilog RTL Design

##  Project Overview

This project implements a **custom Arithmetic Logic Unit (ALU)** with a **4-stage pipeline architecture** using **Verilog**.  
The ALU supports basic arithmetic and logical operations and is structured into classic pipeline stages:  
**Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), and Writeback (WB).**

Simulation is performed using **EDA Playground**, and waveforms are analyzed using **EPWave**.

---

##  Features

- 4-stage pipeline: IF, ID, EX, WB  
- ALU operations: `ADD`, `SUB`, `AND`, `OR`  
- Instruction format: `{opcode[1:0], src1[7:0], src2[7:0]}`  
- Pipeline registers: `IF_ID`, `ID_EX`, `EX_WB`  
- Verified using waveform output

---

##  File Structure

| File                 | Description                                |
|----------------------|--------------------------------------------|
| `alu_pipeline.v`     | RTL design of pipelined ALU                |
| `tb_alu_pipeline.v`  | Verilog testbench with waveform dumping    |
| `dump.vcd`           | VCD waveform file (generated after sim)    |

---

##  Pipeline Description

1. **IF (Instruction Fetch)** – Fetches instruction from instruction memory  
2. **ID (Instruction Decode)** – Extracts opcode and operands  
3. **EX (Execute)** – Performs ALU operation  
4. **WB (Writeback)** – Stores result in output register

---

##  Simulation Waveform

> Example waveform from EPWave:

![image](https://github.com/user-attachments/assets/2610f34a-fdbd-4473-a85d-108423a3ac02)


###  Signal Descriptions

| Signal      | Description                        |
|-------------|------------------------------------|
| `clk`       | System clock                       |
| `reset`     | Active-high synchronous reset      |
| `pc`        | Program counter                    |
| `IF_ID`     | IF to ID pipeline register         |
| `ID_EX`     | ID to EX pipeline register         |
| `alu_out`   | ALU computation result             |
| `result`    | Final output at WB stage           |
| `src1`, `src2` | Source operands                 |
| `opcode`    | Operation code for ALU             |

---

###  Waveform Observations

- At ~15ns: First instruction (`ADD 10 + 5`) is executed → `result = 15`
- Subsequent instructions (`SUB`, `AND`, `OR`) pass through the pipeline
- `result` updates every clock after initial pipeline delay (indicating correct pipelining)

---

##  ALU Operation Table

| Opcode | Binary   | Operation | Description        |
|--------|----------|-----------|--------------------|
| `00`   | `2'b00`  | `ADD`     | Add src1 and src2  |
| `01`   | `2'b01`  | `SUB`     | Subtract src2 from src1 |
| `10`   | `2'b10`  | `AND`     | Bitwise AND        |
| `11`   | `2'b11`  | `OR`      | Bitwise OR         |

---

##  How to Simulate

You can run the design on [EDA Playground](https://edaplayground.com):

1. Copy `alu_pipeline.v` to the design window  
2. Copy `tb_alu_pipeline.v` to the testbench window  
3. Select **Icarus Verilog** or **Synopsys VCS** as the simulator  
4. Run the simulation and view waveforms in **EPWave**

Ensure these lines are in the testbench:

```verilog
$dumpfile("dump.vcd");
$dumpvars(0, tb_alu_pipeline);
