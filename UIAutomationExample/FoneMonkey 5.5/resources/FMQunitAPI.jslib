
/* This file is part of FoneMonkey.

FoneMonkey is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

FoneMonkey is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with FoneMonkey.  If not, see <http://www.gnu.org/licenses/>.  */
//
//  FMQunitAPI.jslib
//  FoneMonkey
//
//  Copyright 2011 Gorilla Logic, Inc. All rights reserved.
//

function CommandList(){
this.count = 0;
this.dataCount = 0;
this.array = new Array();
this.add = function() {
var command = "";
var component = "";
var monkeyId = "";
var args = new Array();

for(var i = 0; i < this.add.arguments.length; i++)
{
FMObjConnect.connect(this.add.arguments[i]);
if (i == 0) 
command = this.add.arguments[i];
else if (i == 1) 
component = this.add.arguments[i];
else if (i == 2) 
monkeyId = this.add.arguments[i];
else 
args[i-3] = this.add.arguments[i];
}

if (command == "DataDrive")
{
this.driverCount();
}

this.array[this.count] = [command,component,monkeyId, "500", "0",args];
this.count++;
};

this.addRetry = function() {
var command = "";
var component = "";
var monkeyId = "";
var playback = "";
var timeout = "";
var args = new Array();

for(var i = 0; i < this.addRetry.arguments.length; i++)
{
FMObjConnect.connect(this.addRetry.arguments[i]);
if (i == 0) 
command = this.addRetry.arguments[i];
else if (i == 1) 
component = this.addRetry.arguments[i];
else if (i == 2) 
monkeyId = this.addRetry.arguments[i];
else if (i == 3) 
playback = this.addRetry.arguments[i];
else if (i == 4) 
timeout = this.addRetry.arguments[i];
else 
args[i-5] = this.addRetry.arguments[i];
}

if (command == "DataDrive")
{
this.driverCount();
}

this.array[this.count] = [command,component,monkeyId,playback,timeout,args];
this.count++;
};

this.addGet = function(component,monkeyId,property,variable) {
this.array[this.count] = ["GetVariable",component,monkeyId, "0", "0",[property,variable]];
this.count++;
};
this.addDriver = function(file) {
this.driverCount();
this.array[this.count] = ["DataDrive","","", "0", "0",[file]];
this.count++;
};
this.driverCount = function() {
FMObjConnect.connect("DataDrive","", function (response){
FM.dataCount = response;
});
};
this.play = function(func) {
FM.wasPlayCalled = true;
FM.currentList = this;
FMObjConnect.connect("FMPlayCommands",this.array,
function (response){
if (response == 'success') {
ok(true,"Test Successful ");

if (FM.currentCount < FM.dataCount - 1) {
dataDrive = FMDrive;
FM.wasPlayCalled = false;
dataDrive();
FM.currentCount++;
} else {
if (FM.dataCount > 0)
{
FM.currentCount = 0;
FM.dataCount = 0;
start();
}
}

if (func) {
FM.wasPlayCalled = false;
func();
}
} else {
equals( response, 'success', 'Test Failed ');
}

if (FM.dataCount == 0 && (!func || FM.wasPlayCalled == false)) 
start();
}
);
};
}

function FMDrive(){
FM.currentList.play();
}

var FM = {
commandList: new CommandList(),
wasPlayCalled: new Boolean(),
currentList: new CommandList(),
currentCount: 0,
dataCount: 0
};