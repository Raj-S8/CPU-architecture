
// Data memory is a memory other than the registers;

// It is essentially a RAM. It has a larger size than the Register memory but is significantly slower;

// Stores the entire program and all the data it will need;

// The RAM has synchronous Read unlike the register as it prioritizes Data integrity or more importantly the bulk memory is ususally placed far away from the CPU so it is somewhat necessary for the operations performed to and fro RAM are synchronize with the clock;



module data_memory(
    input clk,
    input [7:0] mem_addr, // Address of 1 byte;
    input we, // Write enable --> Write to the memory when 1 and Read from the memory when 0;
    input [7:0] mem_in_data, // Data to write in the memory
    output reg [7:0] mem_out_data // Data which is present at a particular memory location;
);

    reg [7:0] regs_mem [255:0]; // The memory block with WIDTH of 8 Bits and the DEPTH of 256 Bits;

    // We can also have a variation where we can Sync the write operation with the clock but keep the read operation asynchronous;

    always@(posedge clk) begin // Synchronous Read and Write always at the positive edge of the clock;
        if(we) begin
            regs_mem[mem_addr] <= mem_in_data; // Write data to the memory if the write enable is high;
        end
    
    // The read block can also be outside the always for the read to be asynchronous or we can also use the another always block for the read operation. This is often preferred because in the present case the read operation will only be performed when the write enable signal is low;

        else begin
            mem_out_data <= regs_mem[mem_addr]; // Read the data from the memory this happens when the write enable pin is low;
        end
    end
endmodule

