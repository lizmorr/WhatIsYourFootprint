$(function() {
    var emissionsSummary = '/usages.json';
    if($("#chart").length > 0) {
      $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: emissionsSummary + window.location.search,
        dataType: 'json',
        success: function (data) {
          draw(data);
        },
        error: function (result) {
          error();
        }
      });

      function draw(emissionsSummary) {
          var data = emissionsSummary.Data;

          var margin = {top: 40, right: 40, bottom: 40, left: 40},
              w = 720,
              h = 520;

          var printDate = d3.time.format("%m/%d");
          var printMonth = d3.time.format("%B");

          var barPadding = 1;

          var minDate = d3.min(data, function(d) {
            return d.Date;
          });

          var maxDate = d3.max(data, function(d) {
            return d.Date;
          });

          console.log(minDate + " - " + maxDate);

          if (data.length <= 15) {
            var dateTicksType = d3.time.days;
            var dateLabelFormat = printDate;
          } else if (data.length <= 90) {
            var dateTicksType = d3.time.weeks;
            var dateLabelFormat = printDate;
          } else {
            var dateTicksType = d3.time.months;
            var dateLabelFormat = printMonth;
          }

          var x = d3.time.scale()
              .domain([new Date(data[0].Date),
                  d3.time.day.offset(new Date(data[data.length - 1].Date), 1)])
              .rangeRound([0, w - margin.left - margin.right]);

          var y = d3.scale.linear()
              .domain([0, d3.max(data, function(d) { return d.Value; })])
              .range([h - margin.top - margin.bottom, 0]);

          var xAxis = d3.svg.axis()
              .scale(x)
              .orient('bottom')
              .ticks(dateTicksType)
              .tickFormat(dateLabelFormat)
              .tickPadding(8);

          var yAxis = d3.svg.axis()
              .scale(y)
              .orient('left')
              .tickPadding(8);

          var svg = d3.select('#chart').append('svg')
              .attr('class', 'chart')
              .attr('width', w)
              .attr('height', h)
            .append('g')
              .attr('transform', 'translate(' + margin.left + ', ' + margin.top + ')');

          svg.selectAll('.chart')
              .data(data)
            .enter().append('rect')
              .attr('class', 'bar')
              .attr('x', function(d) {
                  return x(new Date(d.Date));
              })
              .attr('y', function(d) {
                  return h - margin.top - margin.bottom - (h - margin.top - margin.bottom - y(d.Value));
              })
              .attr('width', function(d) {
                return ((w - margin.left - margin.right) / data.length) - barPadding;
              })
              .attr('height', function(d) {
                  return h - margin.top - margin.bottom - y(d.Value);
              });

          svg.append('g')
             .attr('class', 'x axis')
             .attr('transform', 'translate(0, ' + (h - margin.top - margin.bottom) + ')')
             .call(xAxis);

          svg.append('g')
             .attr('class', 'y axis')
             .call(yAxis);

          svg.append("text")
             .attr("class", "title")
             .attr("x", (w / 2))
             .attr("y", 0 - (margin.top / 2))
             .attr("text-anchor", "middle")
             .text("Daily Emissions from " + minDate + " - " + maxDate);

    };
  }
});
