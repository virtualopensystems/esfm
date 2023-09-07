// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xkrnl_helm.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XKrnl_helm_CfgInitialize(XKrnl_helm *InstancePtr, XKrnl_helm_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XKrnl_helm_Start(XKrnl_helm *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL) & 0x80;
    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XKrnl_helm_IsDone(XKrnl_helm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XKrnl_helm_IsIdle(XKrnl_helm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XKrnl_helm_IsReady(XKrnl_helm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XKrnl_helm_Continue(XKrnl_helm *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL) & 0x80;
    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL, Data | 0x10);
}

void XKrnl_helm_EnableAutoRestart(XKrnl_helm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XKrnl_helm_DisableAutoRestart(XKrnl_helm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_AP_CTRL, 0);
}

void XKrnl_helm_Set_in_r(XKrnl_helm *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IN_R_DATA, (u32)(Data));
    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IN_R_DATA + 4, (u32)(Data >> 32));
}

u64 XKrnl_helm_Get_in_r(XKrnl_helm *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IN_R_DATA);
    Data += (u64)XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IN_R_DATA + 4) << 32;
    return Data;
}

void XKrnl_helm_Set_out_r(XKrnl_helm *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_OUT_R_DATA, (u32)(Data));
    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_OUT_R_DATA + 4, (u32)(Data >> 32));
}

u64 XKrnl_helm_Get_out_r(XKrnl_helm *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_OUT_R_DATA);
    Data += (u64)XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_OUT_R_DATA + 4) << 32;
    return Data;
}

void XKrnl_helm_Set_num_times(XKrnl_helm *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_NUM_TIMES_DATA, Data);
}

u32 XKrnl_helm_Get_num_times(XKrnl_helm *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_NUM_TIMES_DATA);
    return Data;
}

void XKrnl_helm_InterruptGlobalEnable(XKrnl_helm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_GIE, 1);
}

void XKrnl_helm_InterruptGlobalDisable(XKrnl_helm *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_GIE, 0);
}

void XKrnl_helm_InterruptEnable(XKrnl_helm *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IER);
    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IER, Register | Mask);
}

void XKrnl_helm_InterruptDisable(XKrnl_helm *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IER);
    XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IER, Register & (~Mask));
}

void XKrnl_helm_InterruptClear(XKrnl_helm *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    //XKrnl_helm_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_ISR, Mask);
}

u32 XKrnl_helm_InterruptGetEnabled(XKrnl_helm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_IER);
}

u32 XKrnl_helm_InterruptGetStatus(XKrnl_helm *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    // Current Interrupt Clear Behavior is Clear on Read(COR).
    return XKrnl_helm_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_HELM_CONTROL_ADDR_ISR);
}

