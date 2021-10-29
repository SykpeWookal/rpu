OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
  imem (rxai!w) : ORIGIN = 0x0000C000, LENGTH = 16K
  dmem (wxa!ri) : ORIGIN = 0x1000C000, LENGTH = 16K
  smem (wxa!ri) : ORIGIN = 0x10010000, LENGTH = 4K
}


SECTIONS
{
  __stack_size = DEFINED(__stack_size) ? __stack_size : 1K;

  .sm (ORIGIN(smem)):
  {
    KEEP(*(.sm));
  } >smem
  
  PROVIDE(__boot_address = ORIGIN(imem));
  .init (__boot_address) :
  {
    KEEP (*(SORT_NONE(.init)))
    KEEP (*(.text.start))
  } >imem

  .ialign         :
  {
    . = ALIGN(4);
    PROVIDE( _imem = . );
  } >imem

  .text           :
  {
    *(.text.unlikely .text.unlikely.*)
    *(.text.startup .text.startup.*)
    *(.text .text.*)
    *(.gnu.linkonce.t.*)
  } >imem

  . = ALIGN(4);

  PROVIDE (__etext = .);
  PROVIDE (_etext = .);
  PROVIDE (etext = .);
  PROVIDE( _eimem = . );

  .dalign         :
  {
    . = ALIGN(4);
    PROVIDE( _data = . );
  } >dmem

  .data          :
  {
    *(.rdata)
    *(.rodata .rodata.*)
    *(.gnu.linkonce.r.*)
    *(.data .data.*)
    *(.gnu.linkonce.d.*)
    . = ALIGN(8);
    PROVIDE( __global_pointer$ = . + 0x100 );
    *(.sdata .sdata.*)
    *(.gnu.linkonce.s.*)
    . = ALIGN(8);
    *(.srodata.cst16)
    *(.srodata.cst8)
    *(.srodata.cst4)
    *(.srodata.cst2)
    *(.srodata .srodata.*)
  } >dmem

  . = ALIGN(4);
  PROVIDE( _edata = . );
  PROVIDE( edata = . );

  PROVIDE( _fbss = . );
  PROVIDE( __bss_start = . );
  .bss            :
  {
    *(.sbss*)
    *(.gnu.linkonce.sb.*)
    *(.bss .bss.*)
    *(.gnu.linkonce.b.*)
    *(COMMON)
    . = ALIGN(4);
  } >dmem

  . = ALIGN(8);
  PROVIDE( _end = . );
  PROVIDE( end = . );

  .stack ORIGIN(dmem) + LENGTH(dmem) - __stack_size :
  {
    . = __stack_size;
    PROVIDE( _sp = . );
  } >dmem
}