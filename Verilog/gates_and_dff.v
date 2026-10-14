module notgate(input x,output y);
assign y=~x;
endmodule

module andgate(input a1,b1,output y1);
assign y1=a1&b1;
endmodule

module orgate(input a2,b2,output y2);
assign y2=a2|b2;
endmodule

module nandgate(input a3,b3,output y3);
assign y3=~(a3&b3);
endmodule

module norgate(input a4,b4,output y4);
assign y4=~(a4|b4);
endmodule

module xorgate(input a5,b5,output y5);
assign y5=a5^b5;
endmodule

module dff(input din,input clk,input rst,output reg qout);
always @(posedge clk or posedge rst)
begin
if(rst)
qout<=1'b0;
else
qout<=din;
end
endmodule
