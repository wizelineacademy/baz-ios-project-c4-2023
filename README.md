# BAZ iOS Capstone Project C1 2022

Thank you for participating in the Wizeline Academy course!

This README file contains the instructions to complete the capstone project.

## Table of Contents

* [Introduction](#introduction)
* [The Project](#the-project)
* [Requirements](#requirements)
* [Getting Started](#getting-started)
* [App Contents](#app-contents)
* [Deliverables](#deliverables)
* [TheMovieDb API](#themoviedb-api)

## Introduction

This iOS Course is looking to improve your iOS Technical skills. 

At the end of the course, you will have gained enough experience to recall the essence of several techniques related to the skills 
covered in the course, apply them correctly, and even provide shortcuts and quick ways for accomplishing your tasks. 

Additionally, you’ll understand how the technologies internally work and what are the dos and don'ts.


## The Project

The purpose of this project is for you to demonstrate your iOS skills.

This is your chance to show off everything you've learned during the course and to improve your Technical skills.

You will build and deliver a **whole** iOS application on your own.

We don't want to limit you by providing some *fill-in-the-blanks* exercises. Instead, we want you to build it from scratch. 

We hope you find this exercise challenging and engaging.

The goal is to build a `TheMovieDb` client app.

> \*_NOTE:_ Use `f6cd5c1a9e6c6b965fdcab0fa6ddd38a` as the api_key (Include this in your API calls!)\*

You should use this API just as a guide and as a trigger for your own ideas.
`It's not mandatory to use an especific UI component`. 
It is **YOUR** project and you can be creative in the way you build it.

### Requirements

These are the main requirements for your deliverable evaluation:

- Variables, Constants, and Data Types
- Functions and Closures
- Optional Chaining, Optional Binding 
- Swift Collections 
- IDE (XCode)  
- Code Versioning (Git) 
- Value type vs Reference type
- Inheritance, Protocols, Extensions 
- UI Life Cycle
- XIBs and Storyboard
- Views and Controls (UIKit)
- Notification Center
- TableView and CollectionView
- REST Services

## Getting Started

We have provided an Xcode project in this repository.

The provided codebase contain some basic components, you can use it as a guide for structuring your application. Feel free to add, 
remove, or change anything if you consider it necessary.

To get started, follow these steps:

**Step 1:** Clone this repository into your local machine. [Github Setup 
guide](https://docs.github.com/en/get-started/quickstart/set-up-git)

**Step 2:** Create your own `main` branch `main-(your name)-(your lastname)`, example: main-steve-jobs

**Step 3:** Create your own `dev` branch `dev-(your name)-(your lastname)`,
example: dev-steve-jobs

**Step 4:** Create your task branches using `task-(your name)-(your lastname)-description`, example: 
task-steve-jobs-add-network-layer, you must create a PR for any new feature added to your dev branch.

**Step 5:** Commit and push your changes periodically.

**Step 6:** When your deliverables are ready create a PR from your dev to your main branch.

**Step 7:** Have fun!

> \*_NOTE:_ Follow the this workflow for your collaborations 
[https://docs.github.com/en/get-started/quickstart/github-flow](https://docs.github.com/en/get-started/quickstart/github-flow) \*

## App Contents

The application interface must contain this next screens to be functional.

- Home View
  - Show movies
     - Trending
      - Now Playing
      - Popular
      - Top Rated 
      - Upcoming

- Search movie or person.
  -  Display results by keyword and by query.

- Movie Details View
  - Display the selected movie and its information.
  - Display overview.
  - Display cast.
  - Display similar movies.
  - Display recommended movies.
  - Option to read reviews.

- Reviews View
  - Display reviews

## Deliverables

We provide the delivery dates for you to plan accordingly. Please, take this challenge seriously and try to make progress 
constantly.

It’s worth mentioning that you’ll ONLY get feedback from the review team for your first and second deliverable, so you will have a 
chance to fix or improve the code based on our suggestions.

For the final deliverable, we will provide some feedback, but there is no extra review date. If you are struggling with something, 
we will be happy to help you via the slack channel.

> \*_Important:_ what’s listed in this deliverables is just for guidance and to help you distribute your workload; you can deliver 
more items if necessary.

### First Deliverable 

Build an App from scratch in Swift with the following features:

* Create your own repo with a personal account (github).
* Consume the MovieAPI.
* Apply ALL design principles.

### Second Deliverable 

Using what you've build from previous deliverable:

* Use the MovieAPI to display the movies info.
* Apply Storyboards and nibs on the UI.
* Use a UICollectionView in one of your screens.
* Introduce navigation between your screens.
* Load the images asynchronously.

### Final Deliverable 

Finish any pending functionality or address any comment you receive from your previous deliverables.

* Use protocols for separation of concerns
* Implement NotificationCenter
* Complete all the app requirements


## Submitting the deliverables

For submitting your work, you should follow these steps:

- Create a pull request with your code. 
- Target your main branch of the repository 
[baz-ios-capstone-project-c1-2022](https://github.com/wizelineacademy/baz-ios-capstone-project-c1-2022).


# TheMovieDb API

- Base Url:

```
https://api.themoviedb.org/3
```

- Trending 
[url](https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)

```
/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Now Playing 
[url](https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Popular [url](https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Top Rated 
[url](https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US)
```
/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US
```

- Upcoming [url](https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Keyword [url](https://api.themoviedb.org/3/search/keyword?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&query=Matrix)
```
/search/keyword?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&query=Matrix
```

- Search 
[url](https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=2&query=Matrix%20)
```
/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=2&query=Matrix%20
```

- Reviews [url](https://api.themoviedb.org/3/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&language=en-US)
```
/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&language=en-US
```

- Similar movies [url](https://api.themoviedb.org/3/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en)
```
/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en
```

- Recommendations 
[url](https://api.themoviedb.org/3/movie/603/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en)
```
/movie/603/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en
```


> \*_Important:_ Don't forget to include any additional information that might be necessary for running your code (for example, 
test user credentials, etc).

