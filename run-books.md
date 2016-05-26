## Messing with Gradle one step at a time

### 00 Initialize a folder with gradle 
 * create a folder
 * install gradle locally, I just used the full path installed at /usr/local/gradle/bin...
 * ^^  use ```gradle init```, this generates a gradlew, and stock default build.gradle and settings.gradle

### 01 Run a stock java hello world
 * uncomment the ```apply plugin: 'java'``` line in the build.gradle file
 * create directory src/main/java/org/gradle/example/simple
 * create HelloWorld.java in that directlry
 * put in the following
```
package org.gradle.example.simple;
    public class HelloWorld {
        public static void main(String args[]) {
        System.out.println(â€œhello, worldâ€);
    }
}
```

 * now run ```gradlew build```
 * now you should have a build directory with full path to build artefacts.
 * to test, run the class from command line with 
```
java -cp build/classes/main/ org.gradle.example.simple.HelloWorld
```
 * Note the cp, and also there are two arguments.
 * the output should be ```hello, world```

### 01.1 Run a stock java hello world via intelliJ
 * open intelliJ
 * Select the _Create New Project_ option
 * From Left pane select *Java*
 * Do not select any boxes under *Additional Libraries and Frameworks*
 * Click [Next]
 * Check the box *Create project from template*
 * Select *Command Line App*
 * Click [Next]
 * Enter the following
    - Project name: hola_mundo
    - Project location: ~/repos/hola_mundo
    - Base package: com.saguaro
 * Click [Next]
 * (Panel)Project->hola_mundo->src->com.saguaro->Main
 * (Tab)Main.java... enter at line with //write your code here
    - System.out.println("hola mundo");
 * (menu)Build/Make project
 * You should now see an 'out' directory at command line root
 * run the project with 
```
java -cp out/production/hola_mundo/ com.saguaro.main
