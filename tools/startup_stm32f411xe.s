/**
  ******************************************************************************
  * @file      startup_stm32f411xe.s
  * @author    MCD Application Team
  * @brief     STM32F411xExx Devices vector table for GCC based toolchains. 
  *            This module performs:
  *                - Set the initial SP
  *                - Set the initial PC == Reset_Handler,
  *                - Set the vector table entries with the exceptions ISR address
  *                - Branches to main in the C library (which eventually
  *                  calls main()).
  *            After Reset the Cortex-M4 processor is in Thread mode,
  *            priority is Privileged, and the Stack is set to Main.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2017 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
    
  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

.global  g_pfnVectors
.global  Default_Handler

/* start address for the initialization values of the .data section. 
defined in linker script */
.word  _sidata
/* start address for the .data section. defined in linker script */  
.word  _sdata
/* end address for the .data section. defined in linker script */
.word  _edata
/* start address for the .bss section. defined in linker script */
.word  _sbss
/* end address for the .bss section. defined in linker script */
.word  _ebss
/* stack used for SystemInit_ExtMemCtl; always internal RAM used */

/**
 * @brief  This is the code that gets called when the processor first
 *          starts execution following a reset event. Only the absolutely
 *          necessary set is performed, after which the application
 *          supplied main() routine is called. 
 * @param  None
 * @retval : None
*/

    .section  .text.Reset_Handler
  .weak  Reset_Handler
  .type  Reset_Handler, %function
Reset_Handler:  
  ldr   sp, =_estack    		 /* set stack pointer */

/* Copy the data segment initializers from flash to SRAM */  
  ldr r0, =_sdata
  ldr r1, =_edata
  ldr r2, =_sidata
  movs r3, #0
  b LoopCopyDataInit

CopyDataInit:
  ldr r4, [r2, r3]
  str r4, [r0, r3]
  adds r3, r3, #4

LoopCopyDataInit:
  adds r4, r0, r3
  cmp r4, r1
  bcc CopyDataInit
  
/* Zero fill the bss segment. */
  ldr r2, =_sbss
  ldr r4, =_ebss
  movs r3, #0
  b LoopFillZerobss

FillZerobss:
  str  r3, [r2]
  adds r2, r2, #4

LoopFillZerobss:
  cmp r2, r4
  bcc FillZerobss

/* Call the clock system initialization function.*/
  bl  SystemInit   
/* Call static constructors */
    bl __libc_init_array
/* Call the application's entry point.*/
  bl  main
  bx  lr    
.size  Reset_Handler, .-Reset_Handler

/**
 * @brief  This is the code that gets called when the processor receives an 
 *         unexpected interrupt.  This simply enters an infinite loop, preserving
 *         the system state for examination by a debugger.
 * @param  None     
 * @retval None       
*/
    .section  .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
  b  Infinite_Loop
  .size  Default_Handler, .-Default_Handler
/******************************************************************************
*
* The minimal vector table for a Cortex M3. Note that the proper constructs
* must be placed on this to ensure that it ends up at physical address
* 0x0000.0000.
* 
*******************************************************************************/
   .section  .isr_vector,"a",%progbits
  .type  g_pfnVectors, %object
  .size  g_pfnVectors, .-g_pfnVectors
    
