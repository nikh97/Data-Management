# QUERIES

## 1. find all the scooters with a speed of 30

'''

###

db.scooters.find({'max_speed': 30})
{ "_id" : ObjectId("5c0af50286579d9e3825b3d0"), "acquired_date" : "2014-01-02", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3d6"), "acquired_date" : "2018-06-28", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3d8"), "acquired_date" : "2015-03-10", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3da"), "acquired_date" : "2014-11-14", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3de"), "acquired_date" : "2014-12-02", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e1"), "acquired_date" : "2017-03-02", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e3"), "acquired_date" : "2016-03-09", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3f4"), "acquired_date" : "2017-03-07", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3f7"), "acquired_date" : "2016-10-01", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b400"), "acquired_date" : "2016-04-03", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b402"), "acquired_date" : "2015-10-28", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b405"), "acquired_date" : "2018-06-03", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b407"), "acquired_date" : "2017-12-18", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b408"), "acquired_date" : "2014-03-01", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b409"), "acquired_date" : "2018-01-21", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }
{ "_id" : ObjectId("5c0af50286579d9e3825b40c"), "acquired_date" : "2014-11-07", "retired" : false, "scooter_type" : "Scoot Lite v2", "max_speed" : 30, "weight" : 10, "manufacturer" : "Super Fast Co", "website" : "superfast.lol" }

'''

## 2. this query gets the weight and manufacturer of the scooters with weights of 15 

'''

###

> db.scooters.find({'weight': 15}, {'weight': 1, 'manufacturer': 1, _id: 0}).limit(10)
{ "weight" : 15, "manufacturer" : "Scooty" }
{ "weight" : 15, "manufacturer" : "Super Fast Co" }
{ "weight" : 15, "manufacturer" : "Super Fast Co" }
{ "weight" : 15, "manufacturer" : "Scooty" }
{ "weight" : 15, "manufacturer" : "Super Fast Co" }
{ "weight" : 15, "manufacturer" : "Super Fast Co" }
{ "weight" : 15, "manufacturer" : "Scooty" }
{ "weight" : 15, "manufacturer" : "Super Fast Co" }
{ "weight" : 15, "manufacturer" : "Super Fast Co" }
{ "weight" : 15, "manufacturer" : "Super Fast Co" }

'''

## 3. This finds a "MF Doom v5" scooter type acquired on July 1st, 2015


'''

###

db.scooters.find({'scooter_type': "MF Doom v5", 'acquired_date': "2015-07-01"}, {_id: 0})
{ "acquired_date" : "2015-07-01", "retired" : false, "scooter_type" : "MF Doom v5", "max_speed" : 45, "weight" : 20, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }

'''

## 4. this finds all scooters with speeds less than 30

'''

###

> db.scooters.find({'max_speed': {$lt: 30}})
{ "_id" : ObjectId("5c0af50286579d9e3825b3c9"), "acquired_date" : "2017-09-21", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3d3"), "acquired_date" : "2016-12-01", "retired" : false, "scooter_type" : "the tourist v3", "max_speed" : 27, "weight" : 18, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3d9"), "acquired_date" : "2017-07-25", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e4"), "acquired_date" : "2015-08-21", "retired" : false, "scooter_type" : "the tourist v3", "max_speed" : 27, "weight" : 18, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e7"), "acquired_date" : "2017-11-26", "retired" : false, "scooter_type" : "the tourist v3", "max_speed" : 27, "weight" : 18, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e8"), "acquired_date" : "2017-12-09", "retired" : false, "scooter_type" : "the tourist v3", "max_speed" : 27, "weight" : 18, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3ed"), "acquired_date" : "2016-01-12", "retired" : false, "scooter_type" : "the tourist v3", "max_speed" : 27, "weight" : 18, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3ee"), "acquired_date" : "2014-12-12", "retired" : false, "scooter_type" : "the tourist v3", "max_speed" : 27, "weight" : 18, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3ef"), "acquired_date" : "2018-01-11", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3fe"), "acquired_date" : "2016-07-27", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b401"), "acquired_date" : "2014-09-26", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b40d"), "acquired_date" : "2015-02-06", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
> 

'''

