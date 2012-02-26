
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
//  FMObjConnect.jslib
//  FoneMonkey
//
//  Copyright 2011 Gorilla Logic, Inc. All rights reserved.
//

var FMObjConnect = {
    responseFunctions : new Array(),

    connect : function connect(functionName, args, returnFunc) {

        if (returnFunc && typeof returnFunc == "function")
            FMObjConnect.responseFunctions[functionName] = returnFunc;

        var iFrame = document.createElement("iframe");
        iFrame.setAttribute("src", "objconnect:" + functionName + ":" + encodeURIComponent(JSON.stringify(args)));
        document.documentElement.appendChild(iFrame);
        iFrame.parentNode.removeChild(iFrame);
        iFrame = null;
    },

    result : function result(functionName, results) {
        try {
            var responseFunction = FMObjConnect.responseFunctions[functionName];
            if (!responseFunction)
                return;

            responseFunction.apply(null,results);
        } catch(error) {
            alert(error)
        }
    }
};