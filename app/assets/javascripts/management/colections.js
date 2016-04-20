//Configurações de gráficos PIE
// //mais infos: www.chartjs.org/docs/
var data_colections = [
    {
        value: 92,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "Matemática"
    },
    {
        value: 57,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "História"
    },
    {
        value: 78,
        color: "#FDB45C",
        highlight: "#FFC870",
        label: "Língua Portuguesa"
    },
    {
        value: 43,
        color: "#FAAAAA",
        highlight: "#FBBBBB",
        label: "Física"
    },
    {
        value: 3,
        color: "#876543",
        highlight: "#887766",
        label: "Artes"
    },
    {
        value: 40,
        color: "#B3F8A1",
        highlight: "#BBFABB",
        label: "Sociologia"
    }

];





var pie_options = {
    //Boolean - Whether we should show a stroke on each segment
    segmentShowStroke : true,

    //String - The colour of each segment stroke
    segmentStrokeColor : "#fff",

    //Number - The width of each segment stroke
    segmentStrokeWidth : 2,

    //Number - The percentage of the chart that we cut out of the middle
    percentageInnerCutout : 0, // This is 0 for Pie charts

    //Number - Amount of animation steps
    animationSteps : 100,

    //String - Animation easing effect
    animationEasing : "easeOutBounce",

    //Boolean - Whether we animate the rotation of the Doughnut
    animateRotate : true,

    //Boolean - Whether we animate scaling the Doughnut from the centre
    animateScale : false,

    //String - A legend template
    legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"

};