g_pfnVectors:
  .word  _estack
  .word  Reset_Handler
  .word  NMI_Handler
  .word  HardFault_Handler
  .word  MemManage_Handler
  .word  BusFault_Handler
  .word  UsageFault_Handler
  .word  0
  .word  0
  .word  0
  .word  0
  .word  SVC_Handler
  .word  DebugMon_Handler
  .word  0
  .word  PendSV_Handler
  .word  SysTick_Handler
  
 
    /* External interrupt*/
                .word    Reserved_Handler                   /*  0  */
                .word    Reserved_Handler                   /*  1  */
                .word    Reserved_Handler                   /*  2  */
                .word    Reserved_Handler                   /*  3  */
                .word    Reserved_Handler                   /*  4  */
                .word    Reserved_Handler                   /*  5  */
                .word    Reserved_Handler                   /*  6  */
                .word    Reserved_Handler                   /*  7  */
                .word    Reserved_Handler                   /*  8  */
                .word    Reserved_Handler                   /*  9  */
                .word    Reserved_Handler                   /* 10  */
                .word    Reserved_Handler                   /* 11  */
                .word    Reserved_Handler                   /* 12  */
                .word    Reserved_Handler                   /* 13  */
                .word    Reserved_Handler                   /* 14  */
                .word    Reserved_Handler                   /* 15  */
                .word    Reserved_Handler                   /* 16  */
                .word    Reserved_Handler                   /* 17  */
                .word    Reserved_Handler                   /* 18  */
                .word    Reserved_Handler                   /* 19  */
                .word    Reserved_Handler                   /* 20  */
                .word    Reserved_Handler                   /* 21  */
                .word    Reserved_Handler                   /* 22  */
                .word    Reserved_Handler                   /* 23  */
                .word    Reserved_Handler                   /* 24  */
                .word    Reserved_Handler                   /* 25  */
                .word    Reserved_Handler                   /* 26  */
                .word    Reserved_Handler                   /* 27  */
                .word    Reserved_Handler                   /* 28  */
                .word    Reserved_Handler                   /* 29  */
                .word    Reserved_Handler                   /* 30  */
                .word    Reserved_Handler                   /* 31  */
                .word    Reserved_Handler                   /* 32  */
                .word    Reserved_Handler                   /* 33  */
                .word    Reserved_Handler                   /* 34  */
                .word    Reserved_Handler                   /* 35  */
                .word    Reserved_Handler                   /* 36  */
                .word    Reserved_Handler                   /* 37  */
                .word    Reserved_Handler                   /* 38  */
                .word    Reserved_Handler                   /* 39  */
                .word    Reserved_Handler                   /* 40  */
                .word    Reserved_Handler                   /* 41  */
                .word    Reserved_Handler                   /* 42  */
                .word    Reserved_Handler                   /* 43  */
                .word    Reserved_Handler                   /* 44  */
                .word    Reserved_Handler                   /* 45  */
                .word    Reserved_Handler                   /* 46  */
                .word    Reserved_Handler                   /* 47  */
                .word    Reserved_Handler                   /* 48  */
                .word    Reserved_Handler                   /* 49  */
                .word    Reserved_Handler                   /* 50  */
                .word    Reserved_Handler                   /* 51  */
                .word    Reserved_Handler                   /* 52  */
                .word    Reserved_Handler                   /* 53  */
                .word    Reserved_Handler                   /* 54  */
                .word    Reserved_Handler                   /* 55  */
                .word    Reserved_Handler                   /* 56  */
                .word    Reserved_Handler                   /* 57  */
                .word    Reserved_Handler                   /* 58  */
                .word    Reserved_Handler                   /* 59  */
                .word    Reserved_Handler                   /* 60  */
                .word    Reserved_Handler                   /* 61  */
                .word    Reserved_Handler                   /* 62  */
                .word    Reserved_Handler                   /* 63  */
                .word    Reserved_Handler                   /* 64  */
                .word    Reserved_Handler                   /* 65  */
                .word    Reserved_Handler                   /* 66  */
                .word    Reserved_Handler                   /* 67  */
                .word    Reserved_Handler                   /* 68  */
                .word    Reserved_Handler                   /* 69  */
                .word    Reserved_Handler                   /* 70  */
                .word    Reserved_Handler                   /* 71  */
                .word    Reserved_Handler                   /* 72  */
                .word    Reserved_Handler                   /* 73  */
                .word    Reserved_Handler                   /* 74  */
                .word    Reserved_Handler                   /* 75  */
                .word    Reserved_Handler                   /* 76  */
                .word    Reserved_Handler                   /* 77  */
                .word    Reserved_Handler                   /* 78  */
                .word    Reserved_Handler                   /* 79  */
                .word    Reserved_Handler                   /* 80  */
                .word    Reserved_Handler                   /* 81  */
                .word    Reserved_Handler                   /* 82  */
                .word    Reserved_Handler                   /* 83  */
                .word    Reserved_Handler                   /* 84  */
                .word    Reserved_Handler                   /* 85  */
