module reconfigurable_controller #(parameter modes = 1)(
	input clk,
	input [modes:0] mode,
	//reset pins
	input SPI_reset,
	input I2C_reset,
	input Ux_enable,
	//busy pins
	input SPI_busy,
	input I2C_busy,
	input Ux_busy,
	//valid pins
	input SPI_valid,
	input I2C_valid,
	input Ux_valid,
	//select line
	output reg [2:0] select
);

always@(posedge clk)
begin
	case(mode)
		2'b00: 
		begin
			if(SPI_reset)
				select[0] <= 0;
			else if(SPI_busy)
				select[0] <= 1;
			else if(SPI_valid)
				select[0] <= 0;
		end
		
		2'b01:
		begin
			if(I2C_reset)
				select[1] <= 0;
			else if(I2C_busy)
				select[1] <= 1;
			else if(I2C_valid)
				select[1] <= 0;
		end
		
		2'b10:
		begin
			if(Ux_enable)
				select[2] <= 0;
			else if(Ux_busy)
				select[2] <= 1;
			else if(Ux_valid)
				select[2] <= 0;
		end
	endcase
end

endmodule