module (
    input [7:0] a,
    input[7:0] b,
    input [3:0] opcode,
    output [7:0] alu_output,
    output reg c, z, v, n
);

//reg [7:0] op;
reg[7:0] AH, AL ;
assign alu_output = AL;


always@(*) begin

  case(opcode)

    4'b0000:
    begin
        {c,AL} = a + b;
        z = AL == 0;
        v = (~(a[7] ^ b[7])) & (a[7] ^ AL[7]);
        n = AL[7];
    end

    4'b0001:
      begin
        {c,AL} = {1'b0,a} - {1'b0,b}; // a - b will also work (without accounting for the 9th bit)
        z = AL == 0;
        v = (a[7] ^ b[7]) & (a[7] ^ AL[7]);
        n = AL[7]; // the negative flag always mirrors the msb of the result
    end

    4'b0010:
      begin  // MUL unsigned
        {AH, AL} = a * b;   // store 16-bit result into two 8-bit regs
      //  op = AL;             // AL is the ALU output bus
        v  = |AH;            // Overflow = high bits non-zero
        c  = 0;
        z  = (AL == 0);
        n  = AL[7];
    end

    4'b0011:
      begin  // IMUL signed
        {AH, AL} = $signed(a) * $signed(b);
      //  op = AL;             // AL bus
        v  = |AH;            // Overflow = high bits non-zero
        c  = 0;
        z  = (AL == 0);
        n  = AL[7];
    end
    
    4'b0100:
      begin
        if(b == 0) begin
          AL = 8'hFF; // Marker to check division by zero
          AH = 0; // AH reg shows the remainder
          v = 1; // Division by zero triggers the Overflow 
        end
        else begin
          AL = a / b;
          AH = a % b;
          v = 0;
        end
        c = 0;
        z = AL?0:1;
        n = AL[7];
    end

    4'b0101:
      begin
        if(b == 0) begin
          AL = 8'hFF; // Marker to check division by zero
          AH = 0; // AH reg shows the remainder
          v = 1; // Division by zero triggers the Overflow
        end
        else begin
          AL = $signed(a) / $signed(b); //signed division to get the quotient
          AH = $signed(a) % $signed(b); // signed division to get the remainder
          v = 0;
        end
        c = 0;
        z = AL?0:1;
        n = AL[7];
    end

    4'b0110: // Bitwise AND
      begin
        AL = a & b;
        c = 0;
        v = 0;
        z = AL?0:1;
        n = AL[7];
      end

    4'b0111: // Bitwise OR
      begin
        AL = a | b;
        c = 0;
        v = 0;
        z = AL?0:1;
        n = AL[7];
      end
    
    4'b1000: // Bitwise XOR
      begin
        AL = a ^ b;
        c = 0;
        v = 0;
        z = AL?0:1;
        n = AL[7];
      end

    4'b1001: // Bitwise NOT
      begin
        AL = ~a;
        c = 0;
        v = 0;
        z = AL?0:1;
        n = AL[7];
      end

    4'b1010: // Logical Shift Left
      begin 
        AL = a << 1; // Shifts each bit in the a towards left by 1 bit. Replaces the LSB with 0;
        c = a[7]; // // Carry bit stores the MSB of "a" which was shifted;
        v = 0;
        z = AL?0:1;
        n = AL[7];
      end

    4'b1011: // Logical Shift Right
      begin 
        AL = a >> 1; // Shifts each bit in the a towards right by 1 bit. Replaces the MSB with 0;
        c = a[0]; // Carry bit stores the LSB of "a" which was shifted;
        v = 0;
        z = AL?0:1;
        n = AL[7];
      end

    4'b1100: // Shift Arithmetic Right
      begin
        AL = $signed(a) >>> 1; // Replaces the MSB with the signed bit rather than a 0 so as to keep the sign of the operand constant;
        c = a[0]; // Same as above : catches the bit which was shifted i.e. the LSB of a;
        v = 0;
        z = AL?0:1;
        n = AL[7];
      end



end

endmodule
