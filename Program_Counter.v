module program_counter(
    input clk,
    input rst_n,
    input [7:0] pc_next,
    output reg [7:0] pc   
);

always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            pc <= 8'b0;
        else
            pc <= pc_next;
    end

endmodule