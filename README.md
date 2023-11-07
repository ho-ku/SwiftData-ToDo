# SwiftData Todo

## Introduction
This is a simple ToDo application made fully by using SwiftData.

## App Overview
The app generally consists of two screens:
1. Tasks List screen - a list of all the tasks for a specific date. User can edit/add/delete task.
2. Setting screen - a users task completion statistics.
App utilizes such SwiftData functionality as:
- Query. In order to fetch tasks Query property wrapper is used;
- Predicate - to sort tasks;
- ModelContainer (with enabled iCloud support).

App stores tasks both locally and in iCloud. Image data for each note is encrypted in Cloud. 

## Architecture
App architecture is MVVM. App is built 100% in SwiftUI. 
To create tasks, delete tasks and fetch tasks count there is `NotesRepository` object.
Pattern Service Locator was used in order to provide Dependency Injection functionality. All dependencies are registered on the app launch.

## Contact Information
Email: hoku.dev01@gmail.com<br>
[Telegram](https://t.me/justHoku)
