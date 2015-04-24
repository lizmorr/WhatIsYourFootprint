//     var margin = {
//       top: 40,
//       right: 40,
//       bottom: 40,
//       left: 40
//     };
//
//     barPadding = 1;
//
//     var w = 600; //- margin.left - margin.right;
//     var h = 500; // margin.top - margin.bottom;
//     // var padding = 40;
//
//     var dataset = emissionsSummary.Data;
//
//     var printDate = d3.time.format("%m/%d");
//
//     var xScale = d3.time.scale()
//                    .domain([new Date(dataset[0].Date), d3.time.day.offset(new Date(dataset[dataset.length-1].Date),1)])
//                    .rangeRound([0, w - margin.left - margin.right]);
//
//     var yScale = d3.scale.linear()
//         .domain([0, d3.max(dataset, function(d) {
//           return d.Value;
//         })])
//         .range([h, 0]);
//
//     var xAxis = d3.svg.axis()
//         .scale(xScale)
//         .orient("bottom")
//         .ticks(d3.time.weeks);
//
//     var yAxis = d3.svg.axis()
//         .scale(yScale)
//         .orient("left")
//         .tickPadding(8);
//
//     var svg = d3.select("#chart")
//         .append("svg")
//         .attr("class", "chart")
//         .attr("width", w)
//         .attr("height", h)
//         .append("g")
//         .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
//
//      svg.selectAll(".chart")
//         .data(dataset)
//         .enter()
//         .append("rect")
//         .attr("class", "bar")
//         .attr("x", function (d) {
//           return xScale(new Date(d.Date));
//         })
//         .attr("y", function(d) {
//           return h - margin.top - margin.bottom - (h - margin.top - margin.bottom - yScale(d.Value));
//         })
//         .attr("width", 10)// (w / dataset.length) - barPadding)
//         .attr("height", function(d) {
//           return h - margin.top - margin.bottom - yScale(d.Value);
//         })
//         .attr("fill", "teal");
//
//      svg.append("g")
//         .attr("class", "x axis")
//         .attr("transform", "translate(0," + (h - margin.top - margin.bottom) + ")")
//         .call(xAxis);
//
//      svg.append("g")
//         .attr("class", "y axis")
//         .call(yAxis);
//
//
//      svg.selectAll("text")
//         .data(dataset)
//         .enter()
//         .append("text")
//         .text(function(d) {
//           return d.Value;
//         })
//         .attr("text-anchor", "middle")
//         .attr("x", function (d, i) {
//           return xScale(i) + (w / dataset.length) / 2;
//         })
//         .attr("y", function (d) {
//           return h - yScale(d.Value) + 14;
//         })
//         .attr("font-family", "sans-serif")
//         .attr("font-size", "11px")
//         .attr("fill", "white");
