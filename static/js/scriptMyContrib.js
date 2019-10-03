// Our labels along the x-axis
// For drawing the lines
// var articlesPublished = [86,114,106,106,107,2,133,221,783,1123,1345,1634];
// var articlesContributed = [282,350,411,502,635,5,947,1102,1400,1267,1674,1987];


var ctx = document.getElementById("myChart");
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
    labels: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
    datasets: [
            {
                data: articles,
                label: "Articles",
                backgroundColor: '#ffb3c3',
                borderColor: '#ff6687',
                borderWidth: 1,
                fill: false
            },
            {
                data: images,
                label: "Images",
                backgroundColor: '#99e6ff',
                borderColor: '#00ace6',
                borderWidth: 2,
                fill: false
            },
            {
                data: audio,
                label: "Audio",
                backgroundColor: '#f8906d',
                borderColor: '#f4450b',
                borderWidth: 2,
                fill: false
            },
            {
                data: video,
                label: "Video",
                backgroundColor: '#f9da85',
                borderColor: '#f7cc55',
                borderWidth: 2,
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
