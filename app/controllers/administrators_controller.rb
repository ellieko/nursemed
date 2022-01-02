class AdministratorsController < ApplicationController
  def stats
    @meetings = Meeting.all

    data = @meetings.group_by_day(:start).count.to_a

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => 'Number of Meetings')
      f.xAxis(:type => 'datetime',
              :title => {
                text: 'Date'
              })
      f.yAxis(:title => {
        text: 'Values'
      })
      f.series(:name => 'Value',
               :data => data.map {|key, value| [key.to_time.to_i * 1000, value]})

      f.chart({:defaultSeriesType => 'line'})
    end

    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
        backgroundColor: {
          linearGradient: [0, 0, 500, 500],
          stops: [
            [0, "rgb(255, 255, 255)"],
            [1, "rgb(240, 240, 255)"]
          ]
        },
        borderWidth: 2,
        plotBackgroundColor: "rgba(255, 255, 255, .9)",
        plotShadow: true,
        plotBorderWidth: 1
      )
      f.lang(thousandsSep: ",")
      f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
    end
  end
end
