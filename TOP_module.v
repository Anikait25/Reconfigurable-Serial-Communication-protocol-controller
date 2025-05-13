module TOP_module(
input clk,
//reconfigurable controller
input [1:0] mode,

//reset pins
input SPI_reset,
input I2C_reset,
input Ux_enable,

//SPI ports
output miso,
output mosi,
output spi_scl,
output spi_cs,

//I2C ports
inout i2c_sda,
output i2c_scl,

//UART ports
input Ux_start,
input Ux_in,
output Ux_out

);


wire [7:0]data; 
wire [6:0]addr; 
	//busy pins
wire SPI_busy;
wire I2C_busy;
wire Ux_busy;
	//valid pins
wire SPI_valid;
wire I2C_valid;
wire Ux_valid;
	//select line
wire [2:0] select;
wire [2:0] select_p;

wire [7:0]rx_data;

reconfigurable_controller #(.modes(1)) control(
	.clk(clk),
	.mode(mode),
	//reset pins
	.SPI_reset(SPI_reset),
	.I2C_reset(I2C_reset),
	.Ux_enable(Ux_enable),
	//busy pins
	.SPI_busy(SPI_busy),
	.I2C_busy(I2C_busy),
	.Ux_busy(Ux_busy),
	//valid pins
	.SPI_valid(SPI_valid),
	.I2C_valid(I2C_valid),
	.Ux_valid(Ux_valid),
	//select line
	.select(select)
);

bus bus1(
	.select(select),
	.select_p(select_p),
	.address(addr),
	.data(data),
	.received_data(rx_data)
);

spi_top SPI(
	.spi_clk(clk),
	.reset(select_p[0]),
	.data(data),
	.miso(miso),
	.mosi(mosi),
	.spi_scl(spi_scl),
	.spi_cs(spi_cs),
	.valid(SPI_valid),
	.busy(SPI_busy)
);

I2C_top I2C(
	.I2C_clk(clk),
	.reset(select_p[1]),
	.addr(addr),
	.data(data),
	.i2c_scl(i2c_scl),
	.i2c_sda(i2c_sda),
	.valid(I2C_valid),
	.busy(I2C_busy)
);

//$display($time,"state = %b",.I2C(.I2C_revised_step1(.state)));

UART uart(
	.clk(clk),
	.tx_rx_enable(select_p[2]),
	.tx_rx_start(Ux_start),
	.tx_out(Ux_out),
	.rx_in(Ux_in),
	.tx_data(data),
	.valid(Ux_valid),
	.busy(Ux_busy),
	.rx_received_data(rx_data)
);

endmodule