
const initialFlights = [
    {
        time: "12:40",
        flight: "CM 2026",
        dest: "Chennai",
        gate: "A11",
        status: "ON TIME"
    },
    {
        time: "13:11",
        flight: "MDU 2036",
        dest: "Madurai",
        gate: "D12",
        status: "GATE CLOSED"
    },
    {
        time: "13:37",
        flight: "OT 1760",
        dest: "Ooty",
        gate: "B20",
        status: "DELAYED"
    }
];

let flights = structuredClone(initialFlights);



const board = document.getElementById("board");
const summary = document.getElementById("summary");
const clock = document.getElementById("clock");
const addBtn = document.getElementById("addBtn");
const resetBtn = document.getElementById("resetBtn");



function createFlightRow(flight){

    
    const row = document.createElement("div");
    row.classList.add("flight-row");

    
    row.dataset.flight = flight.flight;

    
    const time = document.createElement("div");
    time.textContent = flight.time;

    const flightNum = document.createElement("div");
    flightNum.textContent = flight.flight;

    const destination = document.createElement("div");
    destination.textContent = flight.dest;

    const gate = document.createElement("div");
    gate.textContent = flight.gate;

    const status = document.createElement("div");
    status.textContent = flight.status;

    status.classList.add(
        flight.status.toLowerCase().replaceAll(" ", "-")
    );

   
    row.append(
        time,
        flightNum,
        destination,
        gate,
        status
    );

    return row;
}


function renderBoard(){

    board.textContent = "";

    flights.forEach(flight => {

        const row = createFlightRow(flight);

        board.appendChild(row);

    });

    updateSummary();
}



function updateSummary(){

    const total = flights.length;

    const boarding =
        flights.filter(
            f => f.status === "BOARDING"
        ).length;

    const delayed =
        flights.filter(
            f => f.status === "DELAYED"
        ).length;
    const departed = 
        flights.filter (
            f =>f.status === "DEPARTED"
    ).length;

    summary.textContent =
        `${total} departures · ${boarding} boarding · ${delayed} delayed · ${departed} Departed`;
}



function updateClock(){

    const now = new Date();

    clock.textContent =
        now.toLocaleTimeString();
}

updateClock();
setInterval(updateClock,1000);



const sampleFlights = [
    {
        time:"14:50",
        flight:"BA 0286",
        dest:"Kerala",
        gate:"D07",
        status:"ON TIME"
    },
    {
        time:"15:05",
        flight:"NH 0175",
        dest:"Thanjavur",
        gate:"D02",
        status:"ON TIME"
    },
    {
        time:"15:15",
        flight:"CM 0612",
        dest:"Coimbatore",
        gate:"B09",
        status:"BOARDING"
    }
];

addBtn.addEventListener("click", () => {

    const random =
        sampleFlights[
            Math.floor(
                Math.random() *
                sampleFlights.length
            )
        ];

    flights.push({...random});

    const row = createFlightRow(random);

    board.appendChild(row);

    updateSummary();
});



resetBtn.addEventListener("click", () => {

    flights = structuredClone(initialFlights);

    renderBoard();
});



const statusFlow = [
    "ON TIME",
    "BOARDING",
    "GATE CLOSED",
    "DEPARTED"
];

function updateRandomFlight(){

    if(flights.length === 0) return;

    const index =
        Math.floor(
            Math.random() * flights.length
        );

    const flight = flights[index];

    let current =
        statusFlow.indexOf(
            flight.status
        );

    if(current === -1){
        flight.status = "ON TIME";
    }
    else if(current < statusFlow.length - 1){
        flight.status =
            statusFlow[current + 1];
    }

  
    const row = document.querySelector(
        `[data-flight="${flight.flight}"]`
    );

    const statusCell =
        row.children[4];

    statusCell.className = "";

    statusCell.textContent =
        flight.status;

    statusCell.classList.add(
        flight.status
            .toLowerCase()
            .replaceAll(" ","-")
    );
  

    updateSummary();
}

setInterval(
    updateRandomFlight,
    4000
);



renderBoard();