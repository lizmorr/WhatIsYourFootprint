$(function() {

  var emissionsSummary = "http://localhost:3000/usages.json";
  $.getJSON(emissionsSummary, function (emissionsSummary) {

    var margin = {
      top: 0,
      right: 0,
      bottom: 60,
      left: 0
    };

    var w = 600 - margin.left - margin.right;
    var h = 250 - margin.top - margin.bottom;
    var padding = 40;

    var dataset = emissionsSummary.Data;

    var printDate = d3.time.format("%m/%d");

    var xScale = d3.time.scale()
                   .domain([new Date(dataset[0].Date), d3.time.day.offset(new Date(dataset[dataset.length-1].Date),8)])
                   .rangeRound([0, w]);

    var yScale = d3.scale.linear()
                   .domain([0, d3.max(dataset, function(d) {
                     return d.Value;
                   })])
                   .range([h - padding, padding]);

    var key = function(d) {
      return d.Date;
    };

    var svg = d3.select("#chart")
                .append("svg")
                .attr("width", w + margin.left + margin.right)
                .attr("height", h + margin.top + margin.bottom )
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var xAxis = d3.svg.axis()
                  .scale(xScale)
                  .orient("bottom")
                  .ticks(d3.time.sunday);

     svg.selectAll("rect")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("x", function (d) {
          return d.Date;
        })
        .attr("y", function(d) {
          return h - yScale(d.Value);
        })
        .attr("width", (w / dataset.length))
        .attr("height", function(d) {
          return yScale(d.Value);
        })
        .attr("fill", "teal");

     svg.append("g")
        .attr("class", "axis")
        .attr("transform", "translate(0," + (h + 5) + ")")
        .call(xAxis);

     svg.selectAll("text")
        .data(dataset)
        .enter()
        .append("text")
        .text(function(d) {
          return d.Value;
        })
        .attr("text-anchor", "middle")
        .attr("x", function (d, i) {
          return xScale(i) + (w / dataset.length) / 2;
        })
        .attr("y", function (d) {
          return h - yScale(d.Value) + 14;
        })
        .attr("font-family", "sans-serif")
        .attr("font-size", "11px")
        .attr("fill", "white");
  });
});
