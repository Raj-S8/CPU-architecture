module (
    input [7:0] a,
    input[7:0] b,
    input [3:0] opcode,
    output [7:0] alu_output;
    output c, z, v, n
    ;
);

reg [7:0] op;
assign alu_output = op;

always@(*)

begin

  case(opcode)

  4'b0000:
  begin
     {c,op} = a + b;
     z = op == 0;
     v = (~(a[7] ^ b[7])) & (a[7] ^ op[7]);
     n = op[7];
  end

  4'b0001:
    begin
     {c,op} = {1'b0,a} - {1'b0,b}; // a - b will also work (without accounting for the 9th bit)
     z = op == 0;
     v = (a[7] ^ b[7]) & (a[7] ^ op[7]);
     n = op[7]; // the negative flag always mirrors the msb of the result
  end


end

endmodule