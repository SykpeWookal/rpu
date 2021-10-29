
package rpu

import chisel3._
import chisel3.util._

class rpu_register_file_group(thread_number: Int) extends Module {
  val io = IO(new Bundle {
    // thread id update interface
    val thread_id_we = Input(Bool())
    val thread_id_wdata = Input(UInt((log2Ceil(thread_number)).W))
    // read interface a
    val raddr_a = Input(UInt(5.W))
    val rdata_a = Output(UInt(32.W))
    // read interface b
    val raddr_b = Input(UInt(5.W))
    val rdata_b = Output(UInt(32.W))
    // read interface c
    val raddr_c = Input(UInt(5.W))
    val rdata_c = Output(UInt(32.W))
    // write interface a
    val waddr_a = Input(UInt(5.W))
    val wdata_a = Input(UInt(32.W))
    val we_a = Input(Bool())
  })

  val regfile_group = Mem(32 * thread_number, UInt(32.W))

  val thread_id = Reg(UInt((log2Ceil(thread_number)).W))

  when(io.thread_id_we && (io.thread_id_wdata < thread_number.U)) {
    thread_id := io.thread_id_wdata
  } .elsewhen(io.we_a) {
    regfile_group(Cat(thread_id, io.waddr_a)) := io.wdata_a
  }
  
  when (io.raddr_a === 0.U) {
    io.rdata_a := 0.U
  } .otherwise {
    io.rdata_a := regfile_group(Cat(thread_id, io.raddr_a))
  }
  when (io.raddr_b === 0.U) {
    io.rdata_b := 0.U
  } .otherwise {
    io.rdata_b := regfile_group(Cat(thread_id, io.raddr_b))
  }
  when (io.raddr_c === 0.U) {
    io.rdata_c := 0.U
  } .otherwise {
    io.rdata_c := regfile_group(Cat(thread_id, io.raddr_c))
  }
}