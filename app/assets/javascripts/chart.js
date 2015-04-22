$(function() {
  var w = 600;
  var h = 250;

  var emissionsSummary = "http://localhost:3000/usages.json";
  $.getJSON(emissionsSummary, function (emissionsSummary) {
    var xScale = d3.scale.ordinal()
                   .domain(d3.range(emissionsSummary.length))
                   .rangeRoundBands([0, w], .05);

    var yScale = d3.scale.linear()
                   .domain([0, d3.max(emissionsSummary, function(d) {
                     return d.value;
                   })])
                   .range([0,h]);
    var key = function(d) {
      return d.key;
    };

    var svg = d3.select("#chart")
                .append("svg")
                .attr("width", w)
                .attr("height", h);

    console.log(emissionsSummary);

    svg.selectAll("rect")
       .data(emissionsSummary, key)
       .enter()
       .append("rect")
       .attr("x", function (d, i) {
         return xScale(i);
       })
       .attr("y", function(d) {
         return h - yScale(d.value);
       })
       .attr("width", xScale.rangeBand())
       .attr("height", function(d) {
         return yScale(d.value)
       })
       .attr("fill", "teal")

    svg.selectAll("text")
       .data(emissionsSummary, key)
       .enter()
       .append("text")
       .text(function(d) {
         return d.value;
       })
       .attr("text-anchor", "middle")
       .attr("x", function (d, i) {
         return xScale(i) + xScale.rangeBand() / 2;
       })
       .attr("y", function (d) {
         return h - yScale(d.value) + 14;
       })
       .attr("font-family", "sans-serif")
       .attr("font-size", "11px")
       .attr("fill", "white");

  });
});
