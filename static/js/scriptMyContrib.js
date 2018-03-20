
var month=["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

var ctx = document.getElementById("myChart").getContext("2d");

var data = {
    
    labels:month,
    datasets: [
        {
            label: "Articles Contributed",
            backgroundColor: "blue",
            data:articlesContributed
            
        },
        {
            label: "Articles Published",
            backgroundColor: "green",
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
