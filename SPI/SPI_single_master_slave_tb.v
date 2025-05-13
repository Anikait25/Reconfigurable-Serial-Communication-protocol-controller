module SPI_single_master_slave_tb;
reg spi_clk,reset;
wire miso;
wire mosi;
wire spi_scl,spi_cs;
wire valid,busy;

spi_top controller(
	.spi_clk(spi_clk),
	.reset(reset),
	.miso(miso),
	.mosi(mosi),
	.spi_scl(spi_scl),
	.spi_cs(spi_cs),
	.valid(valid),
	.busy(busy),
	.data(8'h9a)
);

initial
spi_clk = 0;
always #5 spi_clk = ~spi_clk;

initial
begin
	reset=1;
	
	#10;
	
	reset = 0;
	
	#120;

	$stop;
end
endmodule