# Use the official OpenJDK image
FROM openjdk:11

# Set the working directory
WORKDIR /usr/src/app

# Copy the current directory contents into the container
COPY src .

# Compile the Java program
RUN javac HelloWorld.java

# Define the command to run the app
CMD ["java", "main.HelloWorld"]