## 5. Find the scooters from Scootz LTD or are of type relaxer v8

'''

###

> db.scooters.find({"$or": [ {'manufacturer': 'Scootz LTD'}, {'scooter_type': 'relaxer v8'}]})
{ "_id" : ObjectId("5c0af50286579d9e3825b3c8"), "acquired_date" : "2016-01-03", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3c9"), "acquired_date" : "2017-09-21", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3ca"), "acquired_date" : "2015-01-04", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3cb"), "acquired_date" : "2015-07-01", "retired" : false, "scooter_type" : "MF Doom v5", "max_speed" : 45, "weight" : 20, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3cc"), "acquired_date" : "2016-05-16", "retired" : false, "scooter_type" : "MF Doom v5", "max_speed" : 45, "weight" : 20, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3ce"), "acquired_date" : "2016-03-01", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3cf"), "acquired_date" : "2017-12-27", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3d1"), "acquired_date" : "2017-09-02", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3d2"), "acquired_date" : "2018-05-22", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3d5"), "acquired_date" : "2018-06-14", "retired" : false, "scooter_type" : "MF Doom v5", "max_speed" : 45, "weight" : 20, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3d9"), "acquired_date" : "2017-07-25", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3dc"), "acquired_date" : "2015-09-09", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3dd"), "acquired_date" : "2014-06-03", "retired" : false, "scooter_type" : "MF Doom v5", "max_speed" : 45, "weight" : 20, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3df"), "acquired_date" : "2014-12-21", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e0"), "acquired_date" : "2018-11-25", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e2"), "acquired_date" : "2018-07-27", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e5"), "acquired_date" : "2017-09-11", "retired" : false, "scooter_type" : "MF Doom v5", "max_speed" : 45, "weight" : 20, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e6"), "acquired_date" : "2016-01-24", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3e9"), "acquired_date" : "2018-11-22", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3eb"), "acquired_date" : "2015-06-16", "retired" : false, "scooter_type" : "MF Doom v5", "max_speed" : 45, "weight" : 20, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
Type "it" for more
> it
{ "_id" : ObjectId("5c0af50286579d9e3825b3ef"), "acquired_date" : "2018-01-11", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3f5"), "acquired_date" : "2018-03-25", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3f6"), "acquired_date" : "2014-06-12", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3f8"), "acquired_date" : "2018-06-16", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3f9"), "acquired_date" : "2016-01-07", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3fc"), "acquired_date" : "2017-04-28", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3fd"), "acquired_date" : "2018-07-08", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b3fe"), "acquired_date" : "2016-07-27", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b401"), "acquired_date" : "2014-09-26", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }
{ "_id" : ObjectId("5c0af50286579d9e3825b403"), "acquired_date" : "2014-10-09", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b406"), "acquired_date" : "2017-06-02", "retired" : false, "scooter_type" : "shaolin shadowboxer v2", "max_speed" : 40, "weight" : 25, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b40a"), "acquired_date" : "2016-09-01", "retired" : false, "scooter_type" : "A tribe called quest v7", "max_speed" : 35, "weight" : 10, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b40b"), "acquired_date" : "2016-06-21", "retired" : false, "scooter_type" : "MF Doom v5", "max_speed" : 45, "weight" : 20, "manufacturer" : "Scootz LTD", "website" : "scootz.jp" }
{ "_id" : ObjectId("5c0af50286579d9e3825b40d"), "acquired_date" : "2015-02-06", "retired" : false, "scooter_type" : "relaxer v8", "max_speed" : 25, "weight" : 15, "manufacturer" : "Scooty", "website" : "scooty.nyu" }

'''
