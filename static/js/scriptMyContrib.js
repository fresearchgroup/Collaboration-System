// Our labels along the x-axis
// For drawing the lines
// var articlesPublished = [86,114,106,106,107,2,133,221,783,1123,1345,1634];
// var articlesContributed = [282,350,411,502,635,5,947,1102,1400,1267,1674,1987];


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
