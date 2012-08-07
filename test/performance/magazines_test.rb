require 'test_helper'
require 'rails/performance_test_help'

class MagazinesTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { :runs => 100, :metrics => [:wall_time, :memory],
                           :output => 'tmp/performance', :formats => [:flat] }

  def test_magazines
    get '/api/v1/json/magazines'
  end
end
