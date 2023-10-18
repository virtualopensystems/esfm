// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xkrnl_helm.h"

extern XKrnl_helm_Config XKrnl_helm_ConfigTable[];

XKrnl_helm_Config *XKrnl_helm_LookupConfig(u16 DeviceId) {
	XKrnl_helm_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XKRNL_HELM_NUM_INSTANCES; Index++) {
		if (XKrnl_helm_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XKrnl_helm_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XKrnl_helm_Initialize(XKrnl_helm *InstancePtr, u16 DeviceId) {
	XKrnl_helm_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XKrnl_helm_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XKrnl_helm_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

