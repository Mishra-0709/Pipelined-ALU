module alu_pipeline #(parameter WIDTH = 8)(
    input clk,
    input reset,
    output reg [WIDTH-1:0] result
);

    // Instruction Format: {op[1:0], src1[7:0], src2[7:0]}
    reg [17:0] instruction_mem [0:3];
    reg [1:0] pc;

    // Pipeline Registers
    reg [17:0] IF_ID;
    reg [17:0] ID_EX;
    reg [WIDTH-1:0] EX_WB;

    // Decode stage
    wire [1:0] opcode = ID_EX[17:16];
    wire [WIDTH-1:0] src1 = ID_EX[15:8];
    wire [WIDTH-1:0] src2 = ID_EX[7:0];

    // ALU result
    reg [WIDTH-1:0] alu_out;

    // Instruction Fetch Stage
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            IF_ID <= 0;
        end else begin
            IF_ID <= instruction_mem[pc];
            pc <= pc + 1;
        end
    end

    // Instruction Decode Stage
    always @(posedge clk or posedge reset) begin
        if (reset)
            ID_EX <= 0;
        else
            ID_EX <= IF_ID;
    end

    // Execution Stage (ALU)
    always @(posedge clk or posedge reset) begin
        if (reset)
            alu_out <= 0;
        else begin
            case (opcode)
                2'b00: alu_out <= src1 + src2; // ADD
                2'b01: alu_out <= src1 - src2; // SUB
                2'b10: alu_out <= src1 & src2; // AND
                2'b11: alu_out <= src1 | src2; // OR
                default: alu_out <= 0;
            endcase
        end
    end

    // Writeback Stage
    always @(posedge clk or posedge reset) begin
        if (reset)
            result <= 0;
        else
            result <= alu_out;
    end

    // Preload Instructions (ADD, SUB, AND, OR)
    initial begin
        instruction_mem[0] = {2'b00, 8'd10, 8'd5};   // ADD 10 + 5
        instruction_mem[1] = {2'b01, 8'd20, 8'd8};   // SUB 20 - 8
        instruction_mem[2] = {2'b10, 8'd15, 8'd3};   // AND 15 & 3
        instruction_mem[3] = {2'b11, 8'd12, 8'd4};   // OR 12 | 4
    end

endmodule
