module UART(
input clk,tx_rx_enable,tx_rx_start,
output tx_out,
input rx_in,
input [7:0] tx_data,
output [7:0] rx_received_data,
output valid,busy
);

wire Ux_clk;

BAUD_generator #(.BAUD_rate(9600))baud(.clk(clk),.B_clk(Ux_clk));

UART_transmitter transmit(.clk(Ux_clk),.tx_enable(tx_rx_enable),.tx_start(tx_rx_start),.tx_data_in(tx_data),.tx_out(tx_out),.busy(busy),.valid(valid));

UART_receiver receive(.clk(Ux_clk),.rx_enable(tx_rx_enable),.rx_start(tx_rx_start),.rx_in(rx_in),.rx_received_data(rx_received_data));

endmodule
