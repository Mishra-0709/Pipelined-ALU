Custom ALU with Pipelining – Verilog RTL Design
🧠 Project Overview
This project implements a custom Arithmetic Logic Unit (ALU) with a 4-stage pipeline architecture using Verilog. The ALU supports basic arithmetic and logical operations and is structured into classic pipeline stages: Fetch, Decode, Execute, and Writeback.

The design was simulated using EDA Playground with signal waveform output enabled via .vcd dump. The functionality was verified by monitoring the internal pipeline registers and the final output.

🔧 Features
✅ 4-stage pipeline: IF, ID, EX, WB

✅ ALU operations: ADD, SUB, AND, OR

✅ Simple instruction format: {opcode[1:0], src1[7:0], src2[7:0]}

✅ Pipeline registers: IF_ID, ID_EX, EX_WB

✅ Verified with waveform analysis using EPWave

📦 File Structure
File	Description
alu_pipeline.v	RTL module for pipelined ALU
tb_alu_pipeline.v	Testbench for simulation and waveform generation
dump.vcd	Generated during simulation for EPWave waveform viewing

🌀 Pipeline Design
The pipeline includes the following stages:

IF (Instruction Fetch) – Fetches instruction from a small preloaded instruction memory.

ID (Instruction Decode) – Extracts opcode, source operands.

EX (Execute) – ALU performs the operation.

WB (Writeback) – Result is stored in the output register.

📈 Simulation Waveform
Below is the simulation waveform of the ALU with 4 instructions executed sequentially:
![image](https://github.com/user-attachments/assets/179bc0b8-62a6-4dbe-a7ea-ef541f868645)

🔍 Waveform Explanation:
Signal	Description
clk	System clock
reset	Active-high reset
pc	Program counter for instruction memory
IF_ID	Pipeline register between IF and ID
ID_EX	Pipeline register between ID and EX
alu_out	Output of ALU (goes to WB stage)
result	Final output of pipeline (written at WB)
src1, src2	Source operands decoded from instruction
opcode	ALU operation selector

✅ Observations:
At t ≈ 15ns, the first instruction (ADD 10 + 5) is executed, result = 15.

Successive instructions (SUB, AND, OR) follow through the pipeline with 1 instruction per 10ns cycle.

The result updates every clock cycle after the initial latency, showing proper pipelining.

🧪 Supported ALU Operations
Opcode	Binary	Operation	Description
00	2'b00	ADD	Addition of operands
01	2'b01	SUB	Subtraction
10	2'b10	AND	Bitwise AND
11	2'b11	OR	Bitwise OR

▶️ How to Run
You can simulate this design on EDA Playground:

Paste the Verilog files into the editor

Select Icarus Verilog or VCS

Make sure the testbench has $dumpfile("dump.vcd"); $dumpvars(0, tb_alu_pipeline);

Click Run and inspect the waveform using EPWave
