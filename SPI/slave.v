module slave(spi_scl,spi_cs,mosi,miso);
input spi_scl,spi_cs;
input mosi;
reg [7:0] slave_data = 8'ha5;
output reg miso;

localparam IDLE = 0;
localparam READ_DATA = 1;
localparam STOP = 2;

reg [2:0]count;
reg [1:0]state;
reg [7:0]rx_data=0;

always@(posedge spi_scl)
begin
	case(state)
		IDLE:
			begin
				if(!spi_cs) 
				begin
					count <= 3'd7;
					state <= READ_DATA;
					//$display("state %b",state);
				end
				else 
				begin
					state <= IDLE;
				end
		end
		
		READ_DATA:
			begin
				rx_data[count] <= mosi;
				miso <= slave_data[count];
				if (count == 0) state <= STOP;
				else begin count <= count - 1;
				//$display("state %b, miso %b count %d",state,miso,count);
				end
		end
		
		STOP:	
			begin
				state <= IDLE;
			end
		default:state <= IDLE;
	endcase
end
//assign miso = miso1;
endmodule