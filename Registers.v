
// Two Read One Write Register

// The register is the closest memory to the CPU; It is also much faster than RAM; and much slower as well;

// The register provides immediate access memory for the operations of the ALU and other components;

// Usually it is the case that the read in the Register is asynchronous and the write is synchronous. This is so that the CPU does not have to wait for the clock edge; INSTANTANEOUS DATA RETRIEVAL;

// Syntax to declare a memory block --> reg [Word Size] block name [depth of the block];

module registers (

    input clk, // Clock as we use synchoronous Write;
    input we, // Write enable, The registers are ready to take new value when we is high;
    input [2:0] r_add1, r_add2, // Two read addresses of 3 bits;
    input [2:0] w_add, // One write address of 3 bits;
    input [7:0] w_data, // Write data of 8 bits;
    output [7:0] r_data1, r_data2 // 8 bits of data as output; 

);

// Declaration of the array of registers and their depth. The first part reg[7:0] is the width and the next part is the depth;
// It will declare 8 regs ( regs[0], regs[1].....regs[7]) each 8 bit wide;

reg [7:0] regs[7:0]; 

// The output r_data1 and r_data2 are driven by the values present in the registers at the provided address;
// The overall read is asynchronous in nature.

assign r_data1 = regs[r_add1];
assign r_data2 = regs[r_add2];

// The write cycle unlike the read cycle is synchoronous. The data is written at the provided address with every positive clk edge;

always@(posedge clk)
    begin
        if(we && w_add != 3'b000)  // when write enable is active and the write address does not point to R0;
            regs[w_add] <= w_data;

        regs[3'b000] <= 8'b00000000; // Hardwired R0 to 0;
end

endmodule