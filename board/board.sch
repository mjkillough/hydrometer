EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L board-rescue:CONN_01X08-board-rescue P1
U 1 1 5763EB78
P 9650 1400
F 0 "P1" H 9650 1850 50  0000 C CNN
F 1 "CONN_01X08" V 9750 1400 50  0000 C CNN
F 2 "D1_mini:D1_mini_Pin_Header" H 9650 1400 50  0001 C CNN
F 3 "" H 9650 1400 50  0000 C CNN
	1    9650 1400
	1    0    0    -1  
$EndComp
$Comp
L board-rescue:CONN_01X08-board-rescue P2
U 1 1 5763EBF2
P 10100 1400
F 0 "P2" H 10100 1850 50  0000 C CNN
F 1 "CONN_01X08" V 10200 1400 50  0000 C CNN
F 2 "D1_mini:D1_mini_Pin_Header" H 10100 1400 50  0001 C CNN
F 3 "" H 10100 1400 50  0000 C CNN
	1    10100 1400
	-1   0    0    -1  
$EndComp
Text Label 9450 1050 2    60   ~ 0
+5V
Text Label 9450 1150 2    60   ~ 0
GND
Text Label 9450 1250 2    60   ~ 0
D4
Text Label 9450 1350 2    60   ~ 0
D3
Text Label 9450 1450 2    60   ~ 0
D2
Text Label 9450 1550 2    60   ~ 0
D1
Text Label 9450 1650 2    60   ~ 0
RX
Text Label 9450 1750 2    60   ~ 0
TX
Text Label 10300 1050 0    60   ~ 0
+3.3V
Text Label 10300 1150 0    60   ~ 0
D8
Text Label 10300 1250 0    60   ~ 0
D7
Text Label 10300 1350 0    60   ~ 0
D6
Text Label 10300 1450 0    60   ~ 0
D5
Text Label 10300 1550 0    60   ~ 0
D0
Text Label 10300 1650 0    60   ~ 0
A0
Text Label 10300 1750 0    60   ~ 0
RST
Text Notes 9200 1250 2    60   ~ 0
GPIO2
Text Notes 9200 1350 2    60   ~ 0
GPIO0
Text Notes 9200 1450 2    60   ~ 0
GPIO4
Text Notes 9200 1550 2    60   ~ 0
GPIO5
Text Notes 10650 1150 0    60   ~ 0
GPIO15
Text Notes 10650 1250 0    60   ~ 0
GPIO13
Text Notes 10650 1350 0    60   ~ 0
GPIO12
Text Notes 10650 1450 0    60   ~ 0
GPIO14
Text Notes 10650 1550 0    60   ~ 0
GPIO16
Wire Notes Line
	8500 500  8500 2100
Wire Notes Line
	8500 2100 11200 2100
Text Notes 8550 600  0    60   ~ 0
D1 Mini Shield
$Comp
L power:VCC #PWR0101
U 1 1 5F0B966E
P 1100 1250
F 0 "#PWR0101" H 1100 1100 50  0001 C CNN
F 1 "VCC" H 1115 1423 50  0000 C CNN
F 2 "" H 1100 1250 50  0001 C CNN
F 3 "" H 1100 1250 50  0001 C CNN
	1    1100 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 1250 1100 1350
Wire Wire Line
	1100 1350 1200 1350
Text GLabel 1200 1350 2    50   Input ~ 0
+5V
$Comp
L power:GND #PWR0102
U 1 1 5F0BA0FD
P 1100 1650
F 0 "#PWR0102" H 1100 1400 50  0001 C CNN
F 1 "GND" H 1105 1477 50  0000 C CNN
F 2 "" H 1100 1650 50  0001 C CNN
F 3 "" H 1100 1650 50  0001 C CNN
	1    1100 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 1650 1100 1550
Wire Wire Line
	1100 1550 1200 1550
