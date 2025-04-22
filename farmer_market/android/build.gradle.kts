plugins {
    id("com.android.application") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false // 🔄 Burayı 1.8.22 yaptık
}

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
        classpath("com.android.tools.build:gradle:8.7.0") // 🔁 Plugin'la aynı versiyon
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}



val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}