
#include "io.h"



void io_init(void)
{
  
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
