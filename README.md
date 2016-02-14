Swiss Pairing Version 1.0 created on 13.02.2016


General Usage:
This code will help you to keep track of your Swiss system tournament.



Table of contents

Installing
Quick start
What´s included?
Bugs and feature requests
Creators + Contact
Licence and Copyright

Installing
The program itself does not need to be installed. However, keep in mind
the program is written in Python 2.7 on a Windows machine. The whole code was executed within a Vagrant Virtual Machine.

Quick Start:

In order to run the program you need to be in the right directory in Vagrant. 
At this point you have the following 2 ways of using these files: 
Firstly, you could type psql in Vagrant in order to write in PostgreSQL and then do \i tournament.sql which will import the database scheme. From now on you can use (or apply select, update, insert, delete to) the database scheme independently from the Python files.
Secondly, you can just type python tournament_test.py which will automatically set up a database scheme for you and then execute the Python code which will use this database scheme. 

So what do you need to run the programm? 
You need to set up Python + Vagrant Virtual Machine. For testing/customizing the code it might be helpful to use the psql command line interface. 

What's included

Within the download you will find the following directories and files:

Project2/
├── tournament_test.py
├── tournament.sql
└── tournament.py

If you run tournament_test.py(is the client-program), you will use the functions written in tournament.py. 
tournament.py provides access to the database via a library of functions which can add, delete or query data in the database to tournament_test.py.
The basic structure of the database schema, however, is visible in tournament.sql.

Bugs and feature requests

I have not found any. If you do so, please contact me!

Creators + Contact
Creator of tournament.sql and partly responsible for tournament.py
Name: Nojan Nourbakhsh
Email: nojan@hotmail.de 
Creator of tournament_test.py and partly responsible for tournament.py
Udacity
Email: review-support@udacity.com

Licence and Copyright
All rights reserved by Udacity Inc and Nojan Nourbakhsh. Swiss Pairing Version 1.0 and its use are subject to a licence agreement and are also subject to copyright, trademark, patent and/or other laws. For further infos, please contact Udacity Inc.
