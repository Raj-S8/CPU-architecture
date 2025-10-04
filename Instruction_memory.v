
// Instruction memory is the memory block which stores the instruction given to the CPU at a particular memory address;\
// Instruction memory is a read only memory;
// Synchronous

module ins_memory(

    input clk,
    input [7:0] ins_mem_add, // 8 bit instruction address;
    output reg [15:0] mem_out_ins // The output is the instruction which the CPU has to perform;
);

    reg [15:0] regs_ins_mem [0:255]; // A block of 256 x 16 bits i.e. the width is 16 bits and the depth is 256 bits;

    always@(posedge clk) begin
        mem_out_ins <= regs_ins_mem[ins_mem_add]; // Read only memory;
    end
endmodule
