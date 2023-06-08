const int trigPin = 9;   // Trigger pin connected to Arduino digital pin 2
const int echoPin = 10;  // Echo pin connected to Arduino digital pin 3
const int buzzerPin = 2; // Pin connected to the positive terminal of the buzzer
const int greenLedPin = 3;
const int redLedPin = 4;

void setup() {
    Serial.begin(9600); // Initialize serial communication
    pinMode(trigPin, OUTPUT);
    pinMode(echoPin, INPUT);
    pinMode(buzzerPin, OUTPUT); // Set the buzzer pin as an output
    pinMode(greenLedPin, OUTPUT);
    pinMode(redLedPin, OUTPUT);
}

void loop() {
    digitalWrite(greenLedPin, HIGH);
    long duration, distance;

    // Generate a pulse to the trigger pin20
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);

    // Measure the duration of the pulse on the echo pin
    duration = pulseIn(echoPin, HIGH);

    // Calculate the distance in centimeters
    distance = duration * 0.034 / 2;

    if (distance < 20) {
        tone(buzzerPin, 3500); // Change the frequency to adjust the tone
        digitalWrite(redLedPin, HIGH);
    } else {
        noTone(buzzerPin);
        digitalWrite(redLedPin, LOW);
    }

    delay(50);
}
