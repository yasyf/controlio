# Controlio

Controlio is a simple service which allows you to control your computer via SMS **and voice**. With one simple registration step, you no longer have to be bound to your clunky machine for on-the-go operations. No more running out of the house, only to remember you forgot to do something on your computer!

## Setup

Install the gem with `gem install controlio`. Run the setup with `controlio-setup`. Once you're set up, you can launch the client at any point with `controlio`, or `controlio-daemon` to automatically background it.

## Screenshots

![Demo 1](http://cl.ly/XsUb/IMG_1775.PNG)
![Demo 2](http://cl.ly/XtOz/IMG_1776.PNG)
![Demo 3](http://cl.ly/XsJy/IMG_1777.PNG)

## Commands

Commands are located in the [commands](commands/) folder. Each command must implement `initialize(*args)`, `go`, `respond`, `media?`, and `matches`.

#### Hello World

Computer says "Hello, World!" and responds with the same text.

#### Lock

Computer locks its screen and notifies you that it has done so.

#### Open

Takes a URI as a parameter. Computer opens the URI as appropriate.

#### Play

Takes an optional name of an appliction as a parameter. Computer plays the media in the given or default application, and notifies you of the name of the currently playing media.

#### Pause

Takes an optional name of an appliction as a parameter. Computer pauses the media in the given or default application.

#### Say

Takes a sentence as a parameter. Computer says the given sentence.

#### Type

Takes a sentence as a parameter. Computer types out the given sentence.

#### Screenshot

Computer takes a screenshot and returns it to you.

#### Picture

Computer takes a picture with the built-in webcam and returns it to you.

#### Set Volume

Takes an integer between 0 and 100 as a parameter. Computer sets its volume to the interger provided.

#### Cat

????
