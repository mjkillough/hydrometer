EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Digital Hydrometer"
Date "2020-11-01"
Rev "1"
Comp "Michael Killough"
Comment1 "Companion board for Wemos D1"
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
Text GLabel 8300 3800 2    50   Input ~ 0
D6
Wire Wire Line
	6050 5150 6650 5150
Text GLabel 6650 5150 2    50   Input ~ 0
GND
Text GLabel 6050 5150 0    50   Input ~ 0
-IN
Wire Wire Line
	6050 4850 6150 4850
NoConn ~ 6550 4950
Wire Wire Line
	6550 4750 6650 4750
Text GLabel 6650 4750 2    50   Input ~ 0
+5V
Text GLabel 6050 4850 0    50   Input ~ 0
+OUT
$Comp
L Switch:SW_SPDT SW1
U 1 1 5F0C877B
P 6350 4850
F 0 "SW1" H 6350 5135 50  0000 C CNN
F 1 "SW_SPDT" H 6350 5044 50  0000 C CNN
F 2 "footprints:SS-12F23-SPDT" H 6350 4850 50  0001 C CNN
F 3 "https://datasheetspdf.com/pdf-file/705135/ETC/SS-12F23-4.5/1" H 6350 4850 50  0001 C CNN
	1    6350 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 4850 5150 4850
Wire Wire Line
	5150 4750 5250 4750
Text GLabel 5250 4850 2    50   Input ~ 0
-IN
Text GLabel 5250 4750 2    50   Input ~ 0
+OUT
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5F0C48C6
P 4950 4750
F 0 "J1" H 4868 4967 50  0000 C CNN
F 1 "Conn_01x02" H 4868 4876 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 4950 4750 50  0001 C CNN
F 3 "~" H 4950 4750 50  0001 C CNN
	1    4950 4750
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8150 3800 8300 3800
Wire Wire Line
	7850 4100 7850 4250
Text GLabel 7850 4250 3    50   Input ~ 0
GND
Wire Wire Line
	7850 3350 7850 3500
Text GLabel 7850 3350 1    50   Input ~ 0
+5V
$Comp
L Sensor_Temperature:DS18B20 U1
U 1 1 5F0C2571
P 7850 3800
F 0 "U1" H 7620 3846 50  0000 R CNN
F 1 "DS18B20" H 7620 3755 50  0000 R CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 6850 3550 50  0001 C CNN
F 3 "http://datasheets.maximintegrated.com/en/ds/DS18B20.pdf" H 7700 4050 50  0001 C CNN
	1    7850 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 4250 6050 4250
Wire Wire Line
	6650 4250 6500 4250
Wire Wire Line
	6500 3850 6650 3850
Wire Wire Line
	6050 3850 6200 3850
Text GLabel 6650 4250 2    50   Input ~ 0
D6
Text GLabel 6050 4250 0    50   Input ~ 0
+5V
Text GLabel 6650 3850 2    50   Input ~ 0
A0
Text GLabel 6050 3850 0    50   Input ~ 0
+5V
Wire Wire Line
	6500 3450 6650 3450
Wire Wire Line
	6050 3450 6200 3450
Text GLabel 6650 3450 2    50   Input ~ 0
RST
Text GLabel 6050 3450 0    50   Input ~ 0
D0
$Comp
L Device:R R3
U 1 1 5F0BC4BC
P 6350 4250
F 0 "R3" V 6557 4250 50  0000 C CNN
F 1 "4.7k" V 6466 4250 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 6280 4250 50  0001 C CNN
F 3 "~" H 6350 4250 50  0001 C CNN
	1    6350 4250
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R2
U 1 1 5F0BC0ED
P 6350 3850
F 0 "R2" V 6557 3850 50  0000 C CNN
F 1 "230k" V 6466 3850 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 6280 3850 50  0001 C CNN
F 3 "~" H 6350 3850 50  0001 C CNN
	1    6350 3850
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 5F0BBA02
P 6350 3450
F 0 "R1" V 6557 3450 50  0000 C CNN
F 1 "470" V 6466 3450 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 6280 3450 50  0001 C CNN
F 3 "~" H 6350 3450 50  0001 C CNN
	1    6350 3450
	0    -1   -1   0   
$EndComp
Text GLabel 5050 3950 2    50   Input ~ 0
GND
Wire Wire Line
	4950 3950 5050 3950
Wire Wire Line
	4950 4050 4950 3950
$Comp
L power:GND #PWR0102
U 1 1 5F0BA0FD
P 4950 4050
F 0 "#PWR0102" H 4950 3800 50  0001 C CNN
F 1 "GND" H 4955 3877 50  0000 C CNN
F 2 "" H 4950 4050 50  0001 C CNN
F 3 "" H 4950 4050 50  0001 C CNN
	1    4950 4050
	1    0    0    -1  
$EndComp
Text GLabel 5050 3750 2    50   Input ~ 0
+5V
Wire Wire Line
	4950 3750 5050 3750
Wire Wire Line
	4950 3650 4950 3750
$Comp
L power:VCC #PWR0101
U 1 1 5F0B966E
P 4950 3650
F 0 "#PWR0101" H 4950 3500 50  0001 C CNN
F 1 "VCC" H 4965 3823 50  0000 C CNN
F 2 "" H 4950 3650 50  0001 C CNN
F 3 "" H 4950 3650 50  0001 C CNN
	1    4950 3650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
