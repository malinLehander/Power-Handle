# Power-Handle
The Power Handle measures forces in the perpendicular direction of the shaft. 
The device is connected to an app and is meant for measuring pulls and pushes (currently only pushes).
The Power Handle is a handle that one can attach to an object which one wants to push. 
The Power Handle consists of strain gauges arranged in a load cell configuration between two plastic plates that are connected via a wooden shaft to a wooden handle.

When the tool is used, the user opens the app and connects to the device in the “Settings” view. 
On the “Home” screen the user specifies whether he/she wants "pulls" or "pushes" to be measured. As of now, the user can only choose to do a push measurement. 
Pressing "Start", will start the measurements of the tool. When the user has finished the measurement, he/she presses "Quit & Save". 
The app summarizes the measured values. The measurement is then saved in a history list where the measurement is named by date and time, e.g. ”3 Jan 2022 10:53”. 
The list can be found in the “History” view. 
When a measurement is chosen, the measurement is presented in a graph of the effort (Newton) over the time (seconds), and also the mean value can be seen. 
It is also possible to delete measurements in the history list. 

The set-up of the Power Handle: 
![PowerHandle1](https://user-images.githubusercontent.com/97241022/148410238-9c582845-959c-483b-aea6-386b4eb30203.png)

![PowerHandle2](https://user-images.githubusercontent.com/97241022/148410680-423caf23-0b3f-4ac4-888a-2308b4302854.png)

PCB board: (with Sparkfun Load Cell Amplifier, connectors to the load cells and Arduino Nano BLE) 
![PCB](https://user-images.githubusercontent.com/97241022/148410987-99d236c8-71f9-40a0-a14f-76727e5429d0.png)

