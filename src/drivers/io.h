
#ifndef __IO_H
#define __IO_H

#include "memory_f411.h"
#include "../common/define.h"

//Define the io button


typedef enum{
  LOW = 2,
  HIGH
}io_state_e;

typedef enum{
  IO_PIN_0,
  IO_PIN_1,
  IO_PIN_2,
  IO_PIN_3,
  IO_PIN_4,
  IO_PIN_5,
  IO_PIN_6,
  IO_PIN_7,
  IO_PIN_8,
  IO_PIN_9,
  IO_PIN_10,
  IO_PIN_11,
  IO_PIN_12, 
  IO_PIN_13,
  IO_PIN_14,
  IO_PIN_15
}io_pin_e;



void io_init(void);
s_state_e io_out(GPIO_TypeDef *pGPIOx, io_pin_e pinNumber, io_state_e outState);
io_state_e io_read(GPIO_TypeDef *pGPIOx, io_pin_e pinNumber);


#endif
