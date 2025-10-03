module ins_memory(

    input clk,
    input [7:0] ins_mem_add,
    output reg [15:0] mem_out_ins
);

    reg [15:0] regs_ins_mem [0:255];

    always@(posedge clk) begin
        mem_out_ins <= regs_ins_mem[ins_mem_add];
    end
endmodule
