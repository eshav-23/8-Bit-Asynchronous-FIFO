# Asynchronous FIFO with Dual-Clock Synchronization

This project implements an **8-bit Asynchronous FIFO (First-In, First-Out) buffer** in Verilog, designed to support **independent read and write clock domains**.  
It enables **safe and reliable data transfer across different clock domains**, preventing metastability through pointer synchronization.

---

## Features

- **Asynchronous FIFO**
  - Separate **read clock** and **write clock** domains.  
  - Reliable cross-clock data transfer without data corruption.  

- **Dual-Port Memory**
  - Parameterized **8-bit data width** and configurable depth.  
  - Independent read/write access for parallelism.  

- **Pointer & Synchronization Logic**
  - **Write pointer** tracks enqueue operations.  
  - **Read pointer** tracks dequeue operations.  
  - Two-flop synchronizers ensure safe pointer transfer between clock domains.  

- **Status Flag Detection**
  - **Full flag**: Prevents writes when FIFO is full.  
  - **Empty flag**: Prevents reads when FIFO is empty.  
  - Pointer comparison ensures accurate status detection.  


---

## How It Works

1. **Write Operation**
   - Data is written into FIFO at the rising edge of the **write clock**.  
   - The **write pointer** advances until the FIFO is full.  

2. **Read Operation**
   - Data is read from FIFO at the rising edge of the **read clock**.  
   - The **read pointer** advances until the FIFO is empty.  

3. **Synchronization**
   - Write pointer is synchronized into the read domain.  
   - Read pointer is synchronized into the write domain.  
   - **Two-flop synchronizers** prevent metastability during pointer crossing.  

4. **Flags**
   - **Full flag** is asserted when the next write would overwrite unread data.  
   - **Empty flag** is asserted when the read pointer catches up to the write pointer.  

---

## Tools & Environment

- **Language**: Verilog HDL  
- **Simulation & Synthesis**: Xilinx Vivado  
- **Target FPGA**: Nexys 4 DDR / Basys3 or any FPGA with dual-clock support  

---
## Usage

1. Clone the repository to your local machine:
    
    ```
    git clone <https://github.com/eshav-23/8-Bit-Asynchronous-FIFO>
    
    ```
    
2. Open XILINX Vivado and create a new project.
3. Add the Verilog source files from the cloned repository to your project.
4. Synthesize and implement the design.
