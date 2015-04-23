$(function() {
  var w = 600;
  var h = 250;

  var emissionsSummary = "http://localhost:3000/usages.json";
  $.getJSON(emissionsSummary, function (emissionsSummary) {

    var dataset = emissionsSummary.Data;

    var xScale = d3.scale.ordinal()
                   .domain(d3.range(dataset.length))
                   .rangeRoundBands([0, w], 0.05);

    var yScale = d3.scale.linear()
                   .domain([0, d3.max(dataset, function(d) {
                     return d.Value;
                   })])
                   .range([0,h]);
    var key = function(d) {
      return d.Date;
    };

    var svg = d3.select("#chart")
                .append("svg")
                .attr("width", w)
                .attr("height", h);

    svg.selectAll("rect")
       .data(dataset)
       .enter()
       .append("rect")
       .attr("x", function (d, i) {
         return xScale(i);
       })
       .attr("y", function(d) {
         return h - yScale(d.Value);
       })
       .attr("width", xScale.rangeBand())
       .attr("height", function(d) {
         return yScale(d.Value);
       })
       .attr("fill", "teal");

    svg.selectAll("text")
       .data(dataset)
       .enter()
       .append("text")
       .text(function(d) {
         return d.Value;
       })
       .attr("text-anchor", "middle")
       .attr("x", function (d, i) {
         return xScale(i) + xScale.rangeBand() / 2;
       })
       .attr("y", function (d) {
         return h - yScale(d.Value) + 14;
       })
       .attr("font-family", "sans-serif")
       .attr("font-size", "11px")
       .attr("fill", "white");

  });
});
