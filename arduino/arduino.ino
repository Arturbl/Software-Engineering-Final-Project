#include <WiFiNINA.h>
#include <ArduinoHttpClient.h>
#include <ArduinoJson.h>
#include <Arduino.h>
#include <WiFiServer.h>

const int trigPin = 9;
const int echoPin = 10;
const int buzzerPin = 2;
const int greenLedPin = 3;
const int redLedPin = 4;

int username = 1;

const char* ssid = "MEO-2869B0";
const char* password = "5da3ff6c92"; 

WiFiClient wifiClient;
WiFiServer server(80);
HttpClient http(wifiClient, "192.168.1.78", 3001);

enum State {
  IDLE,
  MEASURE_DISTANCE,
  CHECK_DISTANCE,
  TRIGGER_ALARM,
  SEND_REQUEST,
  WAIT_RESPONSE,
  TURN_OFF
};

State currentState = IDLE;
unsigned long previousMillis = 0;
unsigned long measureInterval = 50;
unsigned long requestInterval = 1000;

void setup() {
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(buzzerPin, OUTPUT);
  pinMode(greenLedPin, OUTPUT);
  pinMode(redLedPin, OUTPUT);

  if (WiFi.status() == WL_NO_MODULE) {
    Serial.println("Communication with WiFi module failed!");
    while (true);
  }

  String fv = WiFi.firmwareVersion();
  if (fv < "1.0.0") {
    Serial.println("Please upgrade the firmware");
  }

  while (true) {
    if (WiFi.begin(ssid, password) == WL_CONNECTED) {
      break;
    } else {
      Serial.println("Connection Failed! Retrying...");
      delay(5000);
    }
  }

  server.begin();

  Serial.println("Connected to the WiFi network");
}

void loop() {
  unsigned long currentMillis = millis();

  switch (currentState) {
    case IDLE:
      if (currentMillis - previousMillis >= measureInterval) {
        previousMillis = currentMillis;
        currentState = MEASURE_DISTANCE;
      }
      break;

    case MEASURE_DISTANCE:
      digitalWrite(greenLedPin, HIGH);

      long duration, distance;

      digitalWrite(trigPin, LOW);
      delayMicroseconds(2);
      digitalWrite(trigPin, HIGH);
      delayMicroseconds(10);
      digitalWrite(trigPin, LOW);

      duration = pulseIn(echoPin, HIGH);
      distance = duration * 0.034 / 2;

      if (distance < 20) {
        tone(buzzerPin, 1000);
        digitalWrite(redLedPin, HIGH);
        currentState = CHECK_DISTANCE;
      } else {
        currentState = IDLE;
      }
      break;

    case CHECK_DISTANCE:
      if (currentMillis - previousMillis >= measureInterval) {
        previousMillis = currentMillis;
        currentState = TRIGGER_ALARM;
      }
      break;

    case TRIGGER_ALARM:
      triggerAlarm();
      currentState = SEND_REQUEST;
      break;

    case SEND_REQUEST:
      if (currentMillis - previousMillis >= requestInterval) {
        previousMillis = currentMillis;
        http.beginRequest();
        http.post("/api/user/create_user");
        http.sendHeader("Content-Type", "application/json");

        int httpResponseCode = http.responseStatusCode();
        if (httpResponseCode > 0) {
          Serial.print("HTTP Response code: ");
          Serial.println(httpResponseCode);

          if (http.available()) {
            String response = http.responseBody();
            Serial.println("Response:");
            Serial.println(response);
          }
        } else {
          Serial.print("Error in HTTP request. HTTP Response code: ");
          Serial.println(httpResponseCode);
        }

        currentState = WAIT_RESPONSE;
      }
      break;

    case WAIT_RESPONSE:
      currentState = IDLE;
      break;

    case TURN_OFF:
      currentState = IDLE;
      break;
  }

  turnAlarmOff();
  
}

void turnAlarmOff() {
  WiFiClient client = server.available();
  if (client) {
    String request = client.readStringUntil('\r');
    client.flush();

    if (request.indexOf("/arduino/off") != -1) {
      currentState = TURN_OFF;
      noTone(buzzerPin);
      digitalWrite(redLedPin, LOW);
    }

    client.println("HTTP/1.1 200 OK");
    client.println("Content-Type: text/html");
    client.println();
    client.println("<h1>Hello from Arduino!</h1>");
    client.stop();
  }
}

void triggerAlarm() {
  if (WiFi.status() == WL_CONNECTED) {
    StaticJsonDocument<200> jsonDocument;
    jsonDocument["username"] = "teste";
    jsonDocument["password"] = "mateus";
    jsonDocument["nif"] = "241144949";

    String requestBody;
    serializeJson(jsonDocument, requestBody);

    http.beginRequest();
    http.post("/api/user/create_user");
    http.sendHeader("Content-Type", "application/json");
    http.sendHeader("Content-Length", String(requestBody.length()));
    http.beginBody();
    http.print(requestBody);
    http.endRequest();
  } else {
    Serial.println("Error in WiFi connection");
  }
}
