$(function() {

    var emissionsSummary = "http://localhost:3000/usages.json";
    $.getJSON(emissionsSummary, function (emissionsSummary) {
        var data = emissionsSummary.Data;

        var margin = {top: 10, right: 40, bottom: 40, left:40},
            width = 600,
            height = 500;

        var x = d3.time.scale()
            .domain([new Date(data[0].Date), d3.time.day.offset(new Date(data[data.length - 1].Date), 1)])
            .rangeRound([0, width - margin.left - margin.right]);

        var y = d3.scale.linear()
            .domain([0, d3.max(data, function(d) { return d.Value; })])
            .range([height - margin.top - margin.bottom, 0]);

        var xAxis = d3.svg.axis()
            .scale(x)
            .orient('bottom')
            .ticks(d3.time.weeks)
            .tickPadding(8);

        var yAxis = d3.svg.axis()
            .scale(y)
            .orient('left')
            .tickPadding(8);

        var svg = d3.select('#chart').append('svg')
            .attr('class', 'chart')
            .attr('width', width)
            .attr('height', height)
          .append('g')
            .attr('transform', 'translate(' + margin.left + ', ' + margin.top + ')');

        svg.selectAll('.chart')
            .data(data)
          .enter().append('rect')
            .attr('class', 'bar')
            .attr('x', function(d) { return x(new Date(d.Date)); })
            .attr('y', function(d) { return height - margin.top - margin.bottom - (height - margin.top - margin.bottom - y(d.Value)) })
            .attr('width', 10)
            .attr('height', function(d) { return height - margin.top - margin.bottom - y(d.Value) });

        svg.append('g')
            .attr('class', 'x axis')
            .attr('transform', 'translate(0, ' + (height - margin.top - margin.bottom) + ')')
            .call(xAxis);

        svg.append('g')
          .attr('class', 'y axis')
          .call(yAxis);

  });
});
