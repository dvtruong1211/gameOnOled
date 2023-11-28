
#include "io.h"

uint32_t tempreg;

void io_init(void)
{
  //Enable clock for gpio port
  GPIOD_CLOCK_ENABLE();
  //Configure pin as input pin
  //uint32_t tempreg;
  tempreg = read_reg(GPIOD->MODER, ~((uint32_t)(0x03 << 2*BT_LEFT) | (uint32_t)(0x03 << 2*BT_RIGHT) | (uint32_t)(0x03 << 2*BT_MID)));
  tempreg = tempreg | ((IO_MODE_INPUT << 2*BT_LEFT) | (IO_MODE_INPUT << 2*BT_RIGHT)  | (IO_MODE_INPUT << 2*BT_MID));
  write_reg(GPIOD->MODER, tempreg);

  //Enable pull up
  tempreg = read_reg(GPIOD->PUPDR, ~((uint32_t)(0x03 << 2*BT_LEFT) | (uint32_t)(0x03 << 2*BT_RIGHT) | (uint32_t)(0x03 << 2*BT_MID)));
  tempreg = tempreg | ((IO_PULL_UP << 2*BT_LEFT) | (IO_PULL_UP << 2*BT_RIGHT) | (IO_PULL_UP << 2*BT_MID));
  write_reg(GPIOD->PUPDR, tempreg);
  
}

s_state_e io_out(GPIO_TypeDef *pGPIOx, io_pin_e pinNumber, io_state_e outState)
{
  if(outState == HIGH){
    pGPIOx->BSRR |= (1U << pinNumber);
  }
  else if(outState == LOW){
    pGPIOx->BSRR |= ((1U << 16) << pinNumber);
  }
  else
    return S_ERROR;
  return S_OK;
}

io_state_e io_read(GPIO_TypeDef *pGPIOx, io_pin_e pinNumber)
{
  if(pGPIOx->IDR & (1U << pinNumber))
    return  HIGH;
  else
    return LOW;
}
