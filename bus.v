module bus(
	input [2:0]select,
	output reg [2:0]select_p,
	
	output [6:0] address,
	output [7:0] data,
	input [7:0] received_data
);

wire [15:0] data_in;
assign data_in = 16'h42a4;
wire [7:0] data_out;
wire [6:0] addr;
assign addr = data_in[14:8];
assign data_out = data_in[7:0];
assign address = addr;
assign data = data_out;
reg [7:0] saved_data;
always@(*)
begin
	select_p = select;
	saved_data = received_data;
end

endmodule