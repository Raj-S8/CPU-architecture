module program_counter(
    input clk,
    input rst_n,
    input [7:0] pc_next, // The next address location which is of 1 byte;
    output reg [7:0] pc   // The output of the program counter is the address of the next instruction;
); // Program counter module keeps the address of the current program instruction;

always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) // The reset(Active low) to make the value of the program counter 0;
            pc <= 8'b0;
        else
            pc <= pc_next; // The value of the program counter is updated when the is high;
    end

endmodule