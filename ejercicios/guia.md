SIMD
---
### Multi de ints: 
arrancan con $p$ (de packed)

### Multi de fpu: 

tienen $ss$, $sd$ (de scalar), $ps$ ó $pd$ (de packed)

Si hay una "$x$" minúscula es porque tiene muchas variantes

### Lectura escritura

MOVx (D, Q, SS ó SD) (lo que no toqué le pone 0s)
MOVDQA MODQU (aligned/unaligned)
MOVAx MOVUx (PS o PD) (aligned/unaligned)               <cualquier MOV puede escribir a memoria>
PMOVSXBW (BW, BD, BQ, WD, WQ o DQ) (extend con signo)   <cualquier PMOV no puede escribir a memoria>
PMOVZXBW (BW, BD, BQ, WD, WQ o DQ) (extend con 0s)


Aritméticas
PADDx (B, W, D o Q)
PSUBx (B, W, D o Q)
PMULHW         (parte alta de multiplicación, PMULHD no existe)      
PMULLx (W o D) (parte baja de multiplicación)
PMINx (SB, SW, SD, UB, UW, UD) (saturated/unsaturated)
PMAXx (SB, SW, SD, UB, UW, UD)
PABSx (B, W, D o Q)             > ABS para floats no existe, usar shifts left y right!
PADDSx PADDUSx (B o W)    (signed/unsigned saturated)
PSUBSx PSUBUSx (B o W)
PHADDx (W, D o SW) (horizontal, saturated)
PHSUBx (W, D o SW) (horizontal, saturated)
ADDx (SS, SD, PS o PD)
SUBx (SS, SD, PS o PD)
MULx (SS, SD, PS o PD)
DIVx (SS, SD, PS o PD)
MINx (SS, SD, PS o PD)
MAXx (SS, SD, PS o PD)
SQRTx (SS, SD, PS o PD)
HADDx (PS o PD)
HSUBx (PS o PD)

Logicas
PAND PANDN POR PXOR
ANDx ANDNx ORx XORx (PS o PD)
PSLLx (W, D, Q o DQ) (packed shift left  logico)
PSRLx (W, D, Q o DQ) (packed shift right logico)
PSRAx (W o D)        (packed shift right aritmetico)

Comparaciones
PCMPEQx (B, W, D o Q)   (comparación signada, si tenés unsigned, corregir con PADD)
PCMPGTx (B, W, D o Q)   (copmaración signada, si tenés unsigned, corregir con PADD)

Blend (hay varios)
BLENDPD  (con dos registros y un inmediato de 8 bits)
BLENDVPD (con dos registros y una máscara implícita en xmm0)
PBLENDVB (con dos registros y una máscara implícita en xmm0)

Otras
PSHUFD (con dos registros y un inmediato de 8 bits, ej 0b00_00_00_00)
PSHUFB (con dos registros, el 2do con pos de cada byte (0 a 15), útil usar -1 para limpiar)

Conversiones
CVTDQ2PS    (xmm0 de ints a floats)
CVTPS2DQ    (xmm0 de floats a ints)
CVTTPS2DQ   (idem truncando)
CVTSI2PI  (hay muchos)
PACKSSWB PACKUSWB (signed/unsigned saturation de words a byte)
PACKSSDW          (de dw a w)