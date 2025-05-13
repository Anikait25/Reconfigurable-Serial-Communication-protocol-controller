module BAUD_generator(clk,B_clk);
input clk;
output reg B_clk = 0;

parameter clk_rate = 10_000_000;//10MHz
parameter BAUD_rate = 9600;
parameter divisor = (clk_rate/(BAUD_rate * 16)) - 1; //16x oversampling
parameter cnt_width = $clog2(divisor);

reg [cnt_width - 1: 0] counter = 0;

always@(posedge clk) 
begin	
	if(counter == divisor[cnt_width - 1: 0])
	begin
		counter <= 0;
		B_clk <= ~B_clk;
	end
	else 
		counter <= counter + 1;
end

endmodule