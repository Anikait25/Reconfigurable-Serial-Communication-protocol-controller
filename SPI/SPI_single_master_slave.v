/*
SPI (Serial peripheral Interface) implementation 

key notes:-
(1) The data is given in the testbench.
(2) The program is written in this way for future purposes.
(3) This program will send the data the slave.

Author :- Anikait Sarkar
Date :- 09/05/2025
Profession :- RSA SEIP VLSI Trainee
*/
module SPI_single_master_slave(spi_clk,reset,miso,mosi,spi_scl,spi_cs,valid,busy,data);
input spi_clk,reset;
input miso;
output spi_scl;
output reg spi_cs;
output reg mosi,valid,busy;

input [7:0]data;
reg [7:0]rx_data;
reg [7:0]count;
reg [1:0]state;
localparam IDLE = 0;
localparam START = 1;
localparam SEND_N_RECEIVE_DATA = 2;
localparam STOP = 3;

reg spi_scl_enable;

assign spi_scl = (spi_scl_enable == 1)? spi_clk : 1;
//$monitor("%b,%b",spi_scl_enable,spi_scl);

always@(posedge spi_clk) //for SPI Serial Clock
begin
	if(reset == 1)
	begin
		spi_scl_enable <= 0;
	end
	else
	begin
		if((state == IDLE) || (state == START) || (state == STOP))
		begin
			spi_scl_enable <= 0;
		end
		else begin
			spi_scl_enable <= 1;
		end
	end
end

//FSM logic
always@(posedge spi_clk) begin
	if(reset == 1) begin
		spi_cs <= 1;
		valid <= 0;
		busy <= 0;
		rx_data <= 0;
		state <= IDLE;
	end
	else begin
		case(state)
			IDLE:
			begin
				spi_cs <= 0;
				mosi <= 1;
				busy <= 0;
				valid <= 0;
				state <= START; 
			end
			
			START:
			begin
				count <= 8'd7;
				busy <= 1;
				state <= SEND_N_RECEIVE_DATA;
			end
			
			SEND_N_RECEIVE_DATA:
			begin
				mosi <= data[count];
				rx_data[count] <= miso; 
				if(count == 0) state <= STOP;
				else count <= count - 1;
			end
			
			STOP:
			begin
				spi_cs <= 1;
				busy <= 0;
				valid <= 1;//signal that rx_data is valid
				state <= IDLE;
			end
			default:state <= IDLE;
		endcase
	end
end
endmodule