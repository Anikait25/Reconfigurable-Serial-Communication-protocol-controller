module I2C_top(
	input I2C_clk,
	input reset,
	input [6:0]addr,
	input [7:0]data,
	output i2c_scl,
	inout i2c_sda,
	output valid,
	output busy
);

I2C_revised_step1 controller(
	.clk(I2C_clk),
	.reset(reset),
	.addr(addr),
	.data(data),
	.i2c_sda(i2c_sda),
	.i2c_scl(i2c_scl),
	.valid(valid),
	.busy(busy)
);




endmodule
