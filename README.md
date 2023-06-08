# Software Engineering Final Project

This project is a comprehensive system that involves an Arduino board, a Node.js API, a Flutter mobile application, and a PostgreSQL database. The purpose of this system is to capture data using an Arduino's camera and sensor, send it to the API, store it in the database, and provide a user-friendly interface through the mobile application.

## Components

The project consists of the following components:

1. Arduino: The Arduino board is equipped with a camera and a sensor. It captures data from the surroundings and communicates with the API to send the collected data.

2. Node.js API: The API acts as an intermediary between the Arduino and the Flutter application. It receives data from the Arduino, processes it, and stores it in the PostgreSQL database. Additionally, it provides endpoints for the Flutter application to retrieve data.

3. Docker: Both the Node.js API and the PostgreSQL database are hosted in separate Docker containers. Docker enables easy deployment and management of these components, ensuring portability and scalability.

4. Flutter Mobile App: The Flutter application provides a user-friendly interface to interact with the system. It allows users to view the captured data, receive real-time updates, and interact with the Arduino.

5. PostgreSQL Database: The database stores the collected data in a structured manner. It provides persistent storage and allows efficient retrieval and analysis of the captured data.

## Usage

To use the system, follow these steps:

1. Set up the Arduino board, connect the camera and sensor, and ensure it is properly powered.

2. Clone the repository containing the Node.js API and navigate to its directory.

   ```bash
   git clone <repository_url>
   cd <repository_directory>

3. Build and run the Docker container for the Node.js API.
   
      ```bash
      cd <repository_directory>
      npm install
      npm start
    
4. Clone the repository containing the Flutter mobile application and navigate to its directory.

    ```bash
   cd <repository_directory>
   flutter run -d [device]

5. Ensure that the Docker container for the PostgreSQL database is running.

    ```bash
    cd PostgresSQL
   docker-compose build --no-cache
   docker-compose up -d    
    
