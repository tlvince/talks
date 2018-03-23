---
title: Disconnected World
author: \@tlvince
date: 2018-03-18
---

* Sort of an expert piece talk format, but want to move more towards passing on learnings
* Structured in the "powers of three" form
  * 5 mins per section
  * 5 mins for intro, questions etc.

# Possible titles

1. Aeroplane mode
2. Offline dinosaur (Chrome design language)
3. (Offline dinosaur): there is no internet connection
4. (Offline dinosaur): unable to connect to the internet
5. Offline First
6. How to democratise the internet
7. The world isn't as connected as you think
8. Why offline matters
9. Unconnected world
10. You are offline

# 1. Designing for the next billion

## Background

* 90% of the UK is connected, but <20% in Sub-Saharan Africa
* The game is changing: lower costs, lower barriers, proliferation of cheap devices
* These people are coming online for the first time
* These users are not necessarily young millennials
* What learnings can we apply from developing for habitually connected people?

## Learnings

* We can't keep building things with the mindset that the internet is always there
* Limited access to the internet forces us to think about designing for offline
* Lack of stable internet and performant devices forces us to design within more constraints
* Gives us the chance to rethink; back to first principles

## Case studies

### Field

* Design out in the field with users, not in board rooms

### HAT

* Break up long forms
* Big selectable elements, not long, fancy drop downs
* Why did we ever think animated form inputs were a good idea?

### VAN

* Build trust
* Communicate offline states
* Allow people to try things out; show clear undo steps

# 2. Offline can be seamless

## Background

* Lack of internet should not be considered an error
* It happens all the time to everyone:
  * In the tube
  * Flights
  * In conferences where too many people are connected at once
* 4G is not as pervasive as you think

## Learnings

* Network connectivity is intermittent at best. Deal with it.
* Lack of internet should not be considered an error
* It should be considered just another state
* Our products/projects should just seamlessly work offline
* But we have to develop trust
  * Will my data still be saved offline?
  * Will my data still be secure?
  * Clear communication

## Case studies

### Ebola contact tracing

* Some of the remotest places imaginable
* Gather data offline, seamlessly and opportunistically sync whenever possible

### Instagram

* Can upload, comment on, perform any actions as usual, but queued
* Access to the network is prioritised by task, importance to the user

### Direct Delivery

* Drivers out on the road for ages
* Store offline, sync P2P

# 3. Offline first is a social movement

## Background

* How many times have you seen “Error Establishing A Database Connection" (Wordpress error)
  * Centralised, single point of failure
* People are becoming more de-sensitised to decentralised, distributed systems
  * Bitcoin, blockchain
* What happens when your favourite unicorn startup is bought or shut down?
  * Where does my data go? Can I still access it?

## Learnings

* Offline first is an enabler
* It offers universal access to the internet regardless of how good your connection is
* Democratises data

## Case studies

### Nav

* Data mandated by government that it should be hosted in country
* Distributed system problem; decentralised data storage

### Forth

* Offline enables job creation

### Ebola call centre

* In-house data collection for performance
* Synced back to the mothership for analysis
