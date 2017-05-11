var stones = []
var running = true

function stonePlaced(stoneComponent, parent)
{
    if(running) {
        var stone = stoneComponent.createObject(parent);
        stone.startDetection()
        stones.push(stone);
        console.log("added stone to list: # of stone=" + stones.length)
    }
}

// handle colorDetected event
function colorDetected(color, trayId, position)
{

    var handled = false
    var index = 0
    while(index < stones.length) {
        var stone = stones[index]
        if(stone) {
            if(stone.handleColorDetected(color, trayId, position)) {
                handled = true
                break;
            }
        }
        index++
    }
    if(!handled) {
        console.log("WARNING: colorDetected event was not handled!")
    }
}

// handle detectorEndReached event
function detectorEndReached() {
    var handled = false
    var index = 0
    while(index < stones.length) {
        var stone = stones[index]
        if(stone) {
            if(stone.handleDetectorEndReached()) {
                handled = true
                break;
            }
        }
        index++
    }
    if(!handled) {
        console.log("WARNING: detectorEndReached event was not handled!")
    }
}

// handle startEjecting event
function startEjecting(trayId)
{
    var handled = false
    var index = 0
    while(index < stones.length) {
        var stone = stones[index]
        if(stone) {
            if(stone.handleStartEjecting(trayId)) {
                handled = true
                break;
            }
        }
        index++
    }
    if(!handled) {
        console.log("WARNING: detectorEndReached event was not handled!")
    }
}

// handle trayReached event
function trayReached(trayId)
{
    var handled = false
    var index = 0
    while(index < stones.length) {
        var stone = stones[index]
        if(stone) {
            if(stone.handleTrayReached(trayId)) {
                handled = true
                break;
            }
        }
        index++
    }
    if(!handled) {
        console.log("WARNING: trayReached event was not handled!")
    }
}

// removes all stones in the given tray
function removeStonesFromTray(trayId) {
    var index = 0
    while(index < stones.length) {
        var stone = stones[index]
        if(stone) {
            if(stone.handleReachedTray(trayId)) {
                stones.splice(index, 1)
                console.log("INFO: handled removeStonesFromTray on tray #" + trayId + " .... remaining " + stones.length)
                stone.destroy()
                continue
            }
        }
        index++
    }
}

// removes the given stone
function removeStone(stoneToRemove) {
    var index = stones.indexOf(stoneToRemove)
    if(index >= 0) {
        stones.splice(index, 1)
        stoneToRemove.destroy()
        console.log("INFO: handled removeStone .... remaining " + stones.length)
    }
}

// removes all stones from the list
function removeAllStones()
{
    while(stones.length > 0) {
        var stone = stones[0]
        stones.splice(0, 1)
        console.log("INFO: handled removeAllStones .... remaining " + stones.length)
        stone.destroy()
    }
    console.assert(0 == stones.length, "stone list is not empty after removeAllStones!");
}

function shutdown() {
    if(running) {
        running = false
        // remove all stones
        for(var index = 0; index < stones.length; index++) {
            stones[index].destroy();
        }
    }
}
