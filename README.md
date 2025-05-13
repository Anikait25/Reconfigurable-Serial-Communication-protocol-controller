# Reconfigurable Serial Communication Protocol Controller

A flexible and modular Verilog-based controller that supports **I2C**, **SPI**, and **UART** communication protocols. This project enables **runtime reconfiguration**, allowing dynamic switching between protocols without reprogramming the FPGA. Ideal for embedded and FPGA-based applications that require multiprotocol support.

---

## 🚀 Features

- ✅ Supports I2C, SPI, and UART protocols
- 🔁 Reconfigurable protocol selection at runtime
- 🧱 Modular and clean Verilog HDL design
- 📶 Bidirectional communication (where applicable)
- 🧪 Simulation-ready with test logic support
- 💡 Parameterizable for custom use cases
- 🔌 Optimized for Intel MAX10 FPGA (10M50DAF484C7G)

---

## 🧠 Description

This project implements a hardware controller capable of handling **multiple serial communication protocols**. It provides:
- Separate modules for **I2C**, **SPI**, and **UART**
- A **protocol selector** module to manage switching
- A **top module** that interfaces with external inputs and selects the required protocol

All components are written in Verilog and designed to be synthesized on an FPGA.

---

## 🛠 Modules Included

### 🔹 I2C Master
- Start/Stop condition generation
- Acknowledge handling
- Clock stretching support

### 🔹 SPI Master
- Full-duplex communication
- Configurable clock polarity (CPOL) and phase (CPHA)
- MSB-first or LSB-first option

### 🔹 UART (TX & RX)
- Configurable baud rate
- Start, data, and stop bit handling
- Asynchronous serial transmission

### 🔹 Protocol Selector
- Control logic to enable one protocol at a time
- Multiplexes inputs and outputs accordingly

### 🔹 Top-Level Controller
- Interface for clock, reset, protocol selection, input data, and output data
- Integrates all submodules

---

## ⚙️ Protocol Selection

Select protocol using a 2-bit input (e.g., `protocol_sel`):

| `protocol_sel` | Protocol |
|----------------|----------|
|      `00`      | I2C      |
|      `01`      | SPI      |
|      `10`      | UART     |
|      `11`      | Reserved (optional for future use) |

Switching is **instantaneous** and requires **no reprogramming** of the FPGA.

---

## 🧪 Simulation Instructions

You can simulate the controller in any Verilog simulator (ModelSim recommended):

1. Instantiate `top_module`.
2. Apply reset (`rst = 1` → `rst = 0`).
3. Provide clock (`clk`) and protocol selection.
4. Drive test input data and observe output.
5. Switch protocols during simulation to verify dynamic reconfiguration.

Use `$display`, `$monitor`, or waveform viewer to observe data flow and protocol activity.

---

## 💻 Tools Used

- **Verilog HDL**
- **ModelSim Intel FPGA Edition** (Simulation)
- **Quartus Prime Lite** (Synthesis/Implementation)
- **Target FPGA:** Intel MAX10 (10M50DAF484C7G)

---

## 📌 Future Enhancements

- ✅ Parameterized FIFO buffer integration
- ✅ UART parity bit and framing error detection
- ✅ AXI-lite bus support for easy SoC integration
- ✅ Support for additional protocols (e.g., CAN, LIN)
- ✅ Optional interrupt generation on transmission complete


## 📄 License

This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute this work with proper attribution.

---

## 👨‍💻 Author

- Anikait Sarkar
- RSA SEIP VLSI Trainee

