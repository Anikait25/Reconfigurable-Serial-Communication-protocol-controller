module TOP_module_tb;
reg clk;
//reconfigurable controller
reg [1:0]mode;

//reset pins
reg SPI_reset;
reg I2C_reset;
reg Ux_enable;
//SPI ports

wire miso;
wire mosi;
wire spi_scl;
wire spi_cs;


//I2C ports


wire i2c_scl;
tri i2c_sda;

//UART ports

reg Ux_start;
reg Ux_in;
wire Ux_out;


TOP_module control (
	.clk(clk),
   .mode(mode),
	.SPI_reset(SPI_reset),
	.I2C_reset(I2C_reset),
	.Ux_enable(Ux_enable),
   .miso(miso),
   .mosi(mosi),
   .spi_scl(spi_scl),
   .spi_cs(spi_cs),
   .i2c_sda(i2c_sda),
   .i2c_scl(i2c_scl),
   .Ux_start(Ux_start),
	.Ux_in(Ux_in),
   .Ux_out(Ux_out)
);

initial
clk = 0;
always #5 clk = ~clk;

initial
begin
	//Initialization
	mode = 2'b00;
	SPI_reset = 1;
	I2C_reset = 1;
	Ux_enable = 1;
	Ux_start = 0;
	#20;
	
	// test SPI mode
	mode = 2'b01;
	SPI_reset = 0;
	#200;
	SPI_reset = 1;
	
	// test I2C mode
	mode = 2'b10;
	I2C_reset = 1;
	#10;
	I2C_reset = 0;
	#200;
	// test UART mode
	mode = 2'b11;
	Ux_enable = 0;
	Ux_start = 1;
	#200;
	Ux_enable = 1;
	Ux_start = 0;
	#10;
	Ux_enable = 0;
	Ux_start = 1;
	Ux_in = 0;#20;
	Ux_in = 1;#20;
	Ux_in = 0;#20;
	Ux_in = 1;#20;
	Ux_in = 0;#20;
	Ux_in = 1;#20;
	Ux_in = 0;#20;
	Ux_in = 1;#20;
	Ux_in = 0;#20;
	Ux_in = 1;#20;
	Ux_in = 0;#20;
	#200;
	$stop;
end
endmodule
	