class DummyController < ApplicationController
  def index
    @wait = {
      :wait => 8,
      :friends => ["Steven", "Kelly", "Vincent"],
      :date => Date.new(2013,3,6).to_s,
      :notes => "Table by the window"
    }
    
    render json: @wait
  end
end
