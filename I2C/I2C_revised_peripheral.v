module I2C_revised_peripheral (i2c_sda,i2c_scl);
input i2c_scl;
inout i2c_sda;

localparam slave_address = 7'b0101_010;

localparam IDLE = 0;
localparam READ_ADDR = 1;
localparam SEND_ACK = 2;
localparam WRITE_DATA = 3;
localparam SEND_ACK2 = 4;
localparam END =5;

reg [6:0]addr;
reg [7:0]data;
reg [7:0]state;
reg [7:0]counter;
reg i2c_sda_temp;
always@(negedge i2c_scl)
begin
	i2c_sda_temp <= i2c_sda;
	case(state)
		IDLE:
			begin
				counter <= 8'd8;
				if((i2c_sda_temp == 0) && (i2c_scl == 1)) 
				begin
					state <= READ_ADDR;
				end
				else state <= IDLE;
			end
		READ_ADDR:
			begin
				addr[counter - 1] <= i2c_sda_temp;
				if (counter == 0) state <= SEND_ACK;
				else counter <= counter - 1;
			end
			
		SEND_ACK:
			begin
				if(addr == slave_address) 
				begin
					i2c_sda_temp <= 0; 
					state <= WRITE_DATA;
				end
				else begin
					i2c_sda_temp <= 1;
				end
			end
			
		WRITE_DATA:
			begin
				data[counter] <= i2c_sda_temp;
				if (counter == 0) state <= SEND_ACK2;
				else counter <= counter - 1;
			end
			
		SEND_ACK2:
			begin
				i2c_sda_temp <= 0;
				state <= END;
			end
			
		END:
			begin
				state <= IDLE;
			end
	endcase
end

endmodule