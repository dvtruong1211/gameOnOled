
#ifndef __DEFINE_H
#define __DEFINE_H

typedef enum{
  S_OK,
  S_ERROR
}s_state_e;

#define write_reg(reg, value)   (reg = (uint32_t)value) 
#define read_reg(reg, mask)     (reg & (uint32_t)mask)










#endif 
