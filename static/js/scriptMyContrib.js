// Our labels along the x-axis
// For drawing the lines
 //var articlesPublished = [86,114,106,106,107,2,133,221,783,1123,1345,1634];
//var articlesContributed = [282,350,411,502,635,5,947,1102,1400,1267,1674,1987];
var label1=["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
/*

var ctx = document.getElementById("myChart");
var myChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
    datasets: [
      {
        data: articlesContributed,
    label: "Articles Contributed",
    backgroundColor: 'rgba(255, 0, 0, 1)',
    borderColor: 'rgba(255, 0, 0, 1)',
    borderWidth: 1,
    fill: false
      },
      {
        data: articlesPublished,
    label: "Articles Published",
    backgroundColor: 'rgba(0, 0, 255, 1)',
    borderColor: 'rgba(0, 0, 255, 1)',
    borderWidth: 1,
    fill: false
      }
    ]
  },
    options: {
        responsive: true,
        title:{
            display:true,
            text:'My Contributions'
        },
        tooltips: {
            mode: 'index',
            intersect: false,
        },
        hover: {
            mode: 'nearest',
            intersect: true
        },
        scales: {
            xAxes: [{
                display: true,
                scaleLabel: {
                    display: true,
                    labelString: 'Month'
                }
            }],
            yAxes: [{
                display: true,
                scaleLabel: {
                    display: true,
                    labelString: 'Value'
                }
            }]
        }
    }
});



//bar
var ctxB = document.getElementById("myChart").getContext('2d');
var myBarChart = new Chart(ctxB, {
    type: 'bar',
    data: {
        labels: ["Articles Contributed", "Articles Published"],
        datasets: [{
            label: 'Articles',
            data: [articlesContributed, articlesPublished,1],
            backgroundColor: [
                'rgba(255, 99, 132, 1.5)',
                'rgba(54, 162, 235, 1.5)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)'
            ],
            borderWidth: 1
        }]
    },
    optionss: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
*/
var ctx = document.getElementById("myChart").getContext("2d");

var data = {
    //labels: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
    labels:label1,
    datasets: [
        {
            label: "Articles Contributed",
            backgroundColor: "blue",
            //data: [3,7,4,6,4,8,2,9,15,11,7,8]
            data:articlesContributed
        },
        {
            label: "Articles Published",
            backgroundColor: "green",
           // data: [4,3,5,2,8,5,3,11,9,7,5,4]
            data:articlesPublished
        },
    
    ]
};

var myBarChart = new Chart(ctx, {
    type: 'bar',
    data: data,
    options: {
        barValueSpacing: 20,
        scales: {
            yAxes: [{
                ticks: {
                    min: 0,
                }
            }]
        }
    }
});