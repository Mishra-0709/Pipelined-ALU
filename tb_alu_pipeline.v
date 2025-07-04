`timescale 1ns/1ps

module tb_alu_pipeline;

    reg clk;
    reg reset;
    wire [7:0] result;

    // Instantiate ALU Pipeline
    alu_pipeline dut (
        .clk(clk),
        .reset(reset),
        .result(result)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period
    end

    // Test Sequence
    initial begin
        $display("Time\tResult");
        $monitor("%0dns\t%d", $time, result);
        
        // Waveform dump setup
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_alu_pipeline);
        $dumpvars(0, dut);

        reset = 1;
        #10;
        reset = 0;

        #100;  // Let all instructions pass through pipeline

        $finish;
    end

endmodule
