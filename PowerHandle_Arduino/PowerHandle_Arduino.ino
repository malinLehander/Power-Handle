#include <ArduinoBLE.h> 
#include <Q2HX711.h>

 
const byte hx711_data_pin = 3;
const byte hx711_clock_pin = 4;

Q2HX711 hx711(hx711_data_pin, hx711_clock_pin); 

BLEService handleService("34802252-7185-4d5d-b431-630e7050e8f0");
BLEFloatCharacteristic handleChar("34802252-7185-4d5d-b431-630e7050e8f0", BLERead | BLENotify); 

int initValue = 0; 

void setup() {  
  
  //Serial.begin(9600);
  //while (!Serial); 

  if(!BLE.begin()){
    //Serial.println("starting BLE failed!");
    while (1);
  }

  BLE.setLocalName("Arduino");
  BLE.setAdvertisedService(handleService.uuid());
  
  handleService.addCharacteristic(handleChar);
  BLE.addService(handleService);
  
  //handleChar.writeValue(initValue);

  //start advertising
  BLE.advertise(); 
  //Serial.println("Bluetooth device active, waiting for connections...");
}

void loop() {
    // wait for a BLE central
    BLEDevice central = BLE.central(); 
    
    // if a central is connected to the peripheral:
    if(central) {
      //Serial.print("Connected to central: ");
      //Serial.println(central.address());

      while(central.connected()){
        int ourvalue = hx711.read()/1000; 
        const uint8_t list[4] = {1,2,3,4};  
        //Serial.println(hx711.read()/1000);
        handleChar.writeValue(ourvalue);
        }

       //Serial.print("Disconnected from central: ");
       //Serial.println(central.address());
      }    
}
