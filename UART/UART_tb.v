`timescale 1s/1ps
module UART_tb;

reg clk;
reg tx_rx_enable;
reg tx_rx_start;
reg rx_in;
wire tx_out;
reg [7:0] tx_data;
wire [7:0] rx_received_data;
wire valid,busy;

UART uart1(
	.clk(clk),
	.tx_rx_enable(tx_rx_enable),
	.tx_rx_start(tx_rx_start),
	.tx_out(tx_out),
	.rx_in(rx_in),
	.tx_data(tx_data),
	.rx_received_data(rx_received_data),
	.valid(valid),
	.busy(busy)
);

initial
clk = 0;
always #5 clk = ~clk;

initial
begin
	tx_rx_enable = 1;
	tx_rx_start = 0;
	#10;
	tx_rx_enable = 0;
	tx_rx_start = 1;
	#10;
	tx_data = 8'h45;
	#20;
	tx_rx_start = 0;
	#10;
	tx_rx_start = 1;
	#10;
	rx_in = 0;#20;
	rx_in = 1;#20;
	rx_in = 0;#20;
	rx_in = 1;#20;
	rx_in = 0;#20;
	rx_in = 1;#20;
	rx_in = 0;#20;
	rx_in = 1;#20;
	rx_in = 0;#20;
	rx_in = 1;#20;
	rx_in = 0;#20;
	
	#150;
	
	//#40_000;
	$finish;
end
endmodule