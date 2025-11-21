# Wi-Fi Hotspot + Scan Control Scripts

This repository contains two Windows batch scripts that let you manually enable the built-in **Mobile Hotspot** feature and automatically toggle **Wi-Fi network scanning (AutoConfig)** on or off. These scripts are useful when you want to run a stable local hotspot without Windows continuously scanning for networks in the background.

---

## 📦 Included Files

### **1. `Hotspot_ManualThenDisableScan.bat`**
A one-click script that:

1. Opens the Windows **Mobile hotspot** settings page  
2. Waits for you to manually turn the hotspot **ON**  
3. Automatically disables Wi-Fi **AutoConfig**, stopping background scanning and auto-join  
4. Leaves the hotspot running

**Purpose:**  
Prevent Windows from scanning for other networks while your hotspot is active, improving stability for certain local-only use cases.

---

### **2. `Reenable_Scanning_HotspotOff.bat`**
A companion script that:

1. Re-enables Windows Wi-Fi **AutoConfig** (normal scanning + auto-join)  
2. Opens the **Mobile hotspot** settings page so you can manually turn the hotspot **OFF**

**Purpose:**  
Restore Windows to normal Wi-Fi operation after hotspot use.

---

## 🚀 Usage

### **Prerequisites**
- Windows 10 or Windows 11  
- Must **Run as Administrator**  
  - Right-click the `.bat` file → **Run as administrator**

### **To Start Hotspot & Disable Scanning**
Run:

