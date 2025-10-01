module data_memory(
    input clk,
    input [7:0] mem_addr,
    input we,
    input [7:0] mem_in_data,
    output reg [7:0] mem_out_data
);

    reg [7:0] regs_mem [255:0];

    always@(posedge clk) begin
        if(we) begin
            regs_mem[mem_addr] <= mem_in_data;
        end

        else begin
            mem_out_data <= regs_mem[mem_addr];
        end
    end
endmodule

