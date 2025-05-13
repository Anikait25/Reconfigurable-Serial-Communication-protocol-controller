module UART_transmitter(clk,tx_enable,tx_start,tx_data_in,tx_out,busy,valid);
input clk,tx_enable,tx_start;
input [7:0] tx_data_in;
output reg tx_out,busy,valid;

reg [1:0] state = 0;
reg [7:0] saved_data = 0;
reg [10:0] data_send = 0; //start bit + data + parity + stop bit
reg [4:0] count;
wire parity;

assign parity = ^tx_data_in;

localparam IDLE = 0;
localparam START = 1;
localparam SEND_DATA = 2;
localparam END = 3;

always@(posedge clk)
begin
	if(tx_enable)
	begin
		count <= 0;
		data_send <= 0;
		tx_out <= 1;
		state <= IDLE;
		busy <= 0;
		valid <= 0;
	end
	else
	begin
		case(state)
			IDLE:
				begin
					tx_out <= 1;
					busy <= 0;
					valid <= 0;
					if(tx_start) begin
						count <= 4'd10;
						state <= START;
					end
					else begin
						state <= IDLE;
						end
				end
			START:
				begin
					data_send <= {1'b0,tx_data_in,parity,1'b1};
					busy <= 1;
					state <= SEND_DATA;
				end
			SEND_DATA:
				begin
					tx_out <= data_send[count];
					if(count == 0) state <= END;
					else count <= count - 1;
				end
			END:
				begin
					busy <= 0;
					valid <= 1;
					state <= IDLE;
				end
		endcase
	end
end

endmodule