Text GLabel 1200 1550 2    50   Input ~ 0
GND
$Comp
L Device:R R1
U 1 1 5F0BBA02
P 2500 1050
F 0 "R1" V 2707 1050 50  0000 C CNN
F 1 "470" V 2616 1050 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 2430 1050 50  0001 C CNN
F 3 "~" H 2500 1050 50  0001 C CNN
	1    2500 1050
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R2
U 1 1 5F0BC0ED
P 2500 1450
F 0 "R2" V 2707 1450 50  0000 C CNN
F 1 "230k" V 2616 1450 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 2430 1450 50  0001 C CNN
F 3 "~" H 2500 1450 50  0001 C CNN
	1    2500 1450
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R3
U 1 1 5F0BC4BC
P 2500 1850
F 0 "R3" V 2707 1850 50  0000 C CNN
F 1 "4.7k" V 2616 1850 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 2430 1850 50  0001 C CNN
F 3 "~" H 2500 1850 50  0001 C CNN
	1    2500 1850
	0    -1   -1   0   
$EndComp
Text GLabel 2200 1050 0    50   Input ~ 0
D0
Text GLabel 2800 1050 2    50   Input ~ 0
RST
Wire Wire Line
	2200 1050 2350 1050
Wire Wire Line
	2650 1050 2800 1050
Text GLabel 2200 1450 0    50   Input ~ 0
+5V
Text GLabel 2800 1450 2    50   Input ~ 0
A0
Text GLabel 2200 1850 0    50   Input ~ 0
+5V
Text GLabel 2800 1850 2    50   Input ~ 0
D6
Wire Wire Line
	2200 1450 2350 1450
Wire Wire Line
	2650 1450 2800 1450
Wire Wire Line
	2800 1850 2650 1850
Wire Wire Line
	2350 1850 2200 1850
$Comp
L Sensor_Temperature:DS18B20 U1
U 1 1 5F0C2571
P 4000 1400
F 0 "U1" H 3770 1446 50  0000 R CNN
F 1 "DS18B20" H 3770 1355 50  0000 R CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 3000 1150 50  0001 C CNN
F 3 "http://datasheets.maximintegrated.com/en/ds/DS18B20.pdf" H 3850 1650 50  0001 C CNN
	1    4000 1400
	1    0    0    -1  
$EndComp
Text GLabel 4000 950  1    50   Input ~ 0
+5V
Wire Wire Line
	4000 950  4000 1100
Text GLabel 4000 1850 3    50   Input ~ 0
GND
Wire Wire Line
	4000 1700 4000 1850
Text GLabel 4450 1400 2    50   Input ~ 0
D6
Wire Wire Line
	4300 1400 4450 1400
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5F0C48C6
P 1100 2350
F 0 "J1" H 1018 2567 50  0000 C CNN
F 1 "Conn_01x02" H 1018 2476 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1100 2350 50  0001 C CNN
F 3 "~" H 1100 2350 50  0001 C CNN
	1    1100 2350
	-1   0    0    -1  
$EndComp
Text GLabel 1400 2350 2    50   Input ~ 0
+OUT
Text GLabel 1400 2450 2    50   Input ~ 0
-IN
Wire Wire Line
	1300 2350 1400 2350
Wire Wire Line
	1400 2450 1300 2450
$Comp
L Switch:SW_SPDT SW1
U 1 1 5F0C877B
P 2500 2450
F 0 "SW1" H 2500 2735 50  0000 C CNN
F 1 "SW_SPDT" H 2500 2644 50  0000 C CNN
F 2 "footprints:SS-12F23-SPDT" H 2500 2450 50  0001 C CNN
F 3 "https://datasheetspdf.com/pdf-file/705135/ETC/SS-12F23-4.5/1" H 2500 2450 50  0001 C CNN
	1    2500 2450
	1    0    0    -1  
$EndComp
Text GLabel 2200 2450 0    50   Input ~ 0
+OUT
Text GLabel 2800 2350 2    50   Input ~ 0
+5V
Wire Wire Line
	2700 2350 2800 2350
NoConn ~ 2700 2550
Wire Wire Line
	2200 2450 2300 2450
Text GLabel 2200 2750 0    50   Input ~ 0
-IN
Text GLabel 2800 2750 2    50   Input ~ 0
GND
Wire Wire Line
	2200 2750 2800 2750
$EndSCHEMATC
