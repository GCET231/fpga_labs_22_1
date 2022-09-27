// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : display10x4svh.svh
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Header Description:
//    Arquivo de cabeçalho contendo as constantes para o monitor 10x4.
// -----------------------------------------------------------------------------
`define WholeLine  14   // x usado em [0..WholeLine-1]
`define WholeFrame 7    // y usado em [0..WholeFrame-1]

`define xbits $clog2(`WholeLine)    // quantos bits são necessários para contar x?
`define ybits $clog2(`WholeFrame)   // quantos bits são necessários para contar y?


`define hFrontPorch 1
`define hBackPorch 1
`define hSyncPulse 2
`define vFrontPorch 1
`define vBackPorch 1
`define vSyncPulse 1

`define hSyncPolarity 1'b1
`define vSyncPolarity 1'b1

`define hSyncStart (`WholeLine - `hBackPorch - `hSyncPulse)
`define hSyncEnd (`hSyncStart + `hSyncPulse - 1)
`define vSyncStart (`WholeFrame - `vBackPorch - `vSyncPulse)
`define vSyncEnd (`vSyncStart + `vSyncPulse - 1)

`define hVisible (`WholeLine  - `hFrontPorch - `hSyncPulse - `hBackPorch)
`define vVisible (`WholeFrame - `vFrontPorch - `vSyncPulse - `vBackPorch)
