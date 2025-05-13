module UART_receiver(clk,rx_enable,rx_start,rx_in,rx_received_data);
input clk,rx_enable,rx_start;
input rx_in;
output reg [7:0] rx_received_data = 0;

reg [1:0] state = 0;
reg [10:0] data_received = 0; //start bit + data + parity + stop bit
reg [4:0] count;


localparam IDLE = 0;
localparam START = 1;
localparam RECEIVE_DATA = 2;
localparam END = 3;

always@(posedge clk)
begin
	if(rx_enable)
	begin
		count <= 0;
		rx_received_data <= 0;
		state <= IDLE;
	end
	else
	begin
		case(state)
			IDLE:
				begin
					if(rx_start) begin
						count <= 4'd10;
						state <= START;
					end
					else begin
						state <= IDLE;
						end
				end
			START:
				begin
					state <= RECEIVE_DATA;
				end
			RECEIVE_DATA:
				begin
					data_received[count] <= rx_in;
					if(count == 0) state <= END;
					else count <= count - 1;
				end
			END:
				begin
					rx_received_data <= data_received[8:1];
					state <= IDLE;
				end
		endcase
	end
end

endmodule