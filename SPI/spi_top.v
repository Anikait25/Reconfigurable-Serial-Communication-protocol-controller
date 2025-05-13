/*
spi_top
This program will be acting as a top module for whole SPI operation

Author :- Anikait Sarkar
Date :- 09/05/2025
Profession :- RSA SEIP VLSI Trainee
*/

module spi_top(spi_clk,reset,miso,mosi,spi_scl,spi_cs,valid,busy,data);
input spi_clk,reset;
input [7:0]data;
output miso;
output mosi;
output spi_scl,spi_cs;
output valid,busy;
SPI_single_master_slave master(
	.spi_clk(spi_clk),
	.reset(reset),
	.miso(miso),
	.mosi(mosi),
	.spi_scl(spi_scl),
	.spi_cs(spi_cs),
	.valid(valid),
	.busy(busy),
	.data(data)
);

slave slave1(
	.spi_scl(spi_scl),
	.spi_cs(spi_cs),
	.mosi(mosi),
	.miso(miso)
);
endmodule
