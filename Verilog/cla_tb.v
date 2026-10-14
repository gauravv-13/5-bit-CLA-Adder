`timescale 1ns/1ns

module cla_tb;
    reg [4:0] a,b;
    reg cin;
    wire [4:0] sum;
    wire cout;  
    wire [5:0] c_all;

    clacomb uut(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout),.c_all(c_all));

    initial begin
    $dumpfile("cla.vcd");
    $dumpvars(0,cla_tb);
    $monitor("t=%0t, a=%b b=%b cin=%b, c0=%b c1=%b c2=%b c3=%b c4=%b c5=%b, sum=%b cout=%b",$time,a,b,cin,c_all[0],c_all[1],c_all[2],c_all[3],c_all[4],c_all[5],sum,cout);
    cin=0;
    a=5'b10101; b=5'b01010; #10;
    $finish;
    end
endmodule
