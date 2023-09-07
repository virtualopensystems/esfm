// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XKRNL_HELM_H
#define XKRNL_HELM_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xkrnl_helm_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Control_BaseAddress;
} XKrnl_helm_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XKrnl_helm;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XKrnl_helm_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XKrnl_helm_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XKrnl_helm_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XKrnl_helm_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XKrnl_helm_Initialize(XKrnl_helm *InstancePtr, u16 DeviceId);
XKrnl_helm_Config* XKrnl_helm_LookupConfig(u16 DeviceId);
int XKrnl_helm_CfgInitialize(XKrnl_helm *InstancePtr, XKrnl_helm_Config *ConfigPtr);
#else
int XKrnl_helm_Initialize(XKrnl_helm *InstancePtr, const char* InstanceName);
int XKrnl_helm_Release(XKrnl_helm *InstancePtr);
#endif

void XKrnl_helm_Start(XKrnl_helm *InstancePtr);
u32 XKrnl_helm_IsDone(XKrnl_helm *InstancePtr);
u32 XKrnl_helm_IsIdle(XKrnl_helm *InstancePtr);
u32 XKrnl_helm_IsReady(XKrnl_helm *InstancePtr);
void XKrnl_helm_Continue(XKrnl_helm *InstancePtr);
void XKrnl_helm_EnableAutoRestart(XKrnl_helm *InstancePtr);
void XKrnl_helm_DisableAutoRestart(XKrnl_helm *InstancePtr);

void XKrnl_helm_Set_in_r(XKrnl_helm *InstancePtr, u64 Data);
u64 XKrnl_helm_Get_in_r(XKrnl_helm *InstancePtr);
void XKrnl_helm_Set_out_r(XKrnl_helm *InstancePtr, u64 Data);
u64 XKrnl_helm_Get_out_r(XKrnl_helm *InstancePtr);
void XKrnl_helm_Set_num_times(XKrnl_helm *InstancePtr, u32 Data);
u32 XKrnl_helm_Get_num_times(XKrnl_helm *InstancePtr);

void XKrnl_helm_InterruptGlobalEnable(XKrnl_helm *InstancePtr);
void XKrnl_helm_InterruptGlobalDisable(XKrnl_helm *InstancePtr);
void XKrnl_helm_InterruptEnable(XKrnl_helm *InstancePtr, u32 Mask);
void XKrnl_helm_InterruptDisable(XKrnl_helm *InstancePtr, u32 Mask);
void XKrnl_helm_InterruptClear(XKrnl_helm *InstancePtr, u32 Mask);
u32 XKrnl_helm_InterruptGetEnabled(XKrnl_helm *InstancePtr);
u32 XKrnl_helm_InterruptGetStatus(XKrnl_helm *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
