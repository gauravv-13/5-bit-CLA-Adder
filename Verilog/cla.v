`timescale 1ns/1ns

module pgblock(a,b,p,g);
  input [4:0] a,b;
  output [4:0] p,g;
  assign p=a^b;
  assign g=a&b;
endmodule

module clablock(p,g,cin,c,cout);
  input [4:0] p,g;
  input cin;
  output [5:1] c;
  output cout;
  assign c[1]=g[0]|(p[0]&cin);
  assign c[2]=g[1]|(p[1]&g[0])|(p[1]&p[0]&cin);
  assign c[3]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&cin);
  assign c[4]=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&cin);
  assign c[5]=g[4]|(p[4]&g[3])|(p[4]&p[3]&g[2])|(p[4]&p[3]&p[2]&g[1])|(p[4]&p[3]&p[2]&p[1]&g[0])|(p[4]&p[3]&p[2]&p[1]&p[0]&cin);
  assign cout=c[5];
endmodule

module sumblock(p,c,s);
  input [4:0] p;
  input [4:0] c;
  output [4:0] s;
  assign s=p^c;
endmodule

module clacomb(a,b,cin,sum,cout,c_all);
  input [4:0] a,b;
  input cin;
  output [4:0] sum;
  output cout;
  output [5:0] c_all;
  wire [4:0] p,g;
  wire [5:1] c;
  wire [4:0] c_for_sum;

  pgblock pg(.a(a),.b(b),.p(p),.g(g));
  clablock cla(.p(p),.g(g),.cin(cin),.c(c),.cout(cout));
  assign c_for_sum={c[4:1],cin};
  sumblock sg(.p(p),.c(c_for_sum),.s(sum));
  assign c_all={c[5:1],cin};
endmodule

module cladff(clk,dinput,q);
  input clk;
  input dinput;
  output reg q;
  always @(posedge clk) q<=dinput;
endmodule

module clasyn(clk,a_in,b_in,sum_out,cout_out);
  input clk;
  input [4:0] a_in;
  input [4:0] b_in;
  output [4:0] sum_out;
  output cout_out;
  wire [4:0] a_reg,b_reg,sum_comb;
  wire cout_comb;
  genvar i;

  generate
  for(i=0;i<5;i=i+1)begin
    cladff da(clk,a_in[i],a_reg[i]);
    cladff db(clk,b_in[i],b_reg[i]);
  end
  endgenerate
    
  clacomb cla(.a(a_reg),.b(b_reg),.cin(1'b0),.sum(sum_comb),.cout(cout_comb),.c_all());
  
  generate
  for(i=0;i<5;i=i+1) cladff ds(clk,sum_comb[i],sum_out[i]);
  endgenerate
  
  cladff dcout(clk,cout_comb,cout_out);
endmodule
