class CalculationsController < ApplicationController
include Math

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]




    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(' ','').length

    @word_count = @text.split(' ').length

    @occurrences = @text.scan(@special_word).length

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    @rate=(@apr/12/100)

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@principal*@rate*(1+@rate)**(12*@years))/((1+@rate)**(12*@years)-1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]

    @range = @maximum-@minimum

    sorted = @numbers.sort
    len = sorted.length

    @median = (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0

    @sum = @numbers.inject{|sum,x| sum + x }

    @mean = @numbers.inject{ |sum, el| sum + el }.to_f / @numbers.size

    @variance = @numbers.inject(0.0) {|s,x| s + (x - @mean)**2}

    @standard_deviation = Math.sqrt(@variance)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @numbers.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